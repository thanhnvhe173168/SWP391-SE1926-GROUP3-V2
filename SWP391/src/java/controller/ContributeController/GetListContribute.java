/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ContributeController;

import dao.ContributeDAO;
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
@WebServlet(name = "GetListContribute", urlPatterns = {"/getListContribute"})
public class GetListContribute extends HttpServlet {

    private static final int PAGE_SIZE = 10;

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
        ContributeDAO contributeDao = new ContributeDAO();
        int currentPage = request.getParameter("currentPage") != null
                ? Integer.parseInt(request.getParameter("currentPage"))
                : 1;
        String authorName = request.getParameter("authorName");
        String orderBy = request.getParameter("orderBy") != null
                ? request.getParameter("orderBy")
                : "DESC";
        ResultSet rsContribute = contributeDao.getContribute(currentPage, PAGE_SIZE, authorName, orderBy);
        int totalPage = 0;
        int totalRecord = contributeDao.getTotalRecord("Select * from Contribute");
        if (totalRecord % PAGE_SIZE != 0) {
            totalPage = totalRecord / PAGE_SIZE + 1;
        } else {
            totalPage = totalRecord / PAGE_SIZE;
        }

        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("rsContribute", rsContribute);
        request.getRequestDispatcher("/admin/ContributeManagement.jsp").forward(request, response);
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
        processRequest(request, response);
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
