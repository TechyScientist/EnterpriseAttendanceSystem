package com.johnnyconsole.attendance.persistence.dao.implementation;

import com.johnnyconsole.attendance.persistence.Enrolment;
import com.johnnyconsole.attendance.persistence.dao.interfaces.EnrolmentDao;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class EnrolmentDaoImpl implements EnrolmentDao {

    @PersistenceContext(unitName="enrolment")
    private EntityManager manager;

    @Override
    public Enrolment lookup(String term, String subject, String number,
                            String section, String facilityCode, String cardCode) {
        return null;
    }

    @Override
    public List<Enrolment> findByUser(String facilityCode, String cardCode) {
        return null;
    }

    @Override
    public List<Enrolment> findByCourseSection(String term, String subject, String number, String section) {
        return null;
    }

    @Override
    public boolean create(Enrolment enrolment) {
        return false;
    }

    @Override
    public boolean delete(Enrolment enrolment) {
        return false;
    }

}
