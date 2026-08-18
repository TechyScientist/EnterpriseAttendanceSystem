package com.johnnyconsole.attendance.servlet;

import com.johnnyconsole.attendance.persistence.Course;
import com.johnnyconsole.attendance.persistence.Enrolment;
import com.johnnyconsole.attendance.persistence.dao.interfaces.CourseDao;
import com.johnnyconsole.attendance.persistence.dao.interfaces.EnrolmentDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import static javax.servlet.http.HttpServletResponse.SC_BAD_REQUEST;
import static javax.servlet.http.HttpServletResponse.SC_METHOD_NOT_ALLOWED;

@WebServlet("GetCourseRosterServlet")
public class GetCourseRosterServlet extends HttpServlet {

    @EJB
    private CourseDao courseDao;

    @EJB
    private EnrolmentDao enrolmentDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String term = request.getParameter("term"),
                subject = request.getParameter("subject"),
                number = request.getParameter("number"),
                section = request.getParameter("section");

        if(request.getParameter("roster-submit") == null) {
            response.setStatus(SC_BAD_REQUEST);
            request.getRequestDispatcher("/").forward(request, response);
            return;
        }

        Course course = courseDao.lookup(term, subject, number, section);
        List<Enrolment> roster = enrolmentDao.findByCourseSection(term, subject, number, section);
        request.setAttribute("roster", roster);
        request.setAttribute("course", course);
        request.getRequestDispatcher("/course-roster.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setStatus(SC_METHOD_NOT_ALLOWED);
        request.getRequestDispatcher("/signin.jsp").forward(request, response);
    }

}
