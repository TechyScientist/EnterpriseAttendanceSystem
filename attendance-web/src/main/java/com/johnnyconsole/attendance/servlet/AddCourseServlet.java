package com.johnnyconsole.attendance.servlet;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.johnnyconsole.attendance.persistence.Course;
import com.johnnyconsole.attendance.persistence.User;
import com.johnnyconsole.attendance.persistence.dao.interfaces.CourseDao;
import com.johnnyconsole.attendance.persistence.dao.interfaces.UserDao;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Locale;

import static at.favre.lib.crypto.bcrypt.BCrypt.Version.VERSION_2A;
import static javax.servlet.http.HttpServletResponse.*;

@WebServlet("AddCourseServlet")
public class AddCourseServlet extends HttpServlet {

    @EJB
    private CourseDao courseDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("add-course-submit") == null) {
            response.setStatus(SC_BAD_REQUEST);
            request.getRequestDispatcher("/add-course.jsp").forward(request, response);
            return;
        }
        String term = request.getParameter("term").toUpperCase(Locale.ROOT),
                subject = request.getParameter("subject").toUpperCase(Locale.ROOT),
                number = request.getParameter("number"),
                section = request.getParameter("section").toUpperCase(Locale.ROOT),
                name = request.getParameter("name"),
                instructor = request.getParameter("instructor").isEmpty() ?
                        null : request.getParameter("instructor");
        Timestamp start = Timestamp.valueOf(LocalDateTime.parse(request.getParameter("start"))),
                end = Timestamp.valueOf(LocalDateTime.parse(request.getParameter("end")));

        Course course = courseDao.lookup(term, subject, number, section);

        if(course != null) {
            response.setStatus(SC_CONFLICT);
            request.getRequestDispatcher("/add-course.jsp").forward(request, response);
            return;
        }

        response.setStatus(courseDao.create(new Course(term, subject, number, section, name, instructor, start, end))
                ? SC_CREATED : SC_INTERNAL_SERVER_ERROR);
        request.getRequestDispatcher("/add-course.jsp").forward(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setStatus(SC_METHOD_NOT_ALLOWED);
        request.getRequestDispatcher("/add-course.jsp").forward(request, response);
    }
}
