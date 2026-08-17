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
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

import static javax.servlet.http.HttpServletResponse.SC_BAD_REQUEST;
import static javax.servlet.http.HttpServletResponse.SC_METHOD_NOT_ALLOWED;

@WebServlet("CourseSearchServlet")
public class CourseSearchServlet extends HttpServlet {

    @EJB
    private CourseDao courseDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String referrer = request.getParameter("referrer"),
                term = request.getParameter("term"),
                subject = request.getParameter("subject"),
                number = request.getParameter("number"),
                section = request.getParameter("section"),
                name = request.getParameter("name");

        if(request.getParameter("course-search-submit") == null) {
            response.setStatus(SC_BAD_REQUEST);
            request.getRequestDispatcher("/" + referrer).forward(request, response);
            return;
        }

        if(term != null && subject != null
                && number != null && section != null) {
            List<Course> courses = new ArrayList<>();
            Course course = courseDao.lookup(
                    term.toUpperCase(Locale.ROOT),
                    subject.toUpperCase(Locale.ROOT),
                    number, section.toUpperCase(Locale.ROOT)
            );
            if(course != null) courses.add(course);
            request.setAttribute("course-list", courses);
        }
        else {
            request.setAttribute("course-list", courseDao.findByName(name));
        }
        request.getRequestDispatcher("/" + referrer).forward(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setStatus(SC_METHOD_NOT_ALLOWED);
        request.getRequestDispatcher("/signin.jsp").forward(request, response);
    }

}
