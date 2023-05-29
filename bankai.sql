-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 29, 2023 at 09:28 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bankai`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `SNo` int(50) NOT NULL,
  `Name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_number` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `Date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`SNo`, `Name`, `email`, `phone_number`, `message`, `Date`) VALUES
(1, 'firstname', 'firstpost@gmail.com', '1234567890', 'fist message', '2023-05-17 12:05:32'),
(2, 'Nishit', 'nayanbhargava10@gmail.com', '9932403235', 'Second try', NULL),
(3, 'Nishit Bhargava', 'nayanbhargava10@gmail.com', '9932403235', 'Checking datetime', '2023-05-17 17:53:15'),
(4, 'Nishit', 'hello@gmail.com', '1234567890', 'First mail try.', '2023-05-19 09:23:35'),
(5, 'Nishit', 'hello@gmail.com', '1234567890', 'First mail try.', '2023-05-19 09:24:36'),
(6, 'Nishit', 'hello@gmail.com', '1234567890', 'First mail try.', '2023-05-19 09:51:23'),
(7, 'Nishit Bhargava', '2021uch0022@iitjammu.ac.in', '1234567890', 'Testing the mail part.', '2023-05-29 21:47:14'),
(8, 'Nishit Bhargava', '2021uch0022@iitjammu.ac.in', '1234567890', 'Testing the mail part.', '2023-05-29 21:48:21'),
(9, 'Nishit Bhargava', '2021uch0022@iitjammu.ac.in', '1234567890', 'Testing the mail part.', '2023-05-29 21:57:44'),
(10, 'Nishit Bhargava', '2021uch0022@iitjammu.ac.in', '1234567890', 'Testing the mail part.', '2023-05-29 23:17:57'),
(11, 'Nishit Bhargava', '2021uch0022@iitjammu.ac.in', '1234567890', 'Testing the mail part.', '2023-05-29 23:18:50'),
(12, 'Nishida', '2021uch0022@iitjammu.ac.in', '1234567890', 'Second testing', '2023-05-29 23:19:31'),
(13, 'Nishida', '2021uch0022@iitjammu.ac.in', '1234567890', 'Second testing', '2023-05-29 23:21:52'),
(14, 'Nishida', '2021uch0022@iitjammu.ac.in', '1234567890', 'Second testing', '2023-05-29 23:24:31'),
(15, 'Nishida', '2021uch0022@iitjammu.ac.in', '1234567890', 'Second testing', '2023-05-29 23:25:03');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `SNo` int(50) NOT NULL,
  `Title` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `Content` text NOT NULL,
  `img_file` varchar(12) NOT NULL,
  `Date` datetime NOT NULL DEFAULT current_timestamp(),
  `Author` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`SNo`, `Title`, `slug`, `Content`, `img_file`, `Date`, `Author`) VALUES
(1, 'First post edited', 'first-post', 'This is the content part of the first post.', 'about-bg.jpg', '2023-05-27 12:45:33', 'Admin'),
(2, 'Second Post', 'second-post', 'This is the Second post on my website.', 'about-bg.jpg', '2023-05-29 23:28:38', 'Admin'),
(3, 'Third Post', 'third-post', 'As stated above, any file can be loaded as a template, regardless of file extension. Adding a .jinja extension, like user.html.jinja may make it easier for some IDEs or editor plugins, but is not required. Autoescaping, introduced later, can be applied based on file extension, so you’ll need to take the extra suffix into account in that case.\r\n\r\nAnother good heuristic for identifying templates is that they are in a templates folder, regardless of extension. This is a common layout for projects.', 'about-bg.jpg', '2023-05-29 23:28:54', 'Admin'),
(4, 'Fourth post', 'fourth-post', 'Template variables are defined by the context dictionary passed to the template.\r\n\r\nYou can mess around with the variables in templates provided they are passed in by the application. Variables may have attributes or elements on them you can access too. What attributes a variable has depends heavily on the application providing that variable.\r\n\r\nYou can use a dot (.) to access attributes of a variable in addition to the standard Python __getitem__ “subscript” syntax ([]).\r\n\r\nThe following lines do the same thing:\r\n\r\n{{ foo.bar }}\r\n{{ foo[\'bar\'] }}\r\nIt’s important to know that the outer double-curly braces are not part of the variable, but the print statement. If you access variables inside tags don’t put the braces around them.\r\n\r\nIf a variable or attribute does not exist, you will get back an undefined value. What you can do with that kind of value depends on the application configuration: the default behavior is to evaluate to an empty string if printed or iterated over, and to fail for every other operation.\r\n', 'about-bg.jpg', '2023-05-29 23:29:02', 'Admin'),
(5, 'Fifth Post', 'fifth-post', 'Variables can be modified by filters. Filters are separated from the variable by a pipe symbol (|) and may have optional arguments in parentheses. Multiple filters can be chained. The output of one filter is applied to the next.\r\n\r\nFor example, {{ name|striptags|title }} will remove all HTML Tags from variable name and title-case the output (title(striptags(name))).\r\n\r\nFilters that accept arguments have parentheses around the arguments, just like a function call. For example: {{ listx|join(\', \') }} will join a list with commas (str.join(\', \', listx)).\r\n\r\nThe List of Builtin Filters below describes all the builtin filters.', 'about-bg.jpg', '2023-05-29 23:29:14', 'Admin'),
(6, 'Sixth Post', 'sixth-post', 'Beside filters, there are also so-called “tests” available. Tests can be used to test a variable against a common expression. To test a variable or expression, you add is plus the name of the test after the variable. For example, to find out if a variable is defined, you can do name is defined, which will then return true or false depending on whether name is defined in the current template context.\r\n\r\nTests can accept arguments, too. If the test only takes one argument, you can leave out the parentheses. For example, the following two expressions do the same thing:\r\n\r\n{% if loop.index is divisibleby 3 %}\r\n{% if loop.index is divisibleby(3) %}\r\nThe List of Builtin Tests below describes all the builtin tests.', 'about-bg.jpg', '2023-05-29 23:29:23', 'Admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`SNo`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`SNo`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `SNo` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `SNo` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
