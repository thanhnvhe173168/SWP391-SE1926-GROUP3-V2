/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.CartController;

import dao.CartDAO;
import model.*;
import dao.CartDetailDAO;
import dao.LaptopDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "RemoveFromCart", urlPatterns = {"/RemoveFromCart"})
public class RemoveFromCart extends HttpServlet {

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
            out.println("<title>Servlet RemoveFromCart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RemoveFromCart at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleID() != 3 ) {
            request.getRequestDispatcher("/error/404err.jsp").forward(request, response);
        }
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        CartDetailDAO cartdetaildao = new CartDetailDAO();
        String id_raw = request.getParameter("id");
        CartDAO cdao = new CartDAO();
        Cart cart = cdao.GetCartByUserID(user.getUserID());
        List<CartDetail> listcartdetail = new ArrayList<>();
        listcartdetail = cartdetaildao.ListCart(cart.getCartID());
        BigDecimal total = BigDecimal.valueOf(0);
        try {
            int id = Integer.parseInt(id_raw);
            for (CartDetail cd : listcartdetail) {
                if (cd.getLaptop().getLaptopID() == id) {
                    cartdetaildao.Remove(cd);
                    listcartdetail.remove(cd);
                    for (CartDetail cartdetail : listcartdetail) {
                        if (cartdetail.isIsSelect() == true) {
                            total = total.add(cartdetail.getUnitPrice().multiply(BigDecimal.valueOf(cartdetail.getQuantity())));
                        }
                    }
                    cdao.uppdateTotal(cart.getCartID(), total);
                    request.getRequestDispatcher("CartSeverlet").forward(request, response);
                    return;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
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
