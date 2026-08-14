<% String pageCategory = "management"; %>
<%@ include file="assets/include/header.jsp" %>

<% int status = response.getStatus();
if(status != SC_OK && status != SC_CREATED) {
    switch(status) {
        case SC_BAD_REQUEST: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Authentication Error</strong>: Missing or invalid authentication data.</p>
<%          break;
        case SC_CONFLICT: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Authentication Error</strong>: A user with the provided authentication data already exists. Please check the data and try again.</p>
<%          break;
        case SC_INTERNAL_SERVER_ERROR: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Server Error</strong>: The server could not fulfill your request. Please try again or contact the system administrator.</p>
<%          break;
    }
}
else if(status == SC_CREATED) { %>
    <p id="success"><img src="/attendance/assets/img/success.png" alt="Success" /><strong>Operation Successful</strong>: Add User request completed.</p>
<% } %>

<h2>User Management - Add a User</h2>
<form action="AddUserServlet" method="post">
    <div class="form-field">
        <label for="first-name">First Name</label>
        <input type="text" id="first-name" name="first-name" required/>
    </div>
    <div class="form-field">
        <label for="last-name">Last Name</label>
        <input type="text" id="last-name" name="last-name" required/>
    </div>
    <div class="form-field">
        <label for="prox">Prox Information</label>
        <input type="text" id="prox" name="prox" required/>
    </div>
    <div class="form-field">
        <label for="is-administrator">Access Level</label>
        <select id="is-administrator" name="is-administrator">
            <option value="false">Student</option>
            <option value="true">Administrator</option>
        </select>
        <div id="credentials-div" style="display: none">
            <div class="form-field">
                <label for="username">Username</label>
                <input type="text" id="username" name="username"/>
            </div>
            <div class="form-field">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"/>
            </div>
        </div>
    </div>
    <button type="submit" id="add-user-submit" name="add-user-submit">Submit Request <img src="assets/img/proceed.png" alt="Proceed"/></button>
</form>

<script>
    const isAdministrator = document.getElementById("is-administrator");
    const credentialsDiv = document.getElementById("credentials-div");
    const usernameField = document.getElementById("username");
    const passwordField = document.getElementById("password");

    document.addEventListener("keydown", event => {
        if(event.key === "Enter") {
            event.preventDefault();
        }
    })

    isAdministrator.addEventListener("change", event => {
        if(event.target.value === "true") {
            credentialsDiv.style.display = "block";
            usernameField.required = true;
            passwordField.required = true;
        } else {
            credentialsDiv.style.display = "none";
            usernameField.required = false;
            passwordField.required = false;
        }
    });

    isAdministrator.dispatchEvent(new Event('change'));
</script>

<%@ include file="assets/include/footer.jsp" %>