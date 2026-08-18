package com.johnnyconsole.attendance.persistence.dao.implementation;

import com.johnnyconsole.attendance.persistence.Enrolment;
import com.johnnyconsole.attendance.persistence.dao.interfaces.EnrolmentDao;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

@SuppressWarnings("unchecked")
@Stateless
public class EnrolmentDaoImpl implements EnrolmentDao {

    @PersistenceContext(unitName="enrolment")
    private EntityManager manager;

    @Override
    public Enrolment lookup(String term, String subject, String number,
                            String section, String facilityCode, String cardCode) {
        try {
            return (Enrolment) manager.createNamedQuery("Enrolment.Lookup")
                    .setParameter("term", term.toUpperCase(Locale.ROOT))
                    .setParameter("subject", subject.toUpperCase(Locale.ROOT))
                    .setParameter("number", number)
                    .setParameter("section", section.toUpperCase(Locale.ROOT))
                    .setParameter("facilityCode", facilityCode)
                    .setParameter("cardCode", cardCode)
                    .getSingleResult();
        } catch (NoResultException ex) {
            return null;
        }
    }

    @Override
    public List<Enrolment> findByUser(String facilityCode, String cardCode) {
        try {
            return (List<Enrolment>) manager.createNamedQuery("Enrolment.FindByUser")
                    .setParameter("facilityCode", facilityCode)
                    .setParameter("cardCode", cardCode)
                    .getResultList();
        } catch (NoResultException ex) {
            return Collections.emptyList();
        }
    }

    @Override
    public List<Enrolment> findByCourseSection(String term, String subject, String number, String section) {
        try {
            return (List<Enrolment>) manager.createNamedQuery("Enrolment.FindByCourseSection")
                    .setParameter("term", term.toUpperCase(Locale.ROOT))
                    .setParameter("subject", subject.toUpperCase(Locale.ROOT))
                    .setParameter("number", number)
                    .setParameter("section", section.toUpperCase(Locale.ROOT))
                    .getResultList();
        } catch (NoResultException ex) {
            return Collections.emptyList();
        }
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
