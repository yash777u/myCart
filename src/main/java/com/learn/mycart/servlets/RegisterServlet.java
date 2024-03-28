package com.learn.mycart.servlets;

import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.*;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.usertype.UserType;

public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            try {
                
                // getting all the paramter from the form through post request method called getParameter() and saving it in String Variables
                String userName = request.getParameter("user_name");
                String userEmail = request.getParameter("user_email");
                String userPassword = request.getParameter("user_password");
                String userPhone = request.getParameter("user_Phone");
                String userAddress = request.getParameter("user_address");

                // Creating the User class method to store the values in the database using parameterized constructor
                User user = new User(userName, userEmail, userPassword, userPhone, "default.jpg", userAddress, "normal");

                //creating a session to perform the operations 
                Session hibernateSession = FactoryProvider.getFactory().openSession(); // hibernate session created
                HttpSession httpSession = request.getSession();                         // http session for pot method from form

                // checking if the mail already exist in system or not
                if (checkMail(userEmail)) {
                    httpSession.setAttribute("email", "This Mail Already Exist on System"); // message will be displayed if the mail already exist in the system
                    response.sendRedirect("register.jsp"); // redirect the page then o resgister.jsp
                    return;
                }
                
                // checking if the username and useremail or password is left blank
                if (userName.isBlank() || userEmail.isBlank() ||  userPassword.isBlank() ) {

                    httpSession.setAttribute("empty", "No Feild should be empty");
                    response.sendRedirect("register.jsp");
                    return;

                }

                // creating a transaction file oeject tp insert the data into database and reterive the userId
                Transaction tx = hibernateSession.beginTransaction();
                int userId = (int) hibernateSession.save(user); // user id reterived and type cast into int type 

                tx.commit();
                hibernateSession.close();   // hibernate session is closed 

                httpSession.setAttribute("message", "Registration Sucessfull !" + userId);  // message will be displayed with session file when the user sucessfullly register

                response.sendRedirect("register.jsp"); // and it's redirected to register.jsp
                return;

                /* out.println("Sucessfully Saved ");
                out.println("<br> User id is "+userId);
                 */
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // this method is created to verify the mail exist in system and called in if condition above
    
    private boolean checkMail(String email) {
        try (Session hibernateSession = FactoryProvider.getFactory().openSession()) {
            Query query = hibernateSession.createQuery("FROM User WHERE user_email = :email"); // this query is performed to check if that mail already exist ot not in the database
            query.setParameter("email", email);                                                 
            User existingUser = (User) query.uniqueResult();
            return existingUser != null;                                                // return if existing user is not null from reterived query
        } catch (Exception e) {
            e.printStackTrace();
            return false;
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
