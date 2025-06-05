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
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author linhd
 */
@WebServlet(name = "ViewerUser", urlPatterns = {"/viewerUser"})
public class ViewerUser extends HttpServlet {

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
        // Kiểm tra quyền Admin
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || currentUser.getRoleID() != 1) {
            request.setAttribute("error", "Bạn không có quyền truy cập, vui lòng đăng nhập bằng tài khoản admin");
            request.getRequestDispatcher("/admin/ViewUserDetail.jsp").forward(request, response);
            return;
        }
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            request.setAttribute("error", "Thiếu tham số ID người dùng");
            request.getRequestDispatcher("/admin/ViewUserDetail.jsp").forward(request, response);
            return;
        }
        try {
            int userId = Integer.parseInt(idParam);
            UserDAO dao = new UserDAO();
            User user = dao.getUserByIDForView(userId);

            if (user == null) {
                request.setAttribute("error", "khong tim thay nguoi dung");
            }else{
                request.setAttribute("user", user);
            }
            request.getRequestDispatcher("/admin/ViewUserDetail.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "ID nguoi dung khong hop le");
            request.getRequestDispatcher("/admin/ViewUserDetail.jsp").forward(request, response);
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
