<%@ page import="com.johnnyconsole.attendance.persistence.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<% User user = (User) session.getAttribute("user"); %>
<html lang="en">
  <head>
    <title>Attendance Management</title>
    <link rel="stylesheet" href="/attendance/assets/style/main.css" />
    <link rel="stylesheet" href="/attendance/assets/style/mobile.css" />
  </head>
  <body>
    <header>
      <h1>Attendance Management<% if(pageTitle != null) { %>: <%= pageTitle %> <% } %></h1>
    </header>
    <%@ include file="nav.jsp" %>
    <main>