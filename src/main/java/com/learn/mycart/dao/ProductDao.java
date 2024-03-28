package com.learn.mycart.dao;

import com.learn.mycart.entities.Product;
import java.time.LocalDateTime;
import org.hibernate.query.Query;
import java.util.List;
import javax.persistence.TemporalType;
import org.hibernate.Session;

import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class ProductDao {

    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    // saving the Product with this function
    public boolean saveProduct(Product pro) {
        boolean ret = false;

        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            session.save(pro);

            tx.commit();
            session.close();
            ret = true;
        } catch (Exception e) {
            e.printStackTrace();
            ret = false;
        }
        return ret;
    }

    //get all products 
    public List<Product> getAllProducts() {
        Session session = this.factory.openSession();
        Query query = session.createQuery("from Product");
        List<Product> lis = query.list();
        
        return lis;
    }
    
    public List<Product> getAllProductsByCategoryId( int cid) {
        Session session = this.factory.openSession();
        Query query = session.createQuery("from Product as p where p.category.categoryId =: id ");
        query.setParameter("id",cid);
        List<Product> lis = query.list();
        
        return lis;
    }

}
