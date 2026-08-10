<%@ page import="com.johnnyconsole.attendance.persistence.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<% User user = (User) session.getAttribute("user"); %>
<html lang="en">
  <head>
    <title>Attendance Management</title>
  </head>
  <body>
    <header>
      <h1>Attendance Management<% if(pageTitle != null) { %>: <%= pageTitle %> <% } %></h1>
    </header>
    <%@ include file="nav.jsp" %>
    <main>