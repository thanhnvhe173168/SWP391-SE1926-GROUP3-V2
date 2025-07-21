/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Feedback;

import dao.FeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Feedback;
import model.User;

/**
 *
 * @author linhd
 */
@WebServlet(name = "UpdateFeedback", urlPatterns = {"/updateFeedback"})
public class UpdateFeedback extends HttpServlet {

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
            out.println("<title>Servlet UpdateFeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateFeedback at " + request.getContextPath() + "</h1>");
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
        String id = request.getParameter("feedbackID");
        if(id==null || id.isEmpty() ){
            System.out.println("Thiếu tham số feedBackID");
        }
        try {
            int feedbackID = Integer.parseInt(id);
        FeedbackDAO dao = new FeedbackDAO();
        Feedback fb = dao.getFeedbackByID(feedbackID);

        if (fb != null) {
            request.setAttribute("feedback", fb);
            request.getRequestDispatcher("user/UpdateFeedback.jsp").forward(request, response);
        } else {
            response.getWriter().println("Feedback không tồn tại!");
        }
        } catch (NumberFormatException e) {
            System.out.println("ID không hợp lệ " + id);
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
            int laptopID = Integer.parseInt(request.getParameter("laptopID"));
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            int rating = Integer.parseInt(request.getParameter("rating"));
            int sellerRating = Integer.parseInt(request.getParameter("sellerRating"));
            int shippingRating = Integer.parseInt(request.getParameter("shippingRating"));

            System.out.println("FeedbackID: " + feedbackID);
            System.out.println("UserID: " + user.getUserID());
            

            FeedbackDAO dao = new FeedbackDAO();
            int productId = Integer.parseInt(request.getParameter("productId"));
            int update = dao.updateFeedback(feedbackID,laptopID,orderID, user.getUserID(), title, content, rating, sellerRating, shippingRating);
            
            System.out.println("Rows updated: " + update);

            if (update > 0) {
                response.sendRedirect("productDetail?productId=" + productId);

            
        } else {
            response.sendRedirect("login");
        }
    
        }}
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
