<%@ page import="static javax.servlet.http.HttpServletResponse.SC_UNAUTHORIZED" %>
<nav>
    <% if(user != null) {
        if(pageCategory.equals("signin")) response.sendRedirect("/attendance"); %>
        <a href="/attendance" <% if(pageCategory.equals("dashboard")) { %> class="current" <% } %>>Dashboard</a>
    <% } else if(!pageCategory.equals("signin")){
        session.setAttribute("status", SC_UNAUTHORIZED);
        response.sendRedirect("/attendance/signin.jsp");
      } %>
</nav>