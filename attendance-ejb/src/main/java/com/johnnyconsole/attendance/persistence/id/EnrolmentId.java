package com.johnnyconsole.attendance.persistence.id;

import java.io.Serializable;
import java.util.Objects;

public class EnrolmentId implements Serializable {
    public String term, subject, number, section, proxFC, proxCC;

    public EnrolmentId() {}

    public EnrolmentId(String term, String subject, String number, String section,  String proxFC, String proxCC) {
        this.term = term;
        this.subject = subject;
        this.number = number;
        this.section = section;
        this.proxFC = proxFC;
        this.proxCC = proxCC;
    }

    @Override
    public boolean equals(Object o) {
        if(this == o) return true;
        if(!(o instanceof EnrolmentId)) return false;
        EnrolmentId enrolmentId = (EnrolmentId) o;
        return Objects.equals(term, enrolmentId.term) &&
                Objects.equals(subject, enrolmentId.subject) &&
                Objects.equals(number, enrolmentId.number) &&
                Objects.equals(section, enrolmentId.section) &&
                Objects.equals(proxFC,  enrolmentId.proxFC) &&
                Objects.equals(proxCC,  enrolmentId.proxCC);
    }

    @Override
    public int hashCode() {
        return Objects.hash(term, subject, number, section, proxFC, proxCC);
    }
}
