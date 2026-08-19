<% @SuppressWarnings("unused") String pageCategory = "management"; %>
<%@ include file="assets/include/header.jsp" %>

<script>
    window.history.replaceState(null, "", "${pageContext.request.contextPath}/register.jsp");
</script>

<% int status = response.getStatus();
if(status != SC_OK && status != SC_CREATED) {
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
else if(status == SC_CREATED) { %>
    <p id="success"><img src="assets/img/success.png" alt="Success" /><strong>Operation Successful</strong>: Registration request completed.</p>
<% } %>

<h2>Registration Center: Register Student</h2>
<form action="RegisterStudentServlet" method="post" style="display: grid; grid-template-rows: auto auto; grid-template-columns: auto auto; grid-template-areas: 'course student' 'submit submit'; gap: 10px;">
    <div style="grid-area: course;">
        <h3>Course Section Information</h3>
        <div class="form-field">
            <label for="term">Term</label>
            <input type="text" id="term" name="term" required/>
        </div>
        <div class="form-field">
            <label for="subject">Subject Area</label>
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
    </div>
    <div style="grid-area: student;">
        <h3>Student Information</h3>
        <div class="form-field">
            <label for="prox">Prox Information</label>
            <input type="text" id="prox" name="prox" required/>
        </div>
    </div>
    <button type="submit" id="register-submit" name="register-submit" style="grid-area: submit; justify-self: center;">Submit Registration Request <img src="assets/img/proceed.png" alt="Proceed"/></button>
</form>

<%@ include file="assets/include/footer.jsp" %>