package com.learn.mycart.servlets;

import com.learn.mycart.dao.*;
import com.learn.mycart.entities.Category;
import com.learn.mycart.entities.Product;
import com.learn.mycart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            // Getting the Operation type to manage 
            String op = request.getParameter("operation");

            // *********************************** AFter that Adding the Prodct Form Details from it's Model from the admin.jsp
            if (op.trim().equals("addcategory")) {

                String title = request.getParameter("catTitle");
                String description = request.getParameter("catDescription");

                Category category = new Category();

                category.setCategoryTitle(title);
                category.setCategoryDesciption(description);
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = categoryDao.saveCategory(category);

                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Category Added Sucessfully - ID " + catId);
                response.sendRedirect("admin.jsp");
                return;
            } // ++++++++++++++++++++++++++++ Adding the Product to the Database here from taking the modal with the hidden type input +++++++++++++++++++++++
            else if (op.trim().equals("addproduct")) {
                System.out.println("Control reached addproduct block");

                // Retrieve parameters from the request
                String pName = request.getParameter("pName").trim();
                String pDesc = request.getParameter("pDesc").trim();
                String pPriceStr = request.getParameter("pPrice").trim();
                String pDiscountStr = request.getParameter("pDiscount").trim();
                String pQuantityStr = request.getParameter("pQuantity").trim();
                String catIdStr = request.getParameter("catId").trim();

                try {
                    // Parse parameters to appropriate types
                    int pPrice = Integer.parseInt(pPriceStr);
                    int pDiscount = Integer.parseInt(pDiscountStr);
                    int pQuantity = Integer.parseInt(pQuantityStr);
                    int catId = Integer.parseInt(catIdStr);

                    // Retrieve the file part
                    Part part = request.getPart("pPic");

                    // Save the file to the desired location
                    String fileName = part.getSubmittedFileName();

                    // Create a new Product object
                    Product product = new Product();
                    product.setpName(pName);
                    product.setpDesc(pDesc);
                    product.setpPrice(pPrice);
                    product.setpQuantity(pQuantity);
                    product.setpDiscount(pDiscount);
                    product.setpPhoto(fileName); // Saving the filename

                    // Get the Category object from CategoryDao
                    CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
                    Category cat = catDao.getCategoryId(catId);

                    // Set the category for the product
                    product.setCategory(cat);

                    // Save the product
                    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                    pdao.saveProduct(product);

                    try {
                        // Get the path where we will store the image
                        String savePath = getServletContext().getRealPath("img") + File.separator + "productsimg" + File.separator + fileName;

                        // Create FileOutputStream for the file
                        FileOutputStream fos = new FileOutputStream(savePath);
                        InputStream is = part.getInputStream();
                        byte[] data = new byte[is.available()];
                        is.read(data);

                        fos.write(data);
                        fos.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        System.out.println("Error Present in File Image saving");
                    }

                    // Set session attribute and redirect
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("message", "Product Added Successfully");
                    response.sendRedirect("admin.jsp");
                } catch (Exception e) {
                    // Handle any exceptions, print stack trace for debugging
                    e.printStackTrace();
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
