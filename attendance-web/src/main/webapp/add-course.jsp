<%@ page import="java.util.List" %>
<% @SuppressWarnings("unused") String pageCategory = "management"; %>
<%@ include file="assets/include/header.jsp" %>

<% int status = response.getStatus();
if(status != SC_OK && status != SC_CREATED) {
    switch(status) {
        case SC_BAD_REQUEST: %>
            <p id="error"><img src="assets/img/error.png" alt="Error" /><strong>Authentication Error</strong>: Missing or invalid authentication data.</p>
<%          break;
        case SC_CONFLICT: %>
            <p id="error"><img src="assets/img/error.png" alt="Error" /><strong>Validation Error</strong>: A course with the provided data already exists. Please check the data and try again.</p>
<%          break;
        case SC_INTERNAL_SERVER_ERROR: %>
            <p id="error"><img src="assets/img/error.png" alt="Error" /><strong>Server Error</strong>: The server could not fulfill your request. Please try again or contact the system administrator.</p>
<%          break;
    }
}
else if(status == SC_CREATED) { %>
    <p id="success"><img src="assets/img/success.png" alt="Success" /><strong>Operation Successful</strong>: Add Course request completed.</p>
<% }
    List<User> instructors = userDao.findInstructors();
%>

<h2>Course Management - Add a Course</h2>
<form action="AddCourseServlet" method="post">
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
    <div class="form-field">
        <label for="name">Name</label>
        <input type="text" id="name" name="name" required/>
    </div>
    <div class="form-field">
        <label for="start">Start Date</label>
        <input type="datetime-local" id="start" name="start" required/>
    </div>
    <div class="form-field">
        <label for="end">End Date</label>
        <input type="datetime-local" id="end" name="end" required/>
    </div>
    <div class="form-field">
        <label for="instructor">Instructor</label>
        <select id="instructor" name="instructor">
            <option value="">Unassigned</option>
            <% for(User instructor : instructors) { %>
                <option value="<%= instructor.username %>"><%= instructor.lastName%>, <%= instructor.firstName%> (<%= instructor.username%>)</option>
            <% } %>
        </select>
    </div>
    <button type="submit" id="add-course-submit" name="add-course-submit">Submit Request <img src="assets/img/proceed.png" alt="Proceed"/></button>
</form>

<%@ include file="assets/include/footer.jsp" %>