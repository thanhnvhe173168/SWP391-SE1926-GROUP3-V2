/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.UserController;

import dao.WishListDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author linhd
 */
@WebServlet(name = "RemoveWishList", urlPatterns = {"/removeWishList"})
public class RemoveWishList extends HttpServlet {

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
            out.println("<title>Servlet RemoveWishList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RemoveWishList at " + request.getContextPath() + "</h1>");
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
        String id_raw = request.getParameter("id");
        if (id_raw == null) {
            response.sendRedirect("wishList");
            return;
        }
        try {
            int wishlistID = Integer.parseInt(id_raw);
            WishListDAO dao = new WishListDAO();

            int check = 0;
            try {
                check = dao.removeWishList(wishlistID);
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("mess", "Lỗi khi xóa sản phẩm khỏi wishlist!");
            }

            if (check > 0) {
                request.getSession().setAttribute("mess", "Đã xóa khỏi danh sách yêu thích!");
            } else {
                request.getSession().setAttribute("mess", "Không thể xóa sản phẩm khỏi danh sách yêu thích!");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("mess", "ID sản phẩm không hợp lệ!");
            e.printStackTrace();
        }

        response.sendRedirect("wishList");
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
