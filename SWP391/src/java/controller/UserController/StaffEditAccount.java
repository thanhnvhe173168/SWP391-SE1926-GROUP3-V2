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
@WebServlet(name = "StaffEditAccount", urlPatterns = {"/staffEditAccount"})
public class StaffEditAccount extends HttpServlet {

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
            out.println("<title>Servlet StaffEditAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffEditAccount at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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

         if (user == null ||user.getRoleID() != 1 ) {
            request.getRequestDispatcher("/error/404err.jsp").forward(request, response);
        }
            UserDAO dao = new UserDAO();

    try {
        int userId = Integer.parseInt(request.getParameter("userId"));
        User userSt = dao.getStaffByID(userId);

        request.setAttribute("user", userSt);
        request.getRequestDispatcher("admin/StaffEditAccount.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("staffList");
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
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phoneNumber");
            int statusId = Integer.parseInt(request.getParameter("statusId"));
            int roleId = Integer.parseInt(request.getParameter("roleId"));

            User userS = new User();
            userS.setUserID(userId);
            userS.setFullName(fullName);
            userS.setPhoneNumber(phone);
            userS.setStatusID(statusId);
            userS.setRoleID(roleId);

            UserDAO dao = new UserDAO();
            dao.updateStaffInfo(userS);

            response.sendRedirect("staffList");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("staffList");
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
