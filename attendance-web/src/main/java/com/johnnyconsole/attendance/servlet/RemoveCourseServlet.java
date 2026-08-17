package com.johnnyconsole.attendance.servlet;

import com.johnnyconsole.attendance.persistence.Course;
import com.johnnyconsole.attendance.persistence.dao.interfaces.CourseDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Locale;

import static javax.servlet.http.HttpServletResponse.*;

@WebServlet("RemoveCourseServlet")
public class RemoveCourseServlet extends HttpServlet {

    @EJB
    private CourseDao courseDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("remove-course-submit") == null) {
            response.setStatus(SC_BAD_REQUEST);
            request.getRequestDispatcher("/remove-course.jsp").forward(request, response);
            return;
        }

        String term = request.getParameter("term"),
                subject = request.getParameter("subject"),
                number = request.getParameter("number"),
                section = request.getParameter("section");

        Course course = courseDao.lookup(
                term.toUpperCase(Locale.ROOT),
                subject.toUpperCase(Locale.ROOT),
                number, section.toUpperCase(Locale.ROOT));

        if(course == null) {
            response.setStatus(SC_NOT_FOUND);
            request.getRequestDispatcher("/remove-course.jsp").forward(request, response);
            return;
        }

        response.setStatus(courseDao.delete(course) ? SC_ACCEPTED : SC_INTERNAL_SERVER_ERROR);
        request.getRequestDispatcher("/remove-course.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setStatus(SC_METHOD_NOT_ALLOWED);
        request.getRequestDispatcher("/remove-user.jsp").forward(request, response);
    }

}
