package com.johnnyconsole.attendance.servlet;

import com.johnnyconsole.attendance.persistence.dao.interfaces.UserDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static javax.servlet.http.HttpServletResponse.SC_BAD_REQUEST;

@WebServlet("UserSearchServlet")
public class UserSearchServlet extends HttpServlet {

    @EJB
    private UserDao userDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String referrer = request.getParameter("referrer"),
                firstName = request.getParameter("first-name"),
                lastName = request.getParameter("last-name");

        if(request.getParameter("user-search-submit") == null) {
            response.setStatus(SC_BAD_REQUEST);
            request.getRequestDispatcher("/" + referrer).forward(request, response);
            return;
        }

        request.setAttribute("user-list", userDao.findByNameData(firstName, lastName));
        request.getRequestDispatcher("/" + referrer).forward(request, response);

    }

}
