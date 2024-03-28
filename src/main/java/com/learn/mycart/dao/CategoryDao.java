/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.learn.mycart.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import java.util.List;
import org.hibernate.SessionFactory;

/**
 *
 * @author yash
 */
import com.learn.mycart.entities.*;
import java.sql.DriverManager;
import org.hibernate.Session;
import org.hibernate.Transaction;

        
public class CategoryDao {
    
    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }
    
   
    // Method is for saving the category into the database 
    public int saveCategory(Category cat)
    {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int catId = (int) session.save(cat);
        tx.commit();
        session.close();
        return catId;
    }
    
    // method is to reterive the categories in form of List from the Database 
    public List<Category> getCategories() {
        Session session = this.factory.openSession();
       Query query = session.createQuery("from Category");
       List<Category> list = query.list();
       session.close();
       return list;
    }
    
    public Category getCategoryId(int cid){
        Category cat = null;
        try {
            
            Session session = this.factory.openSession();
            cat = session.get(Category.class, cid);
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return cat;
    }
    
}
