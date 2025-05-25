/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package model;

import dal.CartDetailDAO;
import dal.LaptopDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Window 11
 */
public class QuantityChange extends HttpServlet {

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
            out.println("<title>Servlet QuantityChange</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QuantityChange at " + request.getContextPath() + "</h1>");
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
        LaptopDAO laptopdao = new LaptopDAO();
        CartDetailDAO cartdetaildao = new CartDetailDAO();
        UserDAO userdao = new UserDAO();
        String action = request.getParameter("action");
        String id_raw = request.getParameter("id");
        List<CartDetail> listcartdetail = new ArrayList<>();
        listcartdetail = cartdetaildao.ListCart(1);
        try {
            int id = Integer.parseInt(id_raw);
            if (action != null && id >= 1) {
                for (CartDetail cd : listcartdetail) {
                    if (cd.getLaptop().getLaptopID() == id) {
                        int quantity = cd.getQuantity();
                        if (action.equals("dec")) {
                            cd.setQuantity(quantity - 1);
                            cartdetaildao.updateQuantity(cd.getCart().getCartID(), id, cd.getQuantity());
                            if (cd.getQuantity() == 0) {
                                listcartdetail.remove(cd);
                                cartdetaildao.Remove(cd);
                            }
                            request.getRequestDispatcher("Cart").forward(request, response);
                            return;
                        }
                        if (action.equals("inc")) {
                            if (quantity < cd.getLaptop().getStock()) {
                                cd.setQuantity(quantity + 1);
                                cartdetaildao.updateQuantity(cd.getCart().getCartID(), id, cd.getQuantity());
                                request.getRequestDispatcher("Cart").forward(request, response);
                                return;
                            } else {
                                String mess = "Vượt quá lượng hàng trong kho";
                                request.setAttribute("mess", mess);
                                request.getRequestDispatcher("Cart").forward(request, response);
                                return;
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
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
