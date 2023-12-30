<%@page import="com.one.stop.shop.entities.*"%>
<%@page import="java.util.List"%>
<%@page import="com.one.stop.shop.entities.Men"%>
<%@page import="com.one.stop.shop.dao.ProductsDao"%>
<%@page import="oracle.jdbc.OracleConnection"%>
<%@page import="com.one.stop.shop.helper.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@page errorPage="error.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    ProductsDao pd = new ProductsDao((OracleConnection) ConnectionProvider.getConnection());
    List<HomeAndLiving> homeandliving = pd.getHomeAndLiving();
    Users user = (Users) session.getAttribute("currentUser");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home and Living</title>
        <link rel="stylesheet" href="./CSS/category.css" />  
        <link rel="apple-touch-icon" sizes="180x180" href="./Resources/admin/logo.png">
        <link rel="icon" type="image/png" sizes="32x32" href="./Resources/admin/logo.png">
        <link rel="icon" type="image/png" sizes="16x16" href="./Resources/admin/logo.png">
        <style>
            body{
                font-family: sans-serif;
            }
        </style>
    </head>

    <body>
        <div style="height:5rem">
            <%@include file="./normalnavbar.jsp" %>
        </div>
        <div id="banner" style="background-image: url('./Resources/category/homeandliving/banner.jpg');"></div>

        <!--products-->
        <%            
            if (!homeandliving.isEmpty()) {
                for (HomeAndLiving m : homeandliving) {
        %>
        <div class="item">
            <a href="product_homeandliving.jsp?productId=<%= m.getpID()%>" style="display:flex">
                <div class="product1" style="background-image: url('./Resources/category/homeandliving/<%= m.getImage()%>');"></div>
                <div id=text>
                    <p id="heading"><b><%=m.getpName()%></b></p>
                    <br>
                    <p style="font-size:16px"><%=m.getpDetails()%></p>
                </div>
                <div id="verticle-line"></div>
            </a>
            <div id="last">
                <b id="price">&#8377;<%=m.getPrice()%></b>
                <%
                    if (user != null) {
                %>
                <a href="CartServlet?id=<%=m.getpID()%>&uid=<%=user.getuEmail()%>&qty=1&return=<%=request.getRequestURI()%>">
                    <button class="add-to-cart-button">
                        <i class="fas fa-cart-plus" style="color:white"></i> Add to Cart
                    </button>
                </a>
                <%} else {%>
                <a href="#" onclick="redirect()">
                    <button class="add-to-cart-button">
                        <i class="fas fa-cart-plus" style="color:white"></i> Add to Cart
                         </button>
                </a>
                <% } %>
            </div>
        </div>
        <%
                }
            }
        %>
        <div id="toast"></div>

        <script src="./JAVASCRIPT/addtocart.js"></script>
        <script src="./JAVASCRIPT/landing.js"></script>
        <%
            String jsCode = (String) session.getAttribute("jsCode");
        %>
        <script>
            <%= jsCode%>
        </script>
        <%
            session.removeAttribute("jsCode");
        %>
    </body>
</html>