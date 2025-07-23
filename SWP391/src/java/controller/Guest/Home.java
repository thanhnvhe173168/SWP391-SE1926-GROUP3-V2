/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Guest;

import dao.BlogDAO;
import dao.LaptopDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;

/**
 *
 * @author Admin
 */
@WebServlet(name = "Home", urlPatterns = {"/home"})
public class Home extends HttpServlet {

    private static int PAGE_SIZE = 3;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LaptopDAO laptopDao = new LaptopDAO();
        BlogDAO blogDao = new BlogDAO();

        ResultSet rsBrand = laptopDao.getData("Select * from Brand");
        ResultSet rsCategory = laptopDao.getData("Select * from Category");
        ResultSet rsCPU = laptopDao.getData("Select * from CPU");
        ResultSet rsScreen = laptopDao.getData("Select * from ScreenSize");

        ResultSet rsBlog = blogDao.getListBlog(1, PAGE_SIZE, null, "active");

        ResultSet rsLaptop = laptopDao.getListLaptop(1, PAGE_SIZE, null, 0, 0, 0, 0, 0);
        request.setAttribute("rsBrand", rsBrand);
        request.setAttribute("rsCategory", rsCategory);
        request.setAttribute("rsCPU", rsCPU);
        request.setAttribute("rsScreen", rsScreen);
        request.setAttribute("rsLaptop", rsLaptop);
        request.setAttribute("rsBlog", rsBlog);

        request.getRequestDispatcher("/guest/HomePage.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
