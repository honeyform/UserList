package com.honeyform.service;

import com.honeyform.dao.UserDAO;
import com.honeyform.model.User;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public class UserServiceImpl implements UserService
{
    private UserDAO userDAO;

    public void setUserDAO(UserDAO userDAO)
    {
        this.userDAO = userDAO;
    }

    @Override
    @Transactional
    public void addUser(User user)
    {
        this.userDAO.addUser(user);
    }

    @Override
    @Transactional
    public void updateUser(User user)
    {
        this.userDAO.updateUser(user);
    }

    @Override
    @Transactional
    public List<User> listUsers() {
        return this.userDAO.listUsers();
    }

    @Override
    @Transactional
    public User getUserById(int id) {
        return this.userDAO.getUserById(id);
    }

    @Override
    @Transactional
    public void removeUser(int id) {
        this.userDAO.removeUser(id);
    }
}