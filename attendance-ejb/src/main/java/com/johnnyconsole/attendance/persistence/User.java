package com.johnnyconsole.attendance.persistence;

import com.johnnyconsole.attendance.persistence.id.UserId;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name="attendance_users")
@NamedQueries({
        @NamedQuery(name="User.FindByProxData", query="SELECT u FROM User u WHERE u.proxFC = :facilityCode AND u.proxCC = :cardCode"),
        @NamedQuery(name="User.FindByCredentials", query="SELECT u FROM User u WHERE u.username = :username"),
        @NamedQuery(name="User.FindByNameData", query="SELECT u FROM User u WHERE LOWER(u.firstName) LIKE :firstName OR LOWER(u.lastName) LIKE :lastName")
})
@IdClass(UserId.class)
public class User implements Serializable {
    @Id public String proxFC;
    @Id public String proxCC;
    public String lastName, firstName, username, password;
    public boolean isAdministrator;

    public User() {}

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
