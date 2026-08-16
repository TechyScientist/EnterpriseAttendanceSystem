package com.johnnyconsole.attendance.persistence.dao.interfaces;

import com.johnnyconsole.attendance.persistence.Course;

import javax.ejb.Local;
import java.util.List;

@Local
public interface CourseDao {
    Course lookup(String term, String subject, String number, String section);
    List<Course> findByTerm(String term);
    List<Course> findSectionsByCourseNumber(String subject, String number);
    List<Course> findByInstructor(String instructor);
    List<Course> findByName(String name);
    boolean create(Course course);
    boolean update(Course course);
    boolean delete(Course course);
}
