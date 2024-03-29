<%@page import="com.learn.mycart.entities.User" %>
<%
    User user = (User) session.getAttribute("current-user");

    if (user == null) {
        session.setAttribute("email", "You're Not logged In");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (!user.getUserType().equals("normal")) {
            session.setAttribute("email", "INVALID REQUEST. NOT A CUSTOMER");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
         <%@include file="components/common_css_js.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <h1>This is Normal user panel</h1><%@include file="components/footer.jsp" %> <%-- Footer called here --%>
        
    </body>
</html>
