<%@page import="java.util.*"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="net.bytebuddy.asm.Advice.ArgumentHandler.Factory"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.*" %>

<!-- _________It Checks and retain the user session here__________ -->

<%
    User user = (User) session.getAttribute("current-user");    

    if (user == null) {
        session.setAttribute("email", "You're Not logged In");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (!user.getUserType().equals("admin")) {
            session.setAttribute("email", "You're not Admin, Don't have right to Access this page");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>  
        <%-- Admin.jsp Page is here --%>
        <%@include file="components/common_css_js.jsp" %>
        <style>
            .card {
                box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
                transition: 0.3s;
            }
            .card:hover {
                box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
            }
        </style>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>                          <!--- NavBard is Loaded first at the Page -->

        <div class="container admin">
            <div class="container-fluid md-3">
                <%@include file="components/message.jsp" %>                   <!-- for message in this seperate JSP page is dedicated in project which is used here -->
            </div>

            <!-- ++++++++++++++++++++++++++++++++++++++++++   So Card Body is Divided into row and Coln ++++++++++++++++++++++++++++++++ -->
            <!-- First Row -->                          
            <div class="row mt-3">
                <!-- First Coln -->
                <div class="col-md-4">
                    <div class="card text-center">

                        <div class="container mt-2">
                            <img src="img/Users.png" src="User" class="img-fluid rounded" style="max-width: 110px; ">
                        </div>

                        <h1 class="text-muted text-uppercase">Users</h1>                                                <!-- ******* User ******** -->
                    </div>
                </div>

                <!-- 2nd Coln -->
                <div class="col-md-4">
                    <div class="card text-center">
                        <!-- Image Container -->
                        <div class="container mt-2">
                            <img src="img/categories.png" src="categories" class="img-fluid rounded" style="max-width: 110px; ">
                        </div>

                        <h1 class="text-muted text-uppercase">Categories</h1>                                           <!-- ******* Categories ******** -->
                    </div>
                </div>

                <!-- Third Coln -->
                <div class="col-md-4">
                    <div class="card text-center">
                        <!-- Image Container -->
                        <div class="container mt-2">
                            <img src="img/products.png" src="products" class="img-fluid rounded" style="max-width: 110px; ">
                        </div>

                        <h1 class="text-muted text-uppercase">Products</h1>                                                     <!-- ******* Products ******** -->
                    </div> 
                </div>
            </div>

            <!-- 2nd  Row -->
            <div class="row mt-5">
                <div class="col-md-4">
                    <div class="card text-center"  data-toggle="modal" data-target="#add-category-modal">
                        <!-- Image Container -->
                        <div class="container mt-2">
                            <img src="img/add cateogries.png" src="addcategories" class="img-fluid rounded" style="max-width: 110px; ">
                        </div>
                        <p class="text-muted text-uppercase">Click Here to add new Categories</p>                               <!-- ************ Add Categories ************* -->
                        <h1 class="text-muted text-uppercase"> Add Categories </h1>  
                    </div> 
                </div>
                <div class="col-md-4">
                    <div class="card text-center" data-toggle="modal" data-target="#add_product">
                        <!-- Image Container -->
                        <div class="container mt-2">
                            <img src="img/add product.png" src="addproducts" class="img-fluid rounded" style="max-width: 110px; ">
                        </div>
                        <p class="text-muted text-uppercase">Click Here To add New Product</p>                                          <!-- ******* ***** Add Products **** ******** -->
                        <h1 class="text-muted text-uppercase">Add Products</h1>  
                    </div>   
                </div>
            </div>

        </div>

        <!-- ++++++++++++++++++++++++++++++++++++++++++++++ Modal Begin +++++++++++++++++++++++++++++++++++++++++++++ -->

        <!-- Modal for Categories  -->
        <div class="modal fade"  id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg " role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill Category Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post">
                            <input type="hidden" name="operation" value="addcategory" />
                            <input type="hidden" name="operation" value="addcategory" >
                            <div class="form-group" >
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter Category Title" required />                               <!-- ******* Enter Category Title  ******** -->
                            </div> 

                            <div class="form-group">
                                <textarea style="height: 100px;" class="form-control" placeholder="Enter Categories Decription" name="catDescription" required > </textarea> <!-- ******* Enter Category Description  ******** -->
                            </div>

                            <div class="container text-center">   
                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-danger btn-hover-red" data-dismiss="modal">Close</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- End of Modal -->


        <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ Modal of Add Product ++++++++++++++++++++++++++++++++++++++ -->

        <!-- Modal -->
        <div class="modal fade" id="add_product" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Product</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data" >
                            
                            <input type="hidden" name="operation" value="addproduct" />
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Enter Titile of Product" name="pName" required />
                            </div>
                            
                            <div class="form-group">
                                <input type="text" class="form-control" style="padding-bottom: 40px" placeholder="Enter Description of Product" name="pDesc" required />
                            </div>
                            
                            <div class="form-group">
                                <input type="number" class="form-control" placeholder="Enter Product Price" name="pPrice" required /> 
                            </div>
                            
                            <div class="form-group">
                                <input type="number" class="form-control" placeholder="Enter Product Discount" name="pDiscount" required /> 
                            </div>
                            
                            <div class="form-group">
                                <input type="number" class="form-control" placeholder="Enter Product Quantity" name="pQuantity" required /> 
                            </div>
                            
                            <!-- *********** Loading the Categories into a list after getting it from Database into a List of Type Categories  ************ -->
                            
                            <% 
                                      CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                                      List<Category> list = cdao.getCategories();
                            %>
                            <div class="form-group">
                                <select name="catId" class="form-control" id="">
                                    
                                    <!-- ******* +++++ Starting a Loop and then showing it one by one in categories (Drop Down option) ++++ ******** -->
                                   
                                    <% for(Category c:list)
                                   {%>
                                    
                                    <option value=" <%= c.getCategoryId() %> "> <%= c.getCategoryTitle() %>  </option>
                                    <% } %>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="pPic">Enter Picture of Product</label>                                      <!-- ******* ++++++++++++++++++ Upload the Picture of Product ++++++++++++++++++ ******** -->
                                <input type="file" id="pPic"  name="pPic" required />
                            </div>
                            <div class="container text-center">
                                  <button type="submit" class="btn mt-2 btn-outline-success">Save changes</button>
                            </div>
                        </form>
                        
                    </div>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
               
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
