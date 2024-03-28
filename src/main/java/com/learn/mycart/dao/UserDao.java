package com.learn.mycart.dao;
// or whatever package your User class belongs to

import com.learn.mycart.entities.*;
import org.hibernate.*;
import org.hibernate.SessionFactory;

public class UserDao {

    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }

    // get user by email and password
    public User getUserByEmailAndPassword(String email, String password) {

        User user = null;

        try {

            String query = "from User where userEmail =: e and userPassword=: p ";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("e", email);
            q.setParameter("p", password);

            user = (User) q.uniqueResult();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

}
