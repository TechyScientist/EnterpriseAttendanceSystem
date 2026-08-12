package com.johnnyconsole.attendance.persistence;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="attendance_users")
@NamedQueries({
        @NamedQuery(name="User.FindByProxData", query="SELECT u FROM User u WHERE u.proxFC = :facilityCode AND u.proxCC = :cardCode"),
        @NamedQuery(name="User.FindByCredentials", query="SELECT u FROM User u WHERE u.username = :Username")
})
public class User {
    public String lastName, firstName, username, proxFC, proxCC;
    private String password;
    public boolean isAdministrator;

    public User(String lastName, String firstName,
                String username, String password,
                String proxFC, String proxCC,
                boolean isAdministrator) {
        this.lastName = lastName;
        this.firstName = firstName;
        this.username = username;
        this.password = password;
        this.proxFC = proxFC;
        this.proxCC = proxCC;
        this.isAdministrator = isAdministrator;
    }
}
