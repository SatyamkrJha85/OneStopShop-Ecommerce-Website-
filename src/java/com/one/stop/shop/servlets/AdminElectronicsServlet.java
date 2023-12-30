
package com.one.stop.shop.servlets;

import com.one.stop.shop.dao.*;
import com.one.stop.shop.entities.*;
import com.one.stop.shop.helper.*;
import java.io.File;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.*;
import oracle.jdbc.OracleConnection;

@MultipartConfig
public class AdminElectronicsServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String productID = request.getParameter("product_id");
            String categoryID = request.getParameter("category_id");
            String productName = request.getParameter("product_name");
            String productDescription = request.getParameter("product_description");
            String productPrice = request.getParameter("product_price");
            String color = request.getParameter("Color");
            String weight = request.getParameter("weight");
            String warranty = request.getParameter("Warranty");
            String countryOrigin = request.getParameter("Country_Origin");
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();

            AddProductDao pd = new AddProductDao((OracleConnection) ConnectionProvider.getConnection());

            String path = "C:\\Users\\SATYAM JHA\\OneDrive\\Documents\\NetBeansProjects\\OneStopShop\\web" + File.separator
                    + "Resources" + File.separator + "category" + File.separator + "electronics" + File.separator + imageName;

            String allpath = "C:\\Users\\SATYAM JHA\\OneDrive\\Documents\\NetBeansProjects\\OneStopShop\\web" + File.separator
                    + "Resources" + File.separator + "allproducts" + File.separator + imageName;

            if (Helper.saveFile(part.getInputStream(), path)) {
                Helper.saveFile(part.getInputStream(),allpath);
                if (pd.addElectronics(productID, Integer.parseInt(categoryID), productName, productDescription, Integer.parseInt(productPrice), color, weight, warranty, countryOrigin, imageName)) {
                    pd.addAllProducts(productID, Integer.parseInt(categoryID), productName, productDescription, Integer.parseInt(productPrice), color, weight, warranty, countryOrigin, imageName);
                    Message msg = new Message("Product added successfully", "success");

                    HttpSession s = request.getSession();
                    s.setAttribute("msg", msg);

                    response.sendRedirect("./admin_helper/electronics.jsp");
                } else {
                    Message msg = new Message("Something went wrong", "error");

                    HttpSession s = request.getSession();
                    s.setAttribute("msg", msg);
                    response.sendRedirect("./admin_helper/electronics.jsp");
                }
            } else {
                Message msg = new Message("Something went wrong", "error");

                HttpSession s = request.getSession();
                s.setAttribute("msg", msg);
                response.sendRedirect("./admin_helper/electronics.jsp");
            }
        }
    }
}
