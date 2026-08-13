<% String pageCategory = "management"; %>
<%@ include file="assets/include/header.jsp" %>

<h2>User Management - Add a User</h2>
<form action="" method="post">
    <div class="form-field">
        <label for="firstName">First Name</label>
        <input type="text" id="firstName" name="firstName" required/>
    </div>
    <div class="form-field">
        <label for="lastName">Last Name</label>
        <input type="text" id="lastName" name="lastName" required/>
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