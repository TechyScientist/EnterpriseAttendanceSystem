package com.johnnyconsole.attendance.servlet;

import com.johnnyconsole.attendance.persistence.Course;
import com.johnnyconsole.attendance.persistence.Enrolment;
import com.johnnyconsole.attendance.persistence.User;
import com.johnnyconsole.attendance.persistence.dao.interfaces.CourseDao;
import com.johnnyconsole.attendance.persistence.dao.interfaces.EnrolmentDao;
import com.johnnyconsole.attendance.persistence.dao.interfaces.UserDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Locale;

import static javax.servlet.http.HttpServletResponse.*;

@WebServlet("RegisterStudentServlet")
public class RegisterStudentServlet extends HttpServlet {

    @EJB
    private UserDao userDao;

    @EJB
    private CourseDao courseDao;

    @EJB
    private EnrolmentDao enrolmentDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("register-submit") == null) {
            response.setStatus(SC_BAD_REQUEST);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        String term = request.getParameter("term").toUpperCase(Locale.ROOT),
                subject = request.getParameter("subject").toUpperCase(Locale.ROOT),
                number = request.getParameter("number"),
                section = request.getParameter("section"),
                prox = request.getParameter("prox"),
                fc = prox.isEmpty() ? "" : prox.substring(0, prox.indexOf(":")),
                cc = (prox.isEmpty() || fc.isEmpty()) ? "" : prox.substring(prox.indexOf(":") + 1);

            if(fc.isEmpty() || cc.isEmpty()) {
                response.setStatus(SC_BAD_REQUEST);
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            User student = userDao.findByProxData(fc, cc);
            Course course = courseDao.lookup(term, subject, number, section);

            if(student == null || course == null) {
                response.setStatus(SC_NOT_FOUND);
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            if(enrolmentDao.lookup(term, subject, number, section, fc, cc) != null) {
                response.setStatus(SC_CONFLICT);
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            response.setStatus(enrolmentDao.create(
                    new Enrolment(
                            term, subject, number,
                            section, fc, cc
                    )
            ) ? SC_CREATED : SC_INTERNAL_SERVER_ERROR);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setStatus(SC_METHOD_NOT_ALLOWED);
        request.getRequestDispatcher("/signin.jsp").forward(request, response);
    }
}
