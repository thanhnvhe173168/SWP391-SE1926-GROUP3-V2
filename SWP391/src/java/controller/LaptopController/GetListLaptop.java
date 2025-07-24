/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.LaptopController;

import dao.LaptopDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "GetListLaptop", urlPatterns = {"/getListLaptop"})
public class GetListLaptop extends HttpServlet {

    private static int PAGE_SIZE = 10;

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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleID() == 3 || user.getRoleID() == 4) {
            request.getRequestDispatcher("/error/404err.jsp").forward(request, response);
        }
        LaptopDAO laptopDao = new LaptopDAO();

        ResultSet rsBrand = laptopDao.getData("Select * from Brand");
        ResultSet rsCategory = laptopDao.getData("Select * from Category");
        ResultSet rsCPU = laptopDao.getData("Select * from CPU");
        ResultSet rsScreen = laptopDao.getData("Select * from ScreenSize");

        int currentPage = request.getParameter("currentPage") != null
                ? Integer.parseInt(request.getParameter("currentPage"))
                : 1;
        String laptopName = request.getParameter("laptopName");
        int brandId = request.getParameter("brandId") != null
                ? Integer.parseInt(request.getParameter("brandId"))
                : 0;
        int categoryId = request.getParameter("categoryId") != null
                ? Integer.parseInt(request.getParameter("categoryId"))
                : 0;
        int cpuId = request.getParameter("cpuId") != null
                ? Integer.parseInt(request.getParameter("cpuId"))
                : 0;
        int screenId = request.getParameter("screenId") != null
                ? Integer.parseInt(request.getParameter("screenId"))
                : 0;
        ResultSet rsLaptop = laptopDao.getListLaptop(currentPage, PAGE_SIZE, laptopName, brandId, categoryId, cpuId,
                screenId, 0);
        int totalPage = 0;
        int totalRecord = laptopDao.getTotalRecord(laptopName, brandId, categoryId, cpuId,
                screenId, 0);
        if (totalRecord % PAGE_SIZE != 0) {
            totalPage = totalRecord / PAGE_SIZE + 1;
        } else {
            totalPage = totalRecord / PAGE_SIZE;
        }
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("rsBrand", rsBrand);
        request.setAttribute("rsCategory", rsCategory);
        request.setAttribute("rsCPU", rsCPU);
        request.setAttribute("rsScreen", rsScreen);
        request.setAttribute("rsLaptop", rsLaptop);
        request.getRequestDispatcher("/admin/LaptopManagement.jsp").forward(request, response);
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
