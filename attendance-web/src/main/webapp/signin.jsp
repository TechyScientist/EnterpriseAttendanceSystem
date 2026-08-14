<% String pageCategory = "signin"; %>
<%@ include file="assets/include/header.jsp" %>

<script>
    window.history.replaceState(null, "", "${pageContext.request.contextPath}/signin.jsp");
</script>

<% int status = response.getStatus();
if(status != SC_OK && status != SC_ACCEPTED) {
    switch(status) {
        case SC_UNAUTHORIZED: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Unauthorized Action</strong>: You must be signed in to access this system.</p>
<%          break;
        case SC_BAD_REQUEST: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Authentication Error</strong>: Missing or invalid authentication data.</p>
<%          break;
        case SC_NOT_FOUND: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Authentication Error</strong>: No user profile could be found using the submitted authentication data. Please try again.</p>
<%          break;
        case SC_FORBIDDEN: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Forbidden</strong>: You must be a system administrator to access this system.</p>
<%          break;
        case SC_CONFLICT: %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Authentication Error</strong>: Your profile could not be authenticated. Please verify your information and try again.</p>
<%          break;
    }
}
else if(status == SC_ACCEPTED) { %>
    <p id="success"><img src="/attendance/assets/img/success.png" alt="Success" /><strong>Operation Successful</strong>: You have been signed out.</p>
<% } %>

<h2>Management Console Sign In</h2>
<form action="SignInServlet" method="post">
    <input type="hidden" id="prox-string" name="prox-string"/>
    <input type="hidden" id="signin-submit" name="signin-submit"/>
    <div class="form-field">
        <label for="method">Authentication Method</label>
        <select id="method" name="method">
            <option value="prox">Prox Card</option>
            <option value="credentials">Username/Password</option>
        </select>
    </div>
    <div id="prox-signin">
        <p>Swipe your prox card to sign in.</p>
    </div>
    <div id="credential-signin" style="display: none">
        <div class="form-field">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" />
        </div>
        <div class="form-field">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" />
        </div>
        <button type="submit">Sign In<img src="/attendance/assets/img/proceed.png" alt="Proceed" /></button>
    </div>
</form>

<script>
    const proxInput = document.getElementById("prox-string");
    const form = document.getElementsByTagName("form")[0];
    const signInMethod = document.getElementById("method");
    const proxDiv = document.getElementById("prox-signin");
    const credentialDiv = document.getElementById("credential-signin");
    const usernameField = document.getElementById("username");
    const passwordField = document.getElementById("password");
    var submitted = false;

    function captureProxSwipe(event) {
        const key = event.key;

        if (/^[0-9]$/.test(key) || key === ':') {
            event.preventDefault();
            proxInput.value += key;
        }
        else if (key === 'Enter') {
            event.preventDefault();
            if(!submitted) {
                submitted = true;
                form.submit();
            }
        }
    }

    signInMethod.addEventListener("change", event => {
        if(event.target.value === "prox") {
            proxDiv.style.display = "block";
            credentialDiv.style.display = "none";
            usernameField.required = false;
            passwordField.required = false;
            document.addEventListener("keydown", captureProxSwipe);
        } else {
            proxDiv.style.display = "none";
            credentialDiv.style.display = "block";
            usernameField.required = true;
            passwordField.required = true;
            document.removeEventListener("keydown", captureProxSwipe);
        }
    });

    signInMethod.dispatchEvent(new Event('change'));
</script>

<%@ include file="assets/include/footer.jsp" %>