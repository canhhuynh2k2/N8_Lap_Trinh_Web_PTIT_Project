<%-- 
    Document   : home
    Created on : Apr 1, 2023, 10:10:22 PM
    Author     : Bach
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Home!!!</h1>
        <h2>Hello ${sessionScope.user.fullname}</h2>
    </body>
</html>
