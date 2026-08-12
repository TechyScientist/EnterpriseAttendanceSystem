<% String pageCategory = "signin"; %>
<%@ include file="assets/include/header.jsp" %>

<% int status = request.getAttribute("status") != null ? (int) request.getAttribute("status") : SC_OK;
if(status == SC_UNAUTHORIZED) { %>
    <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Unauthorized Action</strong>: You must be signed in to access this system.</p>
<% }
else if(status == SC_ACCEPTED) { %>
    <p id="success"><img src="/attendance/assets/img/success.png" alt="Success" /><strong>Operation Successful</strong>: You have been signed out.</p>
<% } %>

<h2>Management Console Sign In</h2>
<form action="SignInServlet" method="post">
    <div class="form-field">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required />
    </div>
    <div class="form-field">
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required />
    </div>
    <button type="submit" id="signin-submit">Sign In<img src="/attendance/assets/img/proceed.png" alt="Proceed" /></button>
</form>

<%@ include file="assets/include/footer.jsp" %>