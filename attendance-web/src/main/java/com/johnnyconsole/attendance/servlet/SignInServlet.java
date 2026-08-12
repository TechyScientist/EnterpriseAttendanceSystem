package com.johnnyconsole.attendance.servlet;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.johnnyconsole.attendance.persistence.User;
import com.johnnyconsole.attendance.persistence.dao.interfaces.UserDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Locale;

import static at.favre.lib.crypto.bcrypt.BCrypt.Version.VERSION_2A;
import static javax.servlet.http.HttpServletResponse.*;

@WebServlet("SignInServlet")
public class SignInServlet extends HttpServlet {

    @EJB
    private UserDao userDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("signin-submit") == null) {
            response.setStatus(SC_BAD_REQUEST);
            request.getRequestDispatcher("/signin.jsp").forward(request, response);
        }

        String method = request.getParameter("method");

        if (method.equals("prox")) {
            String proxString = request.getParameter("prox-string"),
                    fc = proxString.isEmpty() ? "" : proxString.substring(0, proxString.indexOf(":")),
                    cc = (proxString.isEmpty() || fc.isEmpty()) ? "" : proxString.substring(proxString.indexOf(":") + 1);

            if(fc.isEmpty() || cc.isEmpty()) {
                response.setStatus(SC_BAD_REQUEST);
                request.getRequestDispatcher("/signin.jsp").forward(request, response);
            }

            User user = userDao.findByProxData(fc, cc);

            if(user == null) {
                response.setStatus(SC_NOT_FOUND);
                request.getRequestDispatcher("/signin.jsp").forward(request, response);

            }
            else if(!user.isAdministrator) {
                response.setStatus(SC_FORBIDDEN);
                request.getRequestDispatcher("/signin.jsp").forward(request, response);
            }

            request.getSession().setAttribute("user", user);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
        else if(method.equals("credentials")) {
            String username = request.getParameter("username").toLowerCase(Locale.ROOT),
                    password = request.getParameter("password");

            if(username.isEmpty() || password.isEmpty()) {
                response.setStatus(SC_BAD_REQUEST);
                request.getRequestDispatcher("/signin.jsp").forward(request, response);
            }

            User user = userDao.findByCredentials(username);
            if(user == null) {
                response.setStatus(SC_NOT_FOUND);
                request.getRequestDispatcher("/signin.jsp").forward(request, response);
            }
            else if(!BCrypt.verifyer(VERSION_2A)
                    .verifyStrict(password.toCharArray(), user.password.toCharArray())
                    .verified) {
                response.setStatus(SC_CONFLICT);
                request.getRequestDispatcher("/signin.jsp").forward(request, response);
            }
            else if(!user.isAdministrator) {
                response.setStatus(SC_FORBIDDEN);
                request.getRequestDispatcher("/signin.jsp").forward(request, response);
            }

            request.getSession().setAttribute("user", user);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
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
