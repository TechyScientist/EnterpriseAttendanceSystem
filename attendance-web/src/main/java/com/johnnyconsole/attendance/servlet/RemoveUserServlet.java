package com.johnnyconsole.attendance.servlet;

import com.johnnyconsole.attendance.persistence.User;
import com.johnnyconsole.attendance.persistence.dao.interfaces.UserDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static javax.servlet.http.HttpServletResponse.*;

@WebServlet("RemoveUserServlet")
public class RemoveUserServlet extends HttpServlet {

    @EJB
    private UserDao userDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("remove-user-submit") == null) {
            response.setStatus(SC_BAD_REQUEST);
            request.getRequestDispatcher("/remove-user.jsp").forward(request, response);
            return;
        }

        String proxString = request.getParameter("prox"),
                fc = proxString.isEmpty() ? "" : proxString.substring(0, proxString.indexOf(":")),
                cc = (proxString.isEmpty() || fc.isEmpty()) ? "" : proxString.substring(proxString.indexOf(":") + 1);

        if(fc.isEmpty() || cc.isEmpty()) {
            response.setStatus(SC_BAD_REQUEST);
            request.getRequestDispatcher("/remove-user.jsp").forward(request, response);
            return;
        }

        User user = userDao.findByProxData(fc, cc);

        if(user == null) {
            response.setStatus(SC_NOT_FOUND);
            request.getRequestDispatcher("/remove-user.jsp").forward(request, response);
            return;
        }

        response.setStatus(userDao.delete(user) ? SC_ACCEPTED : SC_INTERNAL_SERVER_ERROR);
        request.getRequestDispatcher("/remove-user.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setStatus(SC_METHOD_NOT_ALLOWED);
        request.getRequestDispatcher("/remove-user.jsp").forward(request, response);
    }

}
