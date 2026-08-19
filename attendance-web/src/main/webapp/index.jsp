<%@ page import="com.johnnyconsole.attendance.persistence.Course" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.time.Instant" %>
<%@ page import="java.util.stream.Collectors" %>
<% String pageCategory = "dashboard"; %>
<%@ include file="assets/include/header.jsp" %>

<script>
    window.history.replaceState(null, "", "${pageContext.request.contextPath}/");
</script>

<% int status = response.getStatus();
if(status != SC_OK && status != SC_ACCEPTED) {
    switch(status) {
        case SC_BAD_REQUEST: %>
            <p id="error"><img src="assets/img/error.png" alt="Error" /><strong>Registration Error</strong>: Missing or invalid course or student data.</p>
<%          break;
        case SC_CONFLICT: %>
            <p id="error"><img src="assets/img/error.png" alt="Error" /><strong>Registration Error</strong>: The student with the prox information provided is already registered in this section.</p>
<%          break;
        case SC_NOT_FOUND: %>
            <p id="error"><img src="assets/img/error.png" alt="Error" /><strong>Registration Error</strong>: The course section or student profile provided could not be found. Please check the data and try again.</p>
<%          break;
        case SC_INTERNAL_SERVER_ERROR: %>
            <p id="error"><img src="assets/img/error.png" alt="Error" /><strong>Server Error</strong>: The server could not fulfill your request. Please try again or contact the system administrator.</p>
<%          break;
    }
}
else if(status == SC_ACCEPTED) { %>
    <p id="success"><img src="assets/img/success.png" alt="Success" /><strong>Operation Successful</strong>: Deregistration request completed.</p>
<% } %>

<h2>Attendance Management Console</h2>
<p>Signed in as: <strong><%= user.lastName %>, <%= user.firstName %></strong></p>
<p>Assigned Role(s): <strong><% if(user.isInstructor) { %>Instructor<% } if(user.isInstructor && user.isAdministrator) { %>, <% } if(user.isAdministrator) { %>Administrator <% } %></strong></p><br/>

<% if(user.isInstructor) {
        List<Course> courses = courseDao.findByInstructor(user.username);
        if(!courses.isEmpty()) {
            Timestamp now = Timestamp.from(Instant.now());
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d MMM yyyy");
            List<Course> past = courses.stream().filter(course -> course.end.before(now)).collect(Collectors.toList()),
                    current = courses.stream().filter(course -> course.start.before(now) && course.end.after(now)).collect(Collectors.toList()),
                    future = courses.stream().filter(course -> course.start.after(now)).collect(Collectors.toList());
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
                                <td>Start: <strong><%= course.start.toLocalDateTime().format(formatter) %></strong><br/>End: <strong><%= course.end.toLocalDateTime().format(formatter) %></strong></td>
                                <td>
                                    <form action="GetCourseRosterServlet" method="post" style="margin: 0;">
                                        <input type="hidden" name="term" id="term" value="<%= course.term %>"/>
                                        <input type="hidden" name="subject" id="subject" value="<%= course.subject %>"/>
                                        <input type="hidden" name="number" id="number" value="<%= course.number %>"/>
                                        <input type="hidden" name="section" id="section" value="<%= course.section %>"/>
                                        <button type="submit" name="roster-submit" id="roster-submit">Roster <img src="assets/img/proceed.png" alt="Proceed"/></button>
                                    </form>
                                </td>
                            </tr>
<%                  } %>
                </table><br/>
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
                    <% for(Course course : future) { %>
                        <tr>
                            <td><%= course.term %> <%= course.subject %>-<%= course.number %>-<%= course.section %></td>
                            <td><%= course.name %></td>
                            <td>Start: <strong><%= course.start.toLocalDateTime().format(formatter) %></strong><br/>End: <strong><%= course.end.toLocalDateTime().format(formatter) %></strong></td>
                            <td>
                                <form action="GetCourseRosterServlet" method="post" style="margin: 0;">
                                    <input type="hidden" name="term" id="term" value="<%= course.term %>"/>
                                    <input type="hidden" name="subject" id="subject" value="<%= course.subject %>"/>
                                    <input type="hidden" name="number" id="number" value="<%= course.number %>"/>
                                    <input type="hidden" name="section" id="section" value="<%= course.section %>"/>
                                    <button type="submit" name="roster-submit" id="roster-submit">Roster <img src="assets/img/proceed.png" alt="Proceed"/></button>
                                </form>
                            </td>
                        </tr>
<%                  } %>
                </table><br/>
<%          }

            if(!past.isEmpty()) { %>
                <h2>My Past Courses</h2>
                <table>
                    <tr>
                        <th>Course Identifier</th>
                        <th>Course Name</th>
                        <th>Course Start/End Dates</th>
                        <th>Roster</th>
                    </tr>
                    <% for(Course course : past) { %>
                            <tr>
                                <td><%= course.term %> <%= course.subject %>-<%= course.number %>-<%= course.section %></td>
                                <td><%= course.name %></td>
                                <td>Start: <strong><%= course.start.toLocalDateTime().format(formatter) %></strong><br/>End: <strong><%= course.end.toLocalDateTime().format(formatter) %></strong></td>
                                <td>
                                    <form action="GetCourseRosterServlet" method="post" style="margin: 0;">
                                        <input type="hidden" name="term" id="term" value="<%= course.term %>"/>
                                        <input type="hidden" name="subject" id="subject" value="<%= course.subject %>"/>
                                        <input type="hidden" name="number" id="number" value="<%= course.number %>"/>
                                        <input type="hidden" name="section" id="section" value="<%= course.section %>"/>
                                        <button type="submit" name="roster-submit" id="roster-submit">Roster <img src="assets/img/proceed.png" alt="Proceed"/></button>
                                    </form>
                                </td>
                            </tr>
<%                  } %>
                </table><br/>
<%          }
        }
    } %>

<%@ include file="assets/include/footer.jsp" %>