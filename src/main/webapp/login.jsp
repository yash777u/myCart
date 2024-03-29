
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Login - MyCart </title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>            <%-- ........... Navigation bar loaded here ...........--%>
        <div class="container">                                      <%-- ------ Container so that it could be in Mid ----- --%>
            <div class="row">                                               <%-- ********* Row class here ************--%>
                <div class="col-md-4 offset-md-4">
                    <div class="card mt-3">                                     <%-- Card Starts here --%>

                        <div class="card-header custom-bg text-white ">
                            <h3> Login Here </h3>                               <%-- Card Header  --%>
                        </div>

                        <div class="card-body">                                 <%-- _____Card body_____ --%>

                            <%@include file="components/message.jsp" %>         <%-- Message is displayed or called at this place --%>

                            <form action="LoginServlet" method="post">          <%-- ________Form Starts Here_____________ --%>
                                <div class="form-group">

                                    <label for="exampleInputEmail1">Email address</label>               <%-- ________Email Address____ --%>
                                    <input name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>          <%-- ______Passsword_____ --%>
                                    <input name="password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                </div>

                                <div class="container text-center">
                                    <%-- +++++++ Submit and Reset Button Present here ++++++ --%>
                                    <button type="submit" class="btn btn-primary custom-bg text-white border-0">Submit</button>
                                    <button type="reset" class="btn btn-primary custom-bg text-white border-0">Reset</button><br>

                                    <%-- ...... Redirect to register.jsp ,,,,,,,, --%>
                                    <a href="register.jsp" class="mb-15">if not registered click here !!</a> <br>

                                </div>
                            </form>  
                        </div>

                    </div>

                </div>
            </div>
        </div>

        
    </body>
</html>
