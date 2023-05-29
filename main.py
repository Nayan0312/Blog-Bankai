from flask import Flask, render_template, request, session,redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from flask_mail import Mail
from werkzeug.utils import secure_filename
import json
import os
import math


local_server=True
with open('config.json', 'r') as c:
    params=json.load(c)['params']

app = Flask(__name__)
app.secret_key='super_key'
app.config['UPLOAD_FOLDER']=params['upload_location']
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']

)
mail=Mail(app)
if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']
db = SQLAlchemy(app)

class Contacts(db.Model):
    SNo = db.Column(db.Integer, primary_key=True)
    Name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    phone_number = db.Column(db.String(12), nullable=False)
    message = db.Column(db.String(120), nullable=False)
    Date = db.Column(db.String(12), nullable=True)


class Posts(db.Model):
    SNo = db.Column(db.Integer, primary_key=True)
    Title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(20), nullable=False)
    author = db.Column(db.String(12), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    Date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(12), nullable=True)

@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    last=math.ceil(len(posts)/int(params['no_of_posts']))
    page=(request.args.get('page'))
    if(not str(page).isnumeric()):
        page=1
    page=int(page)
    posts=posts[(page-1)*int(params['no_of_posts']):(page-1)*int(params['no_of_posts'])+int(params['no_of_posts'])]
    if(page==1):
        prev='#'
        next='/?page='+str(page+1)
    elif(page==last):
        prev = '/?page=' + str(page - 1)
        next = '#'
    else:
        prev = '/?page=' + str(page - 1)
        next = '/?page=' + str(page + 1)

    return render_template('index.html', params=params, posts=posts,prev=prev, next=next)

@app.route("/uploader", methods=['GET','POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin-user']):
        if (request.method == 'POST'):
            f=request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Uploaded Successfully"


@app.route("/dashboard", methods=['GET','POST'])
def dashboard():

    if('user' in session and session['user']==params['admin-user']):
        posts=Posts.query.all()
        return render_template('dashboard.html',params=params,posts=posts)

    if(request.method=='POST'):
        username=request.form.get('uname')
        userpass=request.form.get('pass')
        if(username==params['admin-user'] and userpass==params['admin-password']):
            session['user']=username
            posts = Posts.query.all()
            return render_template('dashboard.html',params=params,posts=posts)

    return render_template('login.html', params=params)

@app.route("/edit/<string:SNo>", methods=['GET','POST'])
def edit(SNo):
    if ('user' in session and session['user'] == params['admin-user']):
        if (request.method=='POST'):
            box_title=request.form.get('title')
            slug=request.form.get('slug')
            content=request.form.get('content')
            img_file=request.form.get('img_file')
            author='Admin'
            date=datetime.now()
            if SNo=='0':
                post=Posts(Title=box_title, slug=slug, author=author, content=content, img_file=img_file, Date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post=Posts.query.filter_by(SNo=SNo).first()
                post.Title=box_title
                post.slug=slug
                post.author=author
                post.content=content
                post.img_file=img_file
                post.Date=date
                db.session.commit()
                return redirect('/edit/' + SNo)
        post = Posts.query.filter_by(SNo=SNo).first()
        return render_template('edit.html', params=params,post=post, SNo=SNo)

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')

@app.route("/delete/<string:SNo>", methods=['GET','POST'])
def delete(SNo):
    if('user' in session and session['user']==params['admin-user']):
        post=Posts.query.filter_by(SNo=SNo).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')

@app.route("/about")
def about():

    return render_template('about.html',params=params)

@app.route("/contact", methods=['GET','POST'])
def contact():

    if(request.method=='POST'):
        name = request.form.get('name')
        email=request.form.get('email')
        phone=request.form.get('phone')
        message=request.form.get('message')


        entry=Contacts(Name=name,email=email,phone_number=phone,message=message,Date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message("Hi, "+name+" Thank you for contacting us we will answer to your query as soon as possible.", sender=name, recipients=[email],
                          body=message + '\n' + phone
                          )
        mail.send_message(
            "You have a new notification from the blog by "+name,
            sender=name, recipients=[params['gmail-user']],
            body=message + '\n' + phone
            )


    return render_template('contact.html',params=params)

@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()

    return render_template('post.html',params=params, post=post)
app.run(debug=True)



