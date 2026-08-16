package com.johnnyconsole.attendance.persistence;

import com.johnnyconsole.attendance.persistence.id.CourseId;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name="attendance_courses")
@NamedQueries({
        @NamedQuery(name="Course.Lookup", query="SELECT c FROM Course c WHERE UPPER(c.term) = :term AND UPPER(c.subject) = :subject AND c.number = :number AND UPPER(c.section) = :section"),
        @NamedQuery(name="Course.FindByTerm", query="SELECT c FROM Course c WHERE LOWER(c.term) = :term"),
        @NamedQuery(name="Course.FindSectionsByCourseNumber", query="SELECT c FROM Course c WHERE UPPER(c.subject) = :subject AND c.number = :number"),
        @NamedQuery(name="Course.FindByInstructor", query="SELECT c FROM Course c WHERE c.instructor = :instructor"),
        @NamedQuery(name="Course.FindByName", query="SELECT c FROM Course c WHERE LOWER(c.name) LIKE :name")
})
@IdClass(CourseId.class)
public class Course implements Serializable {
    @Id
    public String term;
    @Id
    public String subject;
    @Id
    public String number;
    @Id
    public String section;
    public String name, instructor;

    public Course() {}

    public Course(String term, String subject, String number, String section, String name, String instructor) {
        this.term = term;
        this.subject = subject;
        this.number = number;
        this.section = section;
        this.name = name;
        this.instructor = instructor;
    }
}
