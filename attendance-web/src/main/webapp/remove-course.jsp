<%@ page import="java.util.List" %>
<%@ page import="com.johnnyconsole.attendance.persistence.Course" %>
<% String pageCategory = "management"; %>
<%@ include file="assets/include/header.jsp" %>

<% int status = response.getStatus();
if(status != SC_OK && status != SC_ACCEPTED) {
    switch(status) {
        case SC_BAD_REQUEST: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Authentication Error</strong>: Missing or invalid authentication data.</p>
<%          break;
        case SC_NOT_FOUND: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Authentication Error</strong>: No course sections could be found using the submitted data. Please try again.</p>
<%          break;
        case SC_INTERNAL_SERVER_ERROR: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Server Error</strong>: The server could not fulfill your request. Please try again or contact the system administrator.</p>
<%          break;
    }
}
else if(status == SC_ACCEPTED) { %>
        <p id="success"><img src="/attendance/assets/img/success.png" alt="Success" /><strong>Operation Successful</strong>: Remove Course request completed.</p>
<% }

    @SuppressWarnings("unchecked")
    List<Course> courses = (List<Course>) request.getAttribute("course-list");

if(courses == null || courses.isEmpty()) {
    if(courses != null) { %>
        <p id="error"><img src="/attendance/assets/img/error.png" alt="error"/><strong>Search Error</strong>: No course sections found matching the entered criteria. Please try again.</p>
<%  } %>

    <h2>Course Search</h2>
    <div style="display: grid; grid-template-columns: auto auto; column-gap: 20px; max-width: fit-content;">
        <div>
            <h3>Search by Section Information</h3>
            <form action="" method="post">
                <input type="hidden" id="referrer" name="referrer" value="remove-course.jsp" />
                <div class="form-field">
                    <label for="term">Term Code</label>
                    <input type="text" id="term" name="term" required/>
                </div>
                <div class="form-field">
                    <label for="subject">Subject Code</label>
                    <input type="text" id="subject" name="subject" required/>
                </div>
                <div class="form-field">
                    <label for="number">Course Number</label>
                    <input type="text" id="number" name="number" required/>
                </div>
                <div class="form-field">
                    <label for="section">Section Code</label>
                    <input type="text" id="section" name="section" required/>
                </div>
                <button type="submit" id="course-search-submit" name="course-search-submit">Execute Search <img src="assets/img/proceed.png" alt="Proceed"/></button>
            </form>
        </div>
        <div>
            <h3>Search By Course Title</h3>
            <form action="" method="post">
                <input type="hidden" id="referrer" name="referrer" value="remove-course.jsp" />
                <div class="form-field">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" required/>
                </div>
                <button type="submit" id="course-search-submit" name="course-search-submit">Execute Search <img src="assets/img/proceed.png" alt="Proceed"/></button>
            </form>
        </div>
    </div>
<% }
else { %>
    <h2>Search Results</h2>
    <table>
        <tr>
            <th>Course Identifier</th>
            <th>Course Title</th>
            <th>Course Instructor</th>
            <th>Course Start/End Dates</th>
            <th>Submit Remove Request</th>
        </tr>
<%      for(Course c : courses) {
            User instructor = userDao.findByCredentials(c.instructor); %>
            <tr>
                <td><%= c.term %> <%= c.subject %>-<%= c.number %>-<%= c.section %></td>
                <td><%= c.name %></td>
                <td><%= instructor.lastName %>, <%= instructor.firstName %></strong></td>
                <td>
                    <form action="RemoveUserServlet" method="post" style="margin: 0;">
                        <input type="hidden" id="term" name="term" value="<%= c.term %>"/>
                        <input type="hidden" id="subject" name="subject" value="<%= c.subject %>"/>
                        <input type="hidden" id="number" name="number" value="<%= c.number %>"/>
                        <input type="hidden" id="section" name="section" value="<%= c.section %>"/>
                        <button type="submit" id="remove-course-submit" name="remove-course-submit">Submit Remove Request <img src="/attendance/assets/img/proceed.png" alt="Proceed"/></button>
                    </form>
                </td>
            </tr>
<%      } %>
    </table>
    <form action="remove-course.jsp" method="get" style="margin: 10px 0 0 0;">
        <button type="submit"><img src="/attendance/assets/img/back.png" alt="back" style="margin-left: 0; margin-right: 10px;"/> New Search</button>
    </form>
<% } %>

<%@ include file="assets/include/footer.jsp" %>