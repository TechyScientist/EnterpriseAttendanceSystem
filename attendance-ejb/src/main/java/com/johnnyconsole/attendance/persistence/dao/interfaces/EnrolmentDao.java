package com.johnnyconsole.attendance.persistence.dao.interfaces;

import com.johnnyconsole.attendance.persistence.Enrolment;

import javax.ejb.Local;
import java.util.List;

@Local
public interface EnrolmentDao {
    Enrolment lookup(String term, String subject, String number, String section, String facilityCode, String cardCode);
    List<Enrolment> findByUser(String facilityCode, String cardCode);
    List<Enrolment> findByCourseSection(String term, String subject, String number, String section);
    boolean create(Enrolment course);
    boolean delete(Enrolment course);
}
