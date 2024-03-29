<%-- 
    Document   : checkout
    Created on : Mar 29, 2024, 9:27:46 AM
    Author     : yash
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Page</title>
    </head>
    <body>
        <%@include file="components/common_css_js.jsp" %>
        <%@include file="components/navbar.jsp" %> <%-- Navigation Bard called here --%>

        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h4 class="text-center mt-5">Details of Products</h4>
                    <div class="card mt-3">
                        <div class="cart-body"></div>
                    </div>
                </div>
                <div class="col-md-6">
                    <h4 class="text-center mt-5">Shipping Details</h4>
                    <div class="card mt-3">
                        <div class="card-body">

                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" id="">First and last name</span>
                                </div>
                                <input type="text" class="form-control">
                                <input type="text" class="form-control">
                            </div>

                            <div class="input-group mt-3 mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" id="basic-addon1">@</span>
                                </div>
                                <input type="text" class="form-control" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1">
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
