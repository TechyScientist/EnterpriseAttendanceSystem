<%@ page import="com.johnnyconsole.attendance.persistence.Course" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.time.Instant" %>
<%@ page import="java.util.stream.Collectors" %>
<% String pageCategory = "dashboard"; %>
<%@ include file="assets/include/header.jsp" %>

<!-- TODO Fix date/time display, correct date filters -->

<script>
    window.history.replaceState(null, "", "${pageContext.request.contextPath}/");
</script>

<h2>Attendance Management Console</h2>
<p>Signed in as: <strong><%= user.lastName %>, <%= user.firstName %></strong></p>
<p>Assigned Role(s): <strong><% if(user.isInstructor) { %>Instructor<% } if(user.isInstructor && user.isAdministrator) { %>, <% } if(user.isAdministrator) { %>Administrator <% } %></strong></p><br/>

<% if(user.isInstructor) {
        List<Course> courses = courseDao.findByInstructor(user.username);
        if(!courses.isEmpty()) {
            List<Course> past = courses.stream().filter(course -> course.end.before(Timestamp.from(Instant.now()))).collect(Collectors.toList()),
                    current = courses.stream().filter(course -> course.end.after(Timestamp.from(Instant.now()))).collect(Collectors.toList()),
                    future = courses.stream().filter(course -> course.start.before(Timestamp.from(Instant.now()))).collect(Collectors.toList());
            if(!current.isEmpty()) { %>
                <h2>My Current Courses</h2>
                <table>
                    <tr>
                        <th>Course Identifier</th>
                        <th>Course Name</th>
                        <th>Course Start/End Dates</th>
                        <th>Roster</th>
                    </tr>
                    <% for(Course course : current) { %>
                            <tr>
                                <td><%= course.term %> <%= course.subject %>-<%= course.number %>-<%= course.section %></td>
                                <td><%= course.name %></td>
                                <td>Start: <strong><%= course.start.toLocalDateTime().format(DateTimeFormatter.ofPattern("")) %></strong><br/>End: Start: <strong><%= course.end.toLocalDateTime().format(DateTimeFormatter.ofPattern("")) %></strong></td>
                                <td><form action="" method="post" style="margin: 0;"><button type="submit">Roster <img src="assets/img/proceed.png" alt="Proceed"/></button></form></td>
                            </tr>
<%                  } %>
                </table>
<%          }

            if(!future.isEmpty()) { %>
                <h2>My Future Courses</h2>
                <table>
                    <tr>
                        <th>Course Identifier</th>
                        <th>Course Name</th>
                        <th>Course Start/End Dates</th>
                        <th>Roster</th>
                    </tr>
                    <% for(Course course : current) { %>
                        <tr>
                            <td><%= course.term %> <%= course.subject %>-<%= course.number %>-<%= course.section %></td>
                            <td><%= course.name %></td>
                            <td>Start: <strong><%= course.start.toLocalDateTime().format(DateTimeFormatter.ofPattern("")) %></strong><br/>End: Start: <strong><%= course.end.toLocalDateTime().format(DateTimeFormatter.ofPattern("")) %></strong></td>
                            <td><form action="" method="post" style="margin: 0;"><button type="submit">Roster <img src="assets/img/proceed.png" alt="Proceed"/></button></form></td>
                        </tr>
<%                  } %>
                </table>
<%          }

            if(!past.isEmpty()) { %>
                <h2>My Past Courses</h2>
                <table>
                    <tr>
                        <th>Course Identifier</th>
                        <th>Course Name</th>
                        <th>Course Start/End Dates</th>
                    </tr>
                    <% for(Course course : current) { %>
                            <tr>
                                <td><%= course.term %> <%= course.subject %>-<%= course.number %>-<%= course.section %></td>
                                <td><%= course.name %></td>
                                <td>Start: <strong><%= course.start.toLocalDateTime().format(DateTimeFormatter.ofPattern("")) %></strong><br/>End: Start: <strong><%= course.end.toLocalDateTime().format(DateTimeFormatter.ofPattern("")) %></strong></td>
                            </tr>
<%                  } %>
                </table>
<%          }
        }
    } %>

<%@ include file="assets/include/footer.jsp" %>