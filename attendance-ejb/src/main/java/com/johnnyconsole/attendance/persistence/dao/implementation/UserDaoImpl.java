package com.johnnyconsole.attendance.persistence.dao.implementation;

import com.johnnyconsole.attendance.persistence.User;
import com.johnnyconsole.attendance.persistence.dao.interfaces.UserDao;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import java.util.Collections;
import java.util.List;
import java.util.Locale;

@SuppressWarnings("unchecked")
@Stateless
public class UserDaoImpl implements UserDao {

    @PersistenceContext(unitName="user")
    private EntityManager manager;

    @Override
    public User findByProxData(String facilityCode, String cardCode) {
        try {
            return (User) manager.createNamedQuery("User.FindByProxData")
                    .setParameter("facilityCode", facilityCode)
                    .setParameter("cardCode", cardCode)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public User findByCredentials(String username) {
        try {
            return (User) manager.createNamedQuery("User.FindByCredentials")
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public List<User> findByNameData(String firstName, String lastName) {
        try {
           return (List<User>) manager.createNamedQuery("User.FindByNameData")
                   .setParameter("firstName", "%" + firstName.toLowerCase(Locale.ROOT) + "%")
                   .setParameter("lastName", "%" + lastName.toLowerCase(Locale.ROOT) + "%")
                   .getResultList();
        } catch (NoResultException e) {
            return Collections.emptyList();
        }
    }

    @Override
    public List<User> findInstructors() {
        try {
            return (List<User>) manager.createNamedQuery("User.FindInstructors")
                    .getResultList();
        } catch (NoResultException e) {
            return Collections.emptyList();
        }
    }

    @Override
    public boolean create(User user) {
        try {
            manager.persist(user);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean update(User user) {
        return false;
    }

    @Override
    public boolean delete(User user) {
        try {
            manager.remove(manager.contains(user) ? user : manager.merge(user));
            return true;
        } catch(Exception e) {
            return false;
        }
    }
}
