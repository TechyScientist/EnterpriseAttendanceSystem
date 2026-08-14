<% String pageCategory = "dashboard"; %>
<%@ include file="assets/include/header.jsp" %>

<script>
    window.history.replaceState(null, "", "${pageContext.request.contextPath}/");
</script>

<h2>Attendance Management Console</h2>
<p>Signed in as: <strong><%= user.lastName %>, <%= user.firstName %></strong></p>

<%@ include file="assets/include/footer.jsp" %>