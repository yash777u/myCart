<%
    String message = (String) session.getAttribute("message");
    String email = (String) session.getAttribute("email");
    String empty = (String) session.getAttribute("empty");
    String login = (String) session.getAttribute("login");
    
    if (message != null) {
%>

<div class="alert alert-success alert-dismissible fade show" role="alert">
    <strong><%= message%></strong>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<%
        // Remove the message from the session after displaying it
        session.removeAttribute("message");
    }
    // end of Registeration Message 

    if (email != null) {
%>

<div class="alert alert-warning alert-dismissible fade show text-center" role="alert">
    <strong><%= email%></strong>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<%

        session.removeAttribute("email");
    }

    if (empty != null) {
%>

<div class="alert alert-warning alert-dismissible fade show text-center" role="alert">
    <strong><%= empty%></strong>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<%

        session.removeAttribute("empty");
    }

    if (login != null) {
%>

<div class="alert alert-warning alert-dismissible fade show text-center" role="alert">
    <strong><%= login%></strong>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<%

        session.removeAttribute("login");
    }
%>


