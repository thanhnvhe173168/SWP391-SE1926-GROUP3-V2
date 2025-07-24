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

        String userIdStr = request.getParameter("userId");
        String statusIdStr = request.getParameter("statusId");
        String redirectPage = request.getParameter("redirectPage");

        if (userIdStr == null || statusIdStr == null || redirectPage == null) {
            response.sendRedirect("home");
        }
        UserDAO dao = new UserDAO();
        try {
            int userId = Integer.parseInt(userIdStr);
            int statusId = Integer.parseInt(statusIdStr);
            boolean isChanged = dao.changeStatus(userId, statusId);
            String message = "";
            if (isChanged) {
                message = "Change status is successfull!";
            } else {
                message = "Change status is failed!";
            }

            if ("staff".equalsIgnoreCase(redirectPage)) {
                response.sendRedirect("staffList");
            } else if ("user".equalsIgnoreCase(redirectPage)) {
                response.sendRedirect("userList");
            } else {
              
                response.sendRedirect("home");
            }
        } catch (NumberFormatException e) {
             response.sendRedirect("home");
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
