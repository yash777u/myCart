<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("current-user");    

    if (user == null) {
        session.setAttribute("email", "You're Not logged In");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (!user.getUserType().equals("admin") && !user.getUserType().equals("normal") ) {
            session.setAttribute("email", "You're not Admin, Don't have right to Access this page");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>
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

                            <div class="form-group mt-3">
                                <label for="exampleFormControlInput1">Email</label>
                                <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="name@example.com">
                            </div>

                            <div class="form-group">
                                <label for="inputAddress">Address</label>
                                <input type="text" class="form-control" id="inputAddress" placeholder="">
                            </div>
                            <div class="form-group">
                                <label for="inputAddress2">Address 2</label>
                                <input type="text" class="form-control" id="inputAddress2" placeholder="">
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="inputCity">City</label>
                                    <input type="text" class="form-control" id="inputCity">
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="inputState">State</label>
                                    <div class="form-group col-md-12">                                     
                                        <input type="text" class="form-control" id="inputCity">
                                    </div>
                                </div>
                                <div class="form-group col-md-2">
                                    <label for="inputZip">Zip</label>
                                    <input type="text" class="form-control" id="inputZip">
                                </div>
                            </div>
                        </div>
                    </div>
                    <button class="btn btn-outline-success btn-block mt-3" style="font-size: 23px; border-radius: 5px ">Proceed</button>
                </div>
            </div>
        </div>
    </body>
</html>
