/*
 * Click nfs://.netbeans.org/.../Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.UserController;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author linhd
 */
@WebServlet(name = "ChangeStatusAccount", urlPatterns = {"/changeStatusAccount"})
public class ChangeStatusAccount extends HttpServlet {

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
        // Log request
        System.out.println("Received request: userId=" + request.getParameter("userId") + ", statusId=" + request.getParameter("statusId"));

        // Lấy thông tin từ request
        String userIdStr = request.getParameter("userId");
        String statusIdStr = request.getParameter("statusId");

        if (userIdStr == null || statusIdStr == null) {
            System.out.println("Missing parameters!");
            response.sendRedirect(request.getContextPath() + "/staffList?message=Thiếu thông tin yêu cầu!");
            return;
        }

        int userId;
        int statusId;
        try {
            userId = Integer.parseInt(userIdStr);
            statusId = Integer.parseInt(statusIdStr);
        } catch (NumberFormatException e) {
            System.out.println("Invalid ID format: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/staffList?message=ID không hợp lệ!");
            return;
        }

        // Tạo đối tượng UserDAO
        UserDAO dao = new UserDAO();

        // Thay đổi trạng thái
        boolean isChanged = dao.changeStatus(userId, statusId);
        String message;
        if (isChanged) {
            message = "Thay đổi trạng thái thành công!";
        } else {
            message = "Thay đổi trạng thái thất bại!";
        }

        // Log kết quả
        System.out.println("Change status result: " + message);

        // Chuyển hướng về trang danh sách với thông báo
        response.sendRedirect(request.getContextPath() + "/staffList?message=" + message);
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
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Đổi trạng thái tài khoản nhân viên";
    }
}