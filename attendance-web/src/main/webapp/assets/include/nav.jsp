<nav>
    <% if(user != null) {
        if(pageCategory.equals("signin")) response.sendRedirect("/attendance"); %>
            <a href="/attendance" <% if(pageCategory.equals("dashboard")) { %> id="current" <% } %>>Dashboard</a>
            <% if(user.isAdministrator) { %>
                <a href="management.jsp" <% if(pageCategory.equals("management")) { %> id="current" <% } %>>Management</a>
            <% }
               if(user.isInstructor) { %>
                <a href="reporting.jsp" <% if(pageCategory.equals("reporting")) { %> id="current" <% } %>>Attendance Report</a>
            <% } %>
            <a href="SignOutServlet">Sign Out</a>
    <% } else if(!pageCategory.equals("signin")){
        response.setStatus(SC_UNAUTHORIZED);
        request.getRequestDispatcher("/signin.jsp").forward(request, response);
        return;
      } %>
</nav>