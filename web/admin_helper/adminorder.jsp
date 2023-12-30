<%@page import="com.one.stop.shop.dao.ProductsDao"%>
<%@page import="com.one.stop.shop.dao.UsersDao"%>
<%@page import="com.one.stop.shop.entities.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.one.stop.shop.dao.OrderDao"%>
<%@page import="com.one.stop.shop.helper.ConnectionProvider"%>
<%@page import="com.one.stop.shop.helper.ConnectionProvider"%>
<%@page import="oracle.jdbc.OracleConnection"%>
<%@page errorPage="error.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String user = (String) session.getAttribute("userAdmin");
    if (user == null) {
        response.sendRedirect("adminlogin.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>One Stop Shop (Admin)</title>
        <link rel="apple-touch-icon" sizes="180x180" href="../Resources/admin/logo.png">
        <link rel="icon" type="image/png" sizes="32x32" href="../Resources/admin/logo.png">
        <link rel="icon" type="image/png" sizes="16x16" href="../Resources/admin/logo.png">
        <link rel="stylesheet" href="../CSS/admin.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    </head>

    <body>
        <div class="container">
            <!-- START ASIDE -->
            <aside>
                <div class="top"> 
                    <div class="logo">
                        <img src="../Resources/admin/logo.png" alt="Logo">
                        <h2>ONE STOP<span class="danger">SHOP</span></h2>
                    </div>
                    <div class="close-btn" id="close-btn">
                        <span class="material-icons">close</span>
                    </div>
                </div>
                <div class="sidebar">
                    <a href="../admin.jsp"  id="dashboard-link">
                        <span class="material-icons">grid_view</span>
                        <h3>Dashboard</h3>
                    </a>
                    <a href="signupuser.jsp" >
                        <span class="material-icons">person</span>
                        <h3>Sign up User</h3>
                    </a>
                    <a href="loginuser.jsp">
                        <span class="material-icons">contacts</span>
                        <h3>Login User</h3>
                    </a>
                    <a href="admincomplaint.jsp" >
                        <span class="material-icons">priority_high</span>
                        <h3>Complaint Box</h3>
                    </a>
                    <a href="userfeedback.jsp">
                        <span class="material-icons">rate_review</span>
                        <h3>User Feedback</h3>
                    </a>
                    <!-- Drop Down Menu Items-->
                    <div class="dropdown-button">
                        <a href="#">
                            <span class="material-icons">shopping_cart</span>
                            <h3>Add Products</h3>
                            <span class="material-icons">arrow_drop_down</span>
                        </a>
                        <div class="dropdown-menu">
                            <a href="men.jsp">Men</a>
                            <a href="women.jsp">Women</a>
                            <a href="footwear.jsp">Footwear</a>
                            <a href="jewellery.jsp">Jewellery</a>
                            <a href="home&living.jsp">Home and living</a>
                            <a href="electronics.jsp">Electronics</a>
                        </div>
                    </div>
                    <!-- Drop Down Menu Items  End -->
                    <a href="adminorder.jsp" class="Dashboard">
                        <span class="material-icons">list</span>
                        <h3>See Orders</h3>
                        <%
                            OrderDao od = new OrderDao((OracleConnection) ConnectionProvider.getConnection());
                        %>
                        <span class="message-count"><%=od.countOrders()%></span>
                    </a>
                    <a href="../LogOutServlet?user=admin">
                        <span class="material-icons">logout</span>
                        <h3>Logout</h3>
                    </a>
                </div>
            </aside>
            <!-- END ASIDE -->
            <main>
                <div class="profileheading">
                    <h1>Dashboard</h1>
                    <div class="right">
                        <!-- PROFILE TOP START -->
                        <div class="top">
                            <button id="menu-btn">
                                <span class="material-icons">menu</span>
                            </button>
                            <div class="profile">
                                <div class="info">
                                    <p>Hey, <b>One Stop Shop</b></p>
                                    <small class="text-muted">Admin</small>
                                </div>
                            </div>
                        </div>
                        <!-- PROFILE TOP END -->
                    </div>
                </div>                
                <!-- START CHART -->
                <div class="insights">
                    <div class="sales">
                        <span class="material-icons">person</span>
                        <div class="middle">
                            <div class="left">
                                <%
                                    UsersDao ud = new UsersDao((OracleConnection) ConnectionProvider.getConnection());
                                %>
                                <h3>Registered Users</h3>
                                <h1><%=ud.countUsers()%></h1>
                            </div>
                            <div class="verifieduser">
                                <span class="material-icons">verified_user</span>
                            </div>
                        </div>
                    </div>
                    <div class="expenses">
                        <span class="material-icons">local_mall</span>
                        <div class="middle">
                            <div class="left">
                                <h3>Number Of Product</h3>
                                <%
                                    ProductsDao p = new ProductsDao((OracleConnection) ConnectionProvider.getConnection());
                                %>
                                <h1><%=p.countTotalProducts()%></h1>
                            </div>
                            <div class="progress">
                                <svg>
                                <circle cx="38" cy="38" r="34"></circle>
                                </svg>
                                <div class="number">
                                    <p>74%</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="income">
                        <span class="material-icons">category</span>
                        <div class="middle">
                            <div class="left">
                                <h3>Number of Categories</h3>
                                <h1>6</h1>
                            </div>
                            <div class="progress">
                                <svg>
                                <circle cx="38" cy="38" r="36"></circle>
                                </svg>
                                <div class="number">
                                    <p>100%</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END CHART -->

                <div class="loginuser">
                    <h2>User Orders</h2>
                    <!--  Order page code for check and select Order -->
                    <div class="container-table">
                        <div class="container-fluid">
                            <table class="table table-hover">
                                <tr class="table-primary" style="font-size: 18px;">
                                    <th>Order ID</th>
                                    <th>User ID</th>                                 
                                    <th>Product name</th>
                                    <th>Quantity</th>
                                    <th>Total Price</th>
                                    <th>Delivery Address</th>
                                    <th>Date & Time</th>
                                    <th>Status</th>
                                    <th>Select status</th>
                                    <th colspan="15" class="text-center">Action</th>
                                </tr>
                                <%
                                    List<Order> orders = od.getOrders();
                                    for (Order ord : orders) {
                                %>
                                <form action="http://localhost:8080/OneStopShop/AdminOrderUpdateServlet?pid=<%=ord.getpId()%>&oid=<%=ord.getOrderId()%>" method="post">
                                    <tr>
                                        <td ><%=ord.getOrderId()%></td>
                                        <td><%=ord.getuId()%></td>
                                        <td><%=ord.getpName()%></td>
                                        <td><%=ord.getQuantity()%></td>
                                        <td><%=ord.getPrice() * ord.getQuantity()%></td>
                                        <td><%=ord.getAddress()%></td>
                                        <td><%=ord.getOrderDate()%></td>
                                        <td><%=ord.getStatus()%></td>
                                        <td><select id="operation" name="status" class="form-select " >
                                                <option>Order confirmed</option>
                                                <option value="Shipped">Shipped</option>
                                                <option value="Out For Delivery">Out For Delivery</option>
                                                <option value="Delivered">Delivered</option>
                                                <option value="Cancelled">Cancelled</option>
                                            </select></td>
                                        <td>
                                            <button type="submit" class="btnupdate">Order Update</button>
                                        </td>
                                    </tr>
                                </form>
                                <%
                                    }
                                %>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <script src="/orders.js"></script>
        <script src="/script.js"></script>
    </body>
</html>