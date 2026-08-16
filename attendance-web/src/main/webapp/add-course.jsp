<% String pageCategory = "management"; %>
<%@ include file="assets/include/header.jsp" %>

<% int status = response.getStatus();
if(status != SC_OK && status != SC_CREATED) {
    switch(status) {
        case SC_BAD_REQUEST: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Authentication Error</strong>: Missing or invalid authentication data.</p>
<%          break;
        case SC_CONFLICT: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Authentication Error</strong>: A course with the provided data already exists. Please check the data and try again.</p>
<%          break;
        case SC_INTERNAL_SERVER_ERROR: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Server Error</strong>: The server could not fulfill your request. Please try again or contact the system administrator.</p>
<%          break;
    }
}
else if(status == SC_CREATED) { %>
    <p id="success"><img src="/attendance/assets/img/success.png" alt="Success" /><strong>Operation Successful</strong>: Add Course request completed.</p>
<% } %>

<h2>Course Management - Add a Course</h2>
<form action="" method="post">
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
        <label for="instructor">Instructor</label>
        <select id="instructor" name="instructor">
            <option value="">Unassigned</option>
        </select>
    </div>
    <button type="submit" id="add-course-submit" name="add-course-submit">Submit Request <img src="assets/img/proceed.png" alt="Proceed"/></button>
</form>

<%@ include file="assets/include/footer.jsp" %>