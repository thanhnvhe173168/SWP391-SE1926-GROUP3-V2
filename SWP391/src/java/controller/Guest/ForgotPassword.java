/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Guest;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import utils.EmailUtils;
import utils.PasswordUtils;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ForgotPassword", urlPatterns = {"/forgotPassword"})
public class ForgotPassword extends HttpServlet {

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
        request.getRequestDispatcher("/guest/ForgotPassword.jsp").forward(request, response);
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
        UserDAO userDao = new UserDAO();
        String email = request.getParameter("email");
        User user = userDao.checkExistUser(email);
        if (user == null) {
            request.setAttribute("error", "Email không tồn tại");
            request.getRequestDispatcher("/guest/ForgotPassword.jsp").forward(request, response);
            return;
        }
        String newPassword = PasswordUtils.generateRandomPassword();
        String content = "<h3>Xin chào " + user.getFullName() + ",</h3>"
                + "<p>Mật khẩu mới của bạn: " + newPassword + "</p>";
        boolean checkSendMail = EmailUtils.sendEmail(user.getEmail(), "Reset mật khẩu", content);
        System.err.print("dsvasvasv" + checkSendMail);
        if (!checkSendMail) {
            request.setAttribute("error", "Gửi email thất bại. Vui lòng thử lại sau.");
            return;
        }
        String hashPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt(12));
        User newUser = new User(
                user.getUserID(),
                user.getFullName(),
                user.getEmail(),
                user.getPhoneNumber(),
                hashPassword,
                user.getRegistrationDate(),
                user.getRoleID(),
                user.getStatusID()
        );
        int check = userDao.updateUser(newUser);
        if (check > 0) {
            response.sendRedirect("login");
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
