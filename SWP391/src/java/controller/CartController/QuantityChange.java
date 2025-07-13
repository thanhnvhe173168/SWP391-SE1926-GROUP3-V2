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
import java.io.BufferedReader;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import org.json.JSONObject;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "QuantityChange", urlPatterns = {"/QuantityChange"})
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
        doGet(request, response);
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
        CartDAO cdao = new CartDAO();
        Cart cart = cdao.GetCartByUserID(user.getUserID());
        StringBuilder sb = new StringBuilder();
        CartDetailDAO cddao = new CartDetailDAO();
        String mess = "";
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        try {
            JSONObject json = new JSONObject(sb.toString());
            int productId = json.getInt("productId");
            int quantity = json.getInt("quantity");
            BigDecimal total = BigDecimal.ZERO;
            BigDecimal itemTotal = BigDecimal.ZERO;

            // Cập nhật số lượng sản phẩm được chỉnh
            CartDetail cd = cddao.GetCartDetail(productId);
            cd.setQuantity(quantity);
            cddao.updateQuantity(cart.getCartID(), productId, quantity);
            itemTotal = cd.getUnitPrice().multiply(BigDecimal.valueOf(quantity));
            // Tính lại tổng tiền các sản phẩm được chọn
            List<CartDetail> listcartdetail = cddao.ListCart(cart.getCartID());
            for (CartDetail cd1 : listcartdetail) {
                if (cd1.isIsSelect()) {
                    total = total.add(cd1.getUnitPrice().multiply(BigDecimal.valueOf(cd1.getQuantity())));
                }
            }
            cdao.uppdateTotal(cart.getCartID(), total);
            // Trả JSON phản hồi
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            JSONObject responseJson = new JSONObject();
            responseJson.put("itemTotal", formatCurrency(itemTotal));
            responseJson.put("totalPrice", formatCurrency(total));

            PrintWriter out = response.getWriter();
            out.print(responseJson.toString());
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid JSON or server error");
        }
    }

    private String formatCurrency(BigDecimal value) {
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        return formatter.format(value) + " VNĐ";
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
