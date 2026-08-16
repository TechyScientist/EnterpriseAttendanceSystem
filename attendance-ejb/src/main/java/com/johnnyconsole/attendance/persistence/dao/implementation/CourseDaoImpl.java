package com.johnnyconsole.attendance.persistence.dao.implementation;

import com.johnnyconsole.attendance.persistence.Course;
import com.johnnyconsole.attendance.persistence.dao.interfaces.CourseDao;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

@SuppressWarnings("unchecked")
@Stateless
public class CourseDaoImpl implements CourseDao {

    @PersistenceContext(unitName="course")
    private EntityManager manager;

    @Override
    public Course lookup(String term, String subject, String number, String section) {
        try {
            return (Course) manager.createNamedQuery("Course.Lookup")
                    .setParameter("term", term.toLowerCase(Locale.ROOT))
                    .setParameter("subject", subject.toLowerCase(Locale.ROOT))
                    .setParameter("number", number)
                    .setParameter("section", section.toLowerCase(Locale.ROOT))
                    .getSingleResult();
        } catch (NoResultException ex) {
            return null;
        }
    }

    @Override
    public List<Course> findByTerm(String term) {
        try {
            return (List<Course>) manager.createNamedQuery("Course.FindByTerm")
                    .setParameter("term", term.toLowerCase(Locale.ROOT))
                    .getResultList();
        } catch (NoResultException ex) {
            return Collections.emptyList();
        }
    }

    @Override
    public List<Course> findSectionsByCourseNumber(String subject, String number) {
        try {
            return (List<Course>) manager.createNamedQuery("Course.FindSectionsByCourseNumber")
                    .setParameter("subject", subject.toLowerCase(Locale.ROOT))
                    .setParameter("number", number)
                    .getResultList();
        } catch (NoResultException ex) {
            return Collections.emptyList();
        }
    }

    @Override
    public List<Course> findByInstructor(String instructor) {
        try {
            return (List<Course>) manager.createNamedQuery("Course.FindByInstructor")
                    .setParameter("instructor", instructor)
                    .getResultList();
        } catch (NoResultException ex) {
            return Collections.emptyList();
        }
    }

    @Override
    public List<Course> findByName(String name) {
        try {
            return (List<Course>) manager.createNamedQuery("Course.FindByName")
                    .setParameter("name", "%" + name.toLowerCase(Locale.ROOT) + "%")
                    .getResultList();
        } catch (NoResultException ex) {
            return Collections.emptyList();
        }
    }

    @Override
    public boolean create(Course course) {
        return false;
    }

    @Override
    public boolean update(Course course) {
        return false;
    }

    @Override
    public boolean delete(Course course) {
        return false;
    }
}
