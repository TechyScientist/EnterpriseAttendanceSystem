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

@WebServlet("AddUserServlet")
public class AddUserServlet extends HttpServlet {

    @EJB
    private UserDao userDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("add-user-submit") == null) {
            response.setStatus(SC_BAD_REQUEST);
            request.getRequestDispatcher("/add-user.jsp").forward(request, response);
        }
        String firstName = request.getParameter("first-name"),
                lastName = request.getParameter("last-name"),
                prox = request.getParameter("prox"),
                fc = !prox.contains(":") ? "" : prox.substring(0, prox.indexOf(":")),
                cc = !prox.contains(":") ? "" : prox.substring(prox.indexOf(":") + 1),
                username = request.getParameter("username"),
                password = BCrypt.with(VERSION_2A).hashToString(12,
                        request.getParameter("password").toCharArray());
        boolean isAdministrator = Boolean.parseBoolean(request.getParameter("is-administrator"));

        if(fc.isEmpty() || cc.isEmpty()) {
            response.setStatus(SC_BAD_REQUEST);
            request.getRequestDispatcher("/add-user.jsp").forward(request, response);
        }
        System.out.println(userDao.findByProxData(fc,cc));

        if(userDao.findByProxData(fc, cc) != null ||
                (!username.isEmpty() && userDao.findByCredentials(username) != null)) {
            response.setStatus(SC_CONFLICT);
            request.getRequestDispatcher("/add-user.jsp").forward(request, response);
        }

        User user;
        if(isAdministrator) {
            user = new User(lastName, firstName, username.toLowerCase(Locale.ROOT),
                    password, fc, cc, true);
        }
        else {
            user = new User(lastName, firstName, null,
                    null, fc, cc, false);
        }

        if(userDao.create(user)) {
            response.setStatus(SC_CREATED);
            request.getRequestDispatcher("/add-user.jsp").forward(request, response);
        }
        else {
            response.setStatus(SC_INTERNAL_SERVER_ERROR);
            request.getRequestDispatcher("/add-user.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setStatus(SC_METHOD_NOT_ALLOWED);
        request.getRequestDispatcher("/add-user.jsp").forward(request, response);
    }
}
