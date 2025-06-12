/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.OrderController;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;
import dao.*;
import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/OrderDetailServlet"})
public class OrderDetailServlet extends HttpServlet {

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
        String[] list_id = (String[]) request.getAttribute("list_id");
        OrderDetail ord =new OrderDetail();
        CartDetailDAO cddao = new CartDetailDAO();
        OrderDAO odao = new OrderDAO();
        OrderDetailDAO orddao = new OrderDetailDAO();
        CartDAO cdao=new CartDAO();
        LaptopDAO ldao =new LaptopDAO();
        for (String id : list_id) {
            CartDetail cd = cddao.GetCartDetail(Integer.parseInt(id));

            ord.setOrderID(odao.GetLastOrderID(1));
            ord.setLaptop(ldao.GetLaptop(Integer.parseInt(id)));
            ord.setUnitPrice(cd.getUnitPrice());
            ord.setQuantity(cd.getQuantity());
            orddao.addorderdetail(ord);
            cddao.Remove(cd);
            ldao.updateLaptopStock(Integer.parseInt(id), cd.getLaptop().getStock()-cd.getQuantity());
        }
        Cart cart = cdao.GetCartByUserID(1);
        List<CartDetail> listcard = cddao.ListCart(cart.getCartID());
        BigDecimal totalcart = new BigDecimal(0);
        for (CartDetail cd : listcard) {
            if (cd.isIsSelect() == true) {
                totalcart = totalcart.add(cd.getUnitPrice().multiply(BigDecimal.valueOf(cd.getQuantity())));
            }
        }
        cdao.uppdateTotal(cart.getCartID(), totalcart);
        response.sendRedirect("home");
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
