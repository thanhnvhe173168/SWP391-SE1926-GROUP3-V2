/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.UserController;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author linhd
 */
@WebServlet(name = "UpdateUser", urlPatterns = {"/updateUser"})
public class UpdateUser extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateUser at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String userID_raw = request.getParameter("userID");

        try {
            int userID = Integer.parseInt(userID_raw);
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByID(userID);

            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/admin/UpdateUser.jsp").forward(request, response);
            } else {
                response.sendRedirect("getListUser"); // không tìm thấy → quay lại danh sách
            }
        } catch (NumberFormatException e) {
            System.out.println("Lỗi chuyển đổi userID: " + e.getMessage());
            response.sendRedirect("getListUser");
        }
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

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        UserDAO userDAO = new UserDAO();

        try {
            int userId = Integer.parseInt(request.getParameter("userID"));
            int roleId = Integer.parseInt(request.getParameter("roleID"));
            int statusId = Integer.parseInt(request.getParameter("statusID"));

            int result = userDAO.updateUserAd(userId, roleId, statusId);

            if (result > 0) {
                response.sendRedirect("getListUser"); // Thành công → quay lại danh sách
            } else {
                request.setAttribute("message", "Cập nhật thất bại.");
                User user = userDAO.getUserByID(userId);
                request.setAttribute("user", user);
                request.getRequestDispatcher("/admin/UpdateUser.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Dữ liệu không hợp lệ.");
            request.getRequestDispatcher("/admin/UpdateUser.jsp").forward(request, response);
        }
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
