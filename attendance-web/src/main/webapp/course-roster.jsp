<%@ page import="com.johnnyconsole.attendance.persistence.Course" %>
<%@ page import="java.util.List" %>
<%@ page import="com.johnnyconsole.attendance.persistence.Enrolment" %>
<% String pageCategory = "dashboard"; %>
<%@ include file="assets/include/header.jsp" %>

<script>
    window.history.replaceState(null, "", "${pageContext.request.contextPath}/course-roster.jsp");
</script>

<%
    Course course = (Course) request.getAttribute("course");
    List<Enrolment> roster = (List<Enrolment>) request.getAttribute("roster");
%>

<h2>Course Roster: <%= course.term %> <%= course.subject %>-<%= course.number %>-<%= course.section %></h2>
<% if(roster.isEmpty()) { %>
    <p id="warning"><img src="assets/img/warning.png" alt="Warning"/><strong>Roster Warning</strong>: There are no enrolments for this course section.</p>
<% }
else { %>
    <table>
        <tr>
            <th>Last Name</th>
            <th>First Name</th>
            <th>Prox Information</th>
            <% if(user.isAdministrator) { %> <th>Deregister</th> <% } %>
        </tr>
        <% for(Enrolment enrolment : roster) {
            User student = userDao.findByProxData(enrolment.proxFC, enrolment.proxCC); %>
            <tr>
                <td><%= student.lastName %></td>
                <td><%= student.firstName %></td>
                <td>FC: <strong><%= student.proxFC %></strong>, CC: <strong><%= student.proxCC %></strong></td>
                <% if(user.isAdministrator)  { %>
                <td>
                    <form action="DeregisterStudentServlet" method="post" style="margin: 0;">
                        <input type="hidden" name="referrer" id="referrer" value="index.jsp"/>
                        <input type="hidden" name="term" id="term" value="<%= enrolment.term %>"/>
                        <input type="hidden" name="subject" id="subject" value="<%= enrolment.subject %>"/>
                        <input type="hidden" name="number" id="number" value="<%= enrolment.number %>"/>
                        <input type="hidden" name="section" id="section" value="<%= enrolment.section %>"/>
                        <input type="hidden" name="prox" id="prox" value="<%= enrolment.proxFC %>:<%= enrolment.proxCC %>"/>
                        <button type="submit" name="deregister-submit" id="deregister-submit">Deregister <img src="assets/img/proceed.png" alt="Proceed"/></button>
                    </form>
                </td>
                <% } %>
            </tr>
        <% } %>
    </table>
<% } %>
<form action="index.jsp" method="get" style="margin: 10px 0 0 0;">
    <button type="submit"><img src="/attendance/assets/img/back.png" alt="back" style="margin-left: 0; margin-right: 10px;"/> Return to Dashboard</button>
</form>
<%@ include file="assets/include/footer.jsp" %>