package com.johnnyconsole.attendance.persistence.dao.interfaces;

import com.johnnyconsole.attendance.persistence.User;

import javax.ejb.Local;
import java.util.List;

@Local
public interface UserDao {
    User findByProxData(String facilityCode, String cardCode);
    User findByCredentials(String username);
    List<User> findByNameData(String firstName, String lastName);
    List<User> findInstructors();
    boolean create(User user);
    boolean update(User user);
    boolean delete(User user);
}
