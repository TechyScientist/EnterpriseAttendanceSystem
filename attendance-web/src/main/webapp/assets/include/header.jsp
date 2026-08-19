<%@ page import="static javax.servlet.http.HttpServletResponse.*" %>
<%@ page import="com.johnnyconsole.attendance.persistence.User" %>
<%@ page import="com.johnnyconsole.attendance.persistence.dao.interfaces.UserDao" %>
<%@ page import="com.johnnyconsole.attendance.persistence.dao.interfaces.CourseDao" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<% User user = (User) session.getAttribute("user");
   UserDao userDao = (UserDao) session.getAttribute("UserDao");
   CourseDao courseDao = (CourseDao) session.getAttribute("CourseDao"); %>
<html lang="en">
  <head>
    <title>Attendance Management</title>
    <link rel="stylesheet" href="assets/style/main.css" />
    <link rel="stylesheet" href="assets/style/mobile.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet" />
  </head>
  <body>
    <header>
      <h1>Attendance Management</h1>
    </header>
    <%@ include file="nav.jsp" %>
    <main>