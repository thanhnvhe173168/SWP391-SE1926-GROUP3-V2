/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.UserController;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.regex.Pattern;
import model.User;

/**
 *
 * @author linhd
 */
public class createUser extends HttpServlet {

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
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        String roleID = request.getParameter("roleID");
        String statusID = request.getParameter("statusID");

        StringBuilder errors = new StringBuilder();//thu thap va kiem tra các lỗi đầu vào
        UserDAO u = new UserDAO();

        int roleIDInt = 0;
        int statusIDInt = 0;

        // Validate Full Name
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.append("Please enter the name<br>");
            System.out.println("Please enter the name");
        }

        // Validate Email
        if (email == null || email.trim().isEmpty()) {
            errors.append("Please enter the email<br>");
            System.out.println("Please enter the email");
        } else if (!Pattern.matches("^[A-Za-z0-9+_.-]+@(.+)$", email)) {
            errors.append("Email not valid<br>");
            System.out.println("Email not valid");
        } else if (u.checkExistUser(email) != null) {
            errors.append("Email already exists<br>");
            System.out.println("Email already exists");
        }

        // Validate Password
        if (password == null || password.trim().isEmpty()) {
            errors.append("Please enter the password<br>");
            System.out.println("Please enter the password");
        } else if (password.length() < 6) {
            errors.append("Password must be at least 6 characters<br>");
            System.out.println("Password must be at least 6 characters");
        }

        // Validate Phone Number
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            errors.append("Please enter the phone number<br>");
            System.out.println("Please enter the phone number");
        } else if (!Pattern.matches("^[0-9]{10,11}$", phoneNumber)) {
            errors.append("Phone number must be 10 or 11 digits<br>");
            System.out.println("Phone number must be 10 or 11 digits");
        }

        // Validate Role
        if (roleID == null || roleID.trim().isEmpty()) {
            errors.append("Please choose the role<br>");
            System.out.println("Please choose the role");
        } else {
            try {
                roleIDInt = Integer.parseInt(roleID);
                if (roleIDInt < 1 || roleIDInt > 3) {
                    errors.append("Role not valid<br>");
                    System.out.println("Role not valid");
                }
            } catch (Exception e) {
                errors.append("Role not valid<br>");
                System.out.println("Role not valid");
            }
        }

        // Validate Status
        if (statusID == null || statusID.trim().isEmpty()) {
            errors.append("Please choose the status<br>");
            System.out.println("Please choose the status");
        } else {
            try {
                statusIDInt = Integer.parseInt(statusID);
                if (statusIDInt < 1 || statusIDInt > 2) {
                    errors.append("Status not valid<br>");
                    System.out.println("Status not valid");
                }
            } catch (Exception e) {
                errors.append("Status not valid<br>");
                System.out.println("Status not valid");
            }
        }

        // Nếu có lỗi thì gửi lại form
        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString());
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("password", password);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("roleID", roleID);
            request.setAttribute("statusID", statusID);
            request.getRequestDispatcher("admin/CreateUser.jsp").forward(request, response);
            return;
        }

        // Nếu không có lỗi thì thêm người dùng
        try {
            User newUser = new User(0, fullName, fullName, email, phoneNumber, password, LocalDate.now(), roleIDInt, statusIDInt);
            u.addUser(newUser);
            response.sendRedirect("UserList?success=User added successfully.");
        } catch (Exception e) {
            request.setAttribute("error", "Error when adding user: " + e.getMessage());
            request.getRequestDispatcher("admin/CreateUser.jsp").forward(request, response);
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
