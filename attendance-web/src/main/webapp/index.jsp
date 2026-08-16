<%@ page import="com.johnnyconsole.attendance.persistence.Course" %>
<%@ page import="java.util.List" %>
<% String pageCategory = "dashboard"; %>
<%@ include file="assets/include/header.jsp" %>

<script>
    window.history.replaceState(null, "", "${pageContext.request.contextPath}/");
</script>

<h2>Attendance Management Console</h2>
<p>Signed in as: <strong><%= user.lastName %>, <%= user.firstName %></strong></p>
<p>Assigned Role(s): <strong><% if(user.isInstructor) { %>Instructor<% } if(user.isInstructor && user.isAdministrator) { %>, <% } if(user.isAdministrator) { %>Administrator <% } %></strong></p><br/>

<% if(user.isInstructor) {
        List<Course> courses = courseDao.findByInstructor(user.username);
        if(!courses.isEmpty()) { %>
            <h2>My Course List</h2>
            <table>
                <tr>
                    <th>Course Identifier</th>
                    <th>Course Name</th>
                </tr>
                <% for(Course course : courses) { %>
                    <tr>
                        <td><%= course.term %> <%= course.subject %>-<%= course.number %>-<%= course.section %></td>
                        <td><%= course.name %></td>
                    </tr>
                <% } %>
            </table>
<%       }
    } %>

<%@ include file="assets/include/footer.jsp" %>