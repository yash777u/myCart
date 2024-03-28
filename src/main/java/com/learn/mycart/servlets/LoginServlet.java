package com.learn.mycart.servlets;

import com.learn.mycart.dao.UserDao;
import com.learn.mycart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.learn.mycart.entities.*;
import com.learn.mycart.dao.*;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String email = request.getParameter("email");                   // Email is stored ina variable using the getParameter() method 
            String password = request.getParameter("password");             // Password retrived from database 

            // Validations 
            // Authentication
            UserDao userDao = new UserDao(FactoryProvider.getFactory());
            
            User user = userDao.getUserByEmailAndPassword(email, password);         // object of user class reterived with email and password and return a ID
            HttpSession httpSession = request.getSession();                         // HttpSession created Here
            
            if (user == null) {                                                            
                httpSession.setAttribute("message", "!! Oops Invalid Credentials ");          // if null is returned it redirect to login.jsp after a message
                response.sendRedirect("login.jsp");
                return;                
            } else {
                out.println("<h1>Qwlcome to My Cart<h1>" + user.getUserName());
                
                httpSession.setAttribute("current-user", user);
                
                if(user.getUserType().equals("admin")) {                            // Check if it is admin or normal user and redirect to respective panel from here under else condition
                    // calls admin.jsp
                    response.sendRedirect("admin.jsp");
                } else if (user.getUserType().equals("normal")) {
                    // calls normal.jsp
                    response.sendRedirect("normal.jsp");
                }
                else {
                    
                    out.print("<h1> User Type is Unidentified<h1>");                
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
