package com.johnnyconsole.attendance.persistence;

import com.johnnyconsole.attendance.persistence.id.EnrolmentId;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name="attendance_enrollments")
@NamedQueries({
        @NamedQuery(name="Enrolment.Lookup", query="SELECT e FROM Enrolment e WHERE UPPER(e.term) = :term AND UPPER(e.subject) = :subject AND e.number = :number AND UPPER(e.section) = :section AND e.proxFC = :facilityCode AND e.proxCC = :cardCode"),
        @NamedQuery(name="Enrolment.FindByUser", query="SELECT e FROM Enrolment e WHERE e.proxFC = :facilityCode AND e.proxCC = :cardCode"),
        @NamedQuery(name="Enrolment.FindByCourseSection", query="SELECT e FROM Enrolment e WHERE UPPER(e.term) = :term AND UPPER(e.subject) = :subject AND e.number = :number AND UPPER(e.section) = :section"),
})
@IdClass(EnrolmentId.class)
public class Enrolment implements Serializable {
    @Id
    public String term;
    @Id
    public String subject;
    @Id
    public String number;
    @Id
    public String section;
    @Id
    public String proxFC;
    @Id
    public String proxCC;

    public Enrolment() {}

    public Enrolment(String term, String subject, String number, String section, String proxFC, String proxCC) {
        this.term = term;
        this.subject = subject;
        this.number = number;
        this.section = section;
        this.proxFC = proxFC;
        this.proxCC = proxCC;
    }
}
