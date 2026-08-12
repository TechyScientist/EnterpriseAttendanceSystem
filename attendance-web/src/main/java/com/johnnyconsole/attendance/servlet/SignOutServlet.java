package com.johnnyconsole.attendance.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static javax.servlet.http.HttpServletResponse.SC_ACCEPTED;

@WebServlet("SignOutServlet")
public class SignOutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession() != null) request.getSession().invalidate();
        response.setStatus(SC_ACCEPTED);
        request.getRequestDispatcher("/signin.jsp").forward(request, response);

    }

}
