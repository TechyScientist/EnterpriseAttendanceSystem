<%@ page import="java.util.List" %>
<% String pageCategory = "management"; %>
<%@ include file="assets/include/header.jsp" %>

<script>
    window.history.replaceState(null, "", "${pageContext.request.contextPath}/remove-user.jsp");
</script>

<% int status = response.getStatus();
    if(status != SC_OK && status != SC_ACCEPTED) {
        switch(status) {
            case SC_BAD_REQUEST: %>
                <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Authentication Error</strong>: Missing or invalid authentication data.</p>
<%              break;
            case SC_NOT_FOUND: %>
                <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Authentication Error</strong>: No user profile could be found using the submitted authentication data. Please try again.</p>
<%              break;
            case SC_INTERNAL_SERVER_ERROR: %>
                <p id="error"><img src="/attendance/assets/img/error.png" alt="Error" /><strong>Server Error</strong>: The server could not fulfill your request. Please try again or contact the system administrator.</p>
<%              break;
        }
    }
    else if(status == SC_ACCEPTED) { %>
        <p id="success"><img src="/attendance/assets/img/success.png" alt="Success" /><strong>Operation Successful</strong>: Remove User request completed.</p>
<% }

    List<User> users = ((List<User>) request.getAttribute("user-list"));
    if(users == null || users.isEmpty()) {
        if(users != null && users.isEmpty()) { %>
            <p id="error"><img src="/attendance/assets/img/error.png" alt="error"/><strong>Search Error</strong>: No Users found matching the entered criteria. Please try again.</p>
<%      }%>
<h2>User Search</h2>
<form action="UserSearchServlet" method="post">
    <input type="hidden" id="referrer" name="referrer" value="remove-user.jsp"/>
    <div class="form-field">
        <label for="first-name">First Name</label>
        <input type="text" id="first-name" name="first-name" required/>
    </div>
    <div class="form-field">
        <label for="last-name">Last Name</label>
        <input type="text" id="last-name" name="last-name" required/>
    </div>
    <button type="submit" id="user-search-submit" name="user-search-submit">Execute Search <img src="/attendance/assets/img/proceed.png" alt="Proceed"/></button>
</form>
<% }
else { %>
    <h2>Search Results</h2>
    <table>
        <tr>
            <th>Name</th>
            <th>Username</th>
            <th>Prox Information</th>
            <th>Submit Remove Request</th>
        </tr>
<%  for(User u : users) { %>
        <tr>
            <td><%= u.lastName %>, <%= u.firstName %></td>
            <td><%= u.username == null ? "--" : u.username %></td>
            <td>FC: <strong><%= u.proxFC %></strong>, CC: <strong><%= u.proxCC %></strong></td>
            <td>
                <form action="RemoveUserServlet" method="post" style="margin: 0;">
                    <input type="hidden" id="prox" name="prox" value="<%= u.proxFC %>:<%= u.proxCC %>"/>
                    <button type="submit" id="remove-user-submit" name="remove-user-submit">Submit Remove Request <img src="/attendance/assets/img/proceed.png" alt="Proceed"/></button>
                </form>
            </td>
        </tr>
<%  } %>
    </table>
    <form action="remove-user.jsp" method="get" style="margin: 10px 0 0 0;">
        <button type="submit"><img src="/attendance/assets/img/back.png" alt="back" style="margin-left: 0; margin-right: 10px;"/> New Search</button>
    </form>
<% } %>

<%@ include file="assets/include/footer.jsp" %>