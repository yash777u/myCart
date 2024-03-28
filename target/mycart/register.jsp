
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
        <%@include file="components/common_css_js.jsp" %>                       <%-- Common Css is present here here --%>
    </head>
    <body>

        <%@include file="components/navbar.jsp" %>                              <%-- Container for the body of page here --%>
        <div class="container-fluid">

            <div class="row mt-5">
                <div class="col-md-4 offset-md-4">
                    <div class="card">                                          <%-- Card for body starts here --%>

                        <%@include file="components/message.jsp" %>             <%-- Message.jsp added here just before content in card starts --%>
                        
                        <div class="card-body px-5">
                            <a class="navbar-brand" href="#"></a>

                            <form action="RegisterServlet" method="post">       <%-- Register Servlet is added here in form to lead when action is made as post method --%>
                                
                                <img src="img/online-registration.png"  class="rounded mx-auto d-block" width="200" >

                                <h3 class="nav justify-content-center">Sign up !</h3>

                                <div class="form-group">
                                    <label for="name">User Name</label>
                                    <input type="text" name="user_name" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter here">
                                </div>


                                <div class="form-group">
                                    <label for="email">Email address</label>
                                    <input type="email" name="user_email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter here">
                                </div>



                                <div class="form-group">
                                    <label for="password">User Password</label>
                                    <input type="password" name="user_password" class="form-control" id="password" aria-describedby="emailHelp" placeholder="Enter here">
                                </div>



                                <div class="form-group">
                                    <label for="phone">User Phone</label>
                                    <input type="number" name="user_phone" class="form-control" id="phone" aria-describedby="emailHelp" placeholder="Enter here">
                                </div>



                                <div class="form-group">
                                    <label for="phone">User Address</label>
                                    <textarea name="user_address" placeholder="Enter your address" class="form-control" style="height: 90px"></textarea>
                                </div>


                                <div class="container text-center">
                                    <button class="btn btn-outline-success">Registration</button>
                                    <button class="btn btn-outline-warning">Reset</button>
                                </div>

                            </form>
                        </div>
                    </div>

                </div>
            </div>

        </div>

    </body>
</html>
