package com.johnnyconsole.attendance.persistence.dao.interfaces;

import com.johnnyconsole.attendance.persistence.User;

import javax.ejb.Local;

@Local
public interface UserDao {
    User findByProxData(String facilityCode, String cardCode);
    User findByCredentials(String username);
    boolean create(User user);
    boolean update(User user);
    boolean delete(User user);
}
