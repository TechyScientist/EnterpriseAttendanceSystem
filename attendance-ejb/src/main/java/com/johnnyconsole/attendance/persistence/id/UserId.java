package com.johnnyconsole.attendance.persistence.id;

import java.io.Serializable;
import java.util.Objects;

public class UserId implements Serializable {
    public String proxFC, proxCC;

    public UserId() {}

    public UserId(String proxFC, String proxCC) {
        this.proxFC = proxFC;
        this.proxCC = proxCC;
    }

    @Override
    public boolean equals(Object o) {
        if(this == o) return true;
        if(!(o instanceof UserId)) return false;
        UserId userId = (UserId) o;
        return Objects.equals(proxFC, userId.proxFC) &&
                Objects.equals(proxCC, userId.proxCC);
    }

    @Override
    public int hashCode() {
        return Objects.hash(proxFC, proxCC);
    }
}
