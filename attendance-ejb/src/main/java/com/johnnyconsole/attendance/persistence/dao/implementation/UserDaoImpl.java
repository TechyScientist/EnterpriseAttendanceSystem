package com.johnnyconsole.attendance.persistence.dao.implementation;

import com.johnnyconsole.attendance.persistence.User;
import com.johnnyconsole.attendance.persistence.dao.interfaces.UserDao;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Stateless
public class UserDaoImpl implements UserDao {

    @PersistenceContext(unitName="user")
    private EntityManager manager;

    @Override
    public User findByProxData(String facilityCode, String cardCode) {
        return (User) manager.createNamedQuery("User.FindByProxData")
                .setParameter("facilityCode", facilityCode)
                .setParameter("cardCode", cardCode)
                .getSingleResult();
    }

    @Override
    public User findByCredentials(String username) {
        return (User) manager.createNamedQuery("User.FindByCredentials")
                .setParameter("username", username)
                .getSingleResult();
    }

    @Override
    public boolean create(User user) {
        return false;
    }

    @Override
    public boolean update(User user) {
        return false;
    }

    @Override
    public boolean delete(User user) {
        return false;
    }
}
