<nav>
    <% if(user != null) {
        if(pageCategory.equals("signin")) response.sendRedirect("/attendance"); %>
            <a href="/attendance" <% if(pageCategory.equals("dashboard")) { %> id="current" <% } %>>Dashboard</a>
            <a href="/attendance/management.jsp" <% if(pageCategory.equals("management")) { %> id="current" <% } %>>System Management</a>
            <a href="/attendance/reporting.jsp" <% if(pageCategory.equals("reporting")) { %> id="current" <% } %>>Generate Reports</a>
            <a href="/attendance/SignOutServlet">Sign Out</a>
    <% } else if(!pageCategory.equals("signin")){
        response.setStatus(SC_UNAUTHORIZED);
        request.getRequestDispatcher("/signin.jsp").forward(request, response);
        return;
      } %>
</nav>