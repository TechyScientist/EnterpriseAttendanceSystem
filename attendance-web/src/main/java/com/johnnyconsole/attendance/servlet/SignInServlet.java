package com.johnnyconsole.attendance.servlet;

import com.johnnyconsole.attendance.persistence.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import static javax.servlet.http.HttpServletResponse.*;

@WebServlet("SignInServlet")
public class SignInServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("signin-submit") == null) {
            response.setStatus(SC_BAD_REQUEST);
            request.getRequestDispatcher("/signin.jsp").forward(request, response);
        }

        String method = request.getParameter("method");
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();

        if (method.equals("prox")) {
            String proxString = request.getParameter("prox-string"),
                    fc = proxString.isEmpty() ? "" : proxString.substring(0, proxString.indexOf(":")),
                    cc = (proxString.isEmpty() || fc.isEmpty()) ? "" : proxString.substring(proxString.indexOf(":") + 1);

            if(fc.isEmpty() || cc.isEmpty()) {
                response.setStatus(SC_BAD_REQUEST);
                request.getRequestDispatcher("/signin.jsp").forward(request, response);
            }
            // TODO: Retrieve proper user object by prox information and check authentication level
            out.println("Authentication Method: <strong>Prox Card</strong><br/>");
            out.println("Received Data => Facility Code: <strong>" + fc + "</strong>, Card Code: <strong>" + cc + "</strong>");
        }
        else if(method.equals("credentials")) {
            String username = request.getParameter("username"),
                    password = request.getParameter("password");

            if(username.isEmpty() || password.isEmpty()) {
                response.setStatus(SC_BAD_REQUEST);
                request.getRequestDispatcher("/signin.jsp").forward(request, response);
            }

            // TODO: Retrieve proper user object by username/password information and check authentication level
            out.println("Authentication Method: <strong>Credentials</strong><br/>");
            out.println("Received Data => Username: <strong>" + username + "</strong>, Password: <strong>" + password + "</strong>");
        }
        else {
            response.setStatus(SC_BAD_REQUEST);
            request.getRequestDispatcher("/signin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setStatus(SC_METHOD_NOT_ALLOWED);
        request.getRequestDispatcher("/signin.jsp").forward(request, response);
    }
}
