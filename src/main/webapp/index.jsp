<%@page import="com.learn.mycart.helper.helper"%>
<%@page import="com.learn.mycart.entities.*" %>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.dao.*"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>mycart - Home</title>


    </head>
    <body>
        <%@include file="components/common_css_js.jsp" %>
        <%@include file="components/navbar.jsp" %> <%-- Navigation Bard called here --%>
        

        <div class="container-fluid">
            <div class="row">

                <!-- +++++ Showing Categories ++++ -->
                <div class="col-md-2 list-group">
                    <a href="index.jsp?category=all" class="text-center text-white list-group-item active  mt-1" > All Categories</a>
                    <%
                        CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                        List<Category> list = cdao.getCategories();

                        for (Category p : list) {
                    %>
                    <a href="index.jsp?category=<%= p.getCategoryId()%>" class="text-center list-group-item ">  <% out.println(p.getCategoryTitle()); %>  </a>
                    <% } %>
                </div>

                <!-- +++++ Showing Products List ++++ -->
                <div class="col-md-10">

                    <%
                        String cat = request.getParameter("category");
                        ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                        List<Product> list1;

                        if (cat == null || cat.trim().equals("all")) {
                            list1 = pdao.getAllProducts();
                        } else {
                            int categoryId = Integer.parseInt(cat.trim());
                            list1 = pdao.getAllProductsByCategoryId(categoryId);
                        }
                    %>

                    <!-- Row of the Product -->
                    <div class="row mt-4">
                        <!-- ------- Col:12 ----------- -->
                        <div class="col-md-12">
                            <div class="row">
                                <%  for (Product p : list1) {%>
                                <div class="col-md-4"> <!-- Adjust the column width as needed -->
                                    <div class="card mt-3">
                                        <div class="card-body ">
                                            <div class="conatiner text-center"><img class="card-img-top m-2" src="img/productsimg/<%= p.getpPhoto()%>" style="max-height: 270px; max-width: 100%; width: auto;" alt="..."  > </div>
                                            <h5 class="card-title"><%= p.getpName()%></h5>
                                            <p class="card-text"> <%=  helper.retrun10Words(p.getpDesc())%> </p>
                                        </div>
                                        <div class="card-footer">
                                            <button class="btn custom-bg text-white mt-2" onclick="add_to_cart(<%= p.getpId()%>, '<%= p.getpName()%>',<%= p.getPriceAfterDiscount()%>)" >Add to Cart</button>

                                            <button class="btn btn-outline-success mt-2" style="font-size: 14px">&#x20B9 <%= p.getPriceAfterDiscount()%> <span class="" style="font-size: 10px; font-style: italic;">&#x20B9 <%= p.getpPrice()%> -<%= p.getpDiscount()%>%off</span> </button>
                                        </div>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>


        <!--
        <h1> MyCart</h1>
                    <h1>JSP Connectivity</h1>
        <% out.println(FactoryProvider.getFactory());%>   -->           <%-- ____________ Session Factory for Hibernate __________ --%>
        <%@include file="components/common_modals.jsp" %>
        <%@include file="components/footer.jsp" %> <%-- Navigation Bard called here --%>
    </body>
</html>
