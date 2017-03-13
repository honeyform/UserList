package com.honeyform.service;

import com.honeyform.model.User;

import java.util.List;

public interface UserService
{
    public void addUser(User user);
    public void updateUser(User user);
    public List<User> listUsers();
    public User getUserById(int id);
    public void removeUser(int id);
}