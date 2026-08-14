<%@ page import="java.util.List" %>
<% String pageCategory = "management"; %>
<%@ include file="assets/include/header.jsp" %>

<script>
    window.history.replaceState(null, "", "${pageContext.request.contextPath}/remove-user.jsp");
</script>

<% if(request.getAttribute("user-list") == null) { %>
<h2>User Search</h2>
<form action="" method="post">
    <input type="hidden" name="referrer" value="remove-user.jsp"/>
    <div class="form-field">
        <label for="first-name">First Name</label>
        <input type="text" id="first-name" name="firstName" required/>
    </div>
    <div class="form-field">
        <label for="last-name">Last Name</label>
        <input type="text" id="last-name" name="lastName" required/>
    </div>
    <button type="submit" id="user-search-submit" name="user-search-submit">Execute Search <img src="/attendance/assets/img/proceed.png" alt="Proceed"/></button>
</form>
<% }
else {
    List<User> users = (List<User>) request.getAttribute("user-list");
    if(users.isEmpty()) { %>
        <p id="error"><img src="/attendance/assets/img/error.png" alt="error"/><strong>Search Error</strong>: No Users found matching the entered criteria. Please try again.</p>
<% }
    else { %>
        <table>
            <tr>
                <th>Name</th>
                <th>Username</th>
                <th>Prox Information</th>
                <th>Submit Remove Request</th>
            </tr>
 <%     for(User u : users) { %>
            <tr>
                <td><%= u.lastName %>, <%= u.firstName %></td>
                <td><%= u.username %></td>
                <td>FC: <strong><%= u.proxFC %></strong>, CC: <strong><%= u.proxCC %></strong></td>
                <td>
                    <form action="" method="post">
                        <input type="hidden" id="username" name="username" value="<%= u.username %>"/>
                        <button type="submit" id="remove-user-submit" name="remove-user-submit">Submit Remove Request <img src="/attendance/assets/img/proceed.png" alt="Proceed"/></button>
                    </form>
                </td>
            </tr>
<%      }
    }
} %>

<%@ include file="assets/include/footer.jsp" %>