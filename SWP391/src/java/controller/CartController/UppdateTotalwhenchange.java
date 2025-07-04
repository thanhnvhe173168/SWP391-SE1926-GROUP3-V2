                                                                                                                            /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.CartController;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.CartDetail;
import model.User;
/**
 *
 * @author Window 11
 */
@WebServlet(name = "UppdateTotalwhenchange", urlPatterns = {"/UppdateTotalwhenchange"})
public class UppdateTotalwhenchange extends HttpServlet {

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
            out.println("<title>Servlet UppdateTotalwhenchange</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UppdateTotalwhenchange at " + request.getContextPath() + "</h1>");
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
        CartDetailDAO cdDAO =new CartDetailDAO();
        BigDecimal total =new BigDecimal("0");
        HttpSession session = request.getSession(); 
        User user = (User)session.getAttribute("user");
        CartDAO cdao = new CartDAO();
        Cart cart = cdao.GetCartByUserID(user.getUserID());
        List<CartDetail> listCart=cdDAO.ListCart(cart.getCartID());
        for(CartDetail cd : listCart){
            if(cd.isIsSelect()==true){
                total=total.add(cd.getUnitPrice().multiply(BigDecimal.valueOf(cd.getQuantity())));
            }
        }
        cart.setTotal(total);
        cdao.uppdateTotal(cart.getCartID(), total);
        request.getRequestDispatcher("CartSeverlet").forward(request, response);
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
