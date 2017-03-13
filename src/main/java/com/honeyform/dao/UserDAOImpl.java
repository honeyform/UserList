package com.honeyform.dao;

import com.honeyform.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Date;
import java.util.List;

public class UserDAOImpl implements UserDAO
{
    private static final Logger logger = LoggerFactory.getLogger(UserDAOImpl.class);

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory)
    {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addUser(User user)
    {
        Session session = this.sessionFactory.getCurrentSession();
        user.setCreatedDate(new Date());
        session.persist(user);
        logger.info("User saved successfully, Person Details=" + user);
    }

    @Override
    public void updateUser(User user)
    {
        Session session = this.sessionFactory.getCurrentSession();
        int id = user.getId();
        Query query = session.createQuery("select createdDate from User where id=:id").setParameter("id", id);
        Date createdDate = (Date) query.uniqueResult();
        user.createdDate = createdDate;
        session.update(user);
        logger.info("User updated successfully, Person Details=" + user);
    }

    @Override
    public List<User> listUsers()
    {
        Session session = this.sessionFactory.getCurrentSession();
        List<User> usersList = session.createQuery("from User").list();
        for(User user : usersList){
            logger.info("User List::" + user);
        }
        return usersList;
    }

    @Override
    public User getUserById(int id)
    {
        Session session = this.sessionFactory.getCurrentSession();
        User user = (User) session.load(User.class, new Integer(id));
        logger.info("User loaded successfully, User details=" + user);
        return user;
    }

    @Override
    public void removeUser(int id)
    {
        Session session = this.sessionFactory.getCurrentSession();
        User user = (User) session.load(User.class, new Integer(id));
        if (user != null){
            session.delete(user);
        }
        logger.info("User deleted successfully, user details=" + user);
    }
}