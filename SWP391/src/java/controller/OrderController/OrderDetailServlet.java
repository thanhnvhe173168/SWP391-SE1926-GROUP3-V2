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
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.Iterator;
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
        doPost(request, response);

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
        response.setContentType("text/html;charset=UTF-8");
        //String[] list_id = (String[]) request.getAttribute("list_id");
        OrderDetail ord = new OrderDetail();
        CartDetailDAO cddao = new CartDetailDAO();
        OrderDAO odao = new OrderDAO();
        OrderDetailDAO orddao = new OrderDetailDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<CartDetail> listordering = (List<CartDetail>) session.getAttribute("listordering");
        CartDAO cdao = new CartDAO();
        LaptopDAO ldao = new LaptopDAO();
        StatusDAO sdao = new StatusDAO();
        //for (String id : list_id) {
        List<CartDetail> listcartdetail = cddao.ListCart(cdao.GetCartByUserID(user.getUserID()).getCartID());
        Iterator<CartDetail> iterator = listordering.iterator();
        while (iterator.hasNext()) {
            CartDetail cd = iterator.next();

            for (CartDetail cartdetail : listcartdetail) {
                if (cartdetail.getLaptop().getLaptopID() == cd.getLaptop().getLaptopID()) {
                    cddao.Remove(cddao.GetCartDetail(cd.getLaptop().getLaptopID(), cd.getCart().getCartID()));
                }
            }

            ord.setOrderID(odao.GetLastOrderID(user.getUserID()));
            ord.setLaptop(ldao.getLaptopById(cd.getLaptop().getLaptopID()));
            ord.setUnitPrice(cd.getUnitPrice());
            ord.setQuantity(cd.getQuantity());
            ord.setOrderDetailStatus(sdao.GetStatus(5));
            ord.setIsSelect(false);
            orddao.addorderdetail(ord);

            iterator.remove();
        }
        session.setAttribute("listordering", listordering);
        Cart cart = cdao.GetCartByUserID(user.getUserID());
        List<CartDetail> listcard = cddao.ListCart(cart.getCartID());
        BigDecimal totalcart = new BigDecimal(0);
        for (CartDetail cd : listcard) {
            if (cd.isIsSelect() == true) {
                totalcart = totalcart.add(cd.getUnitPrice().multiply(BigDecimal.valueOf(cd.getQuantity())));
            }
        }
        cdao.uppdateTotal(cart.getCartID(), totalcart);
        int paymentmethodid = (int) request.getAttribute("paymentmethodid");
        double total = (double) request.getAttribute("total");
        if (paymentmethodid == 1) {
            request.setAttribute("orderId", odao.GetLastOrderID(user.getUserID()));
            request.setAttribute("totalamount", total);
            request.getRequestDispatcher("payment").forward(request, response);
        } else {
            request.getRequestDispatcher("OrderList").forward(request, response);
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
