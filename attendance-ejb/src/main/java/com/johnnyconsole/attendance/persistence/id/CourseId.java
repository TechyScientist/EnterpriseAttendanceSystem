package com.johnnyconsole.attendance.persistence.id;

import java.io.Serializable;
import java.util.Objects;

public class CourseId implements Serializable {
    public String term, subject, number, section;

    public CourseId() {}

    public CourseId(String term, String subject, String number, String section) {
        this.term = term;
        this.subject = subject;
        this.number = number;
        this.section = section;
    }

    @Override
    public boolean equals(Object o) {
        if(this == o) return true;
        if(!(o instanceof CourseId)) return false;
        CourseId courseId = (CourseId) o;
        return Objects.equals(term, courseId.term) &&
                Objects.equals(subject, courseId.subject) &&
                Objects.equals(number, courseId.number) &&
                Objects.equals(section, courseId.section);
    }

    @Override
    public int hashCode() {
        return Objects.hash(term, subject, number, section);
    }
}
