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
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author linhd
 */
@WebServlet(name="CreateAccountStaff", urlPatterns={"createAccountStaff"})
public class CreateAccountStaff extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet CreateAccountStaff</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateAccountStaff at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
          
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
      try {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String password = request.getParameter("password");
            int roleID = Integer.parseInt(request.getParameter("roleId"));
            int statusID = Integer.parseInt(request.getParameter("statusId"));
            
            UserDAO dao = new UserDAO();
            if(dao.checkExistUser(email)!=null){
                request.setAttribute("error", "Email already exists");
                request.getRequestDispatcher("admin/CreateAccountStaff.jsp").forward(request, response);
                return;
            }
            String hashPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
            User user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhoneNumber(phoneNumber);
            user.setPassword(hashPassword);
            user.setRoleID(roleID);
            user.setStatusID(statusID);
            
            int result = dao.createUser(user);
            if(result>0){
                response.sendRedirect("staffList");
            }else{
                request.setAttribute("error","Error when add new staff");
                request.getRequestDispatcher("admin/CreateAccountStaff.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
