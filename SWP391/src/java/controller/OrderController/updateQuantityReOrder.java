/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.OrderController;

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
import java.util.List;
import java.util.Locale;
import model.CartDetail;
import org.json.JSONObject;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "updateQuantityReOrder", urlPatterns = {"/updateQuantityReOrder"})
public class updateQuantityReOrder extends HttpServlet {

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
            out.println("<title>Servlet updateQuantityReOrder</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateQuantityReOrder at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        List<CartDetail> listReOrder = (List<CartDetail>) session.getAttribute("listReOrder");

        BigDecimal total = BigDecimal.valueOf(0);
        BigDecimal itemtotal = BigDecimal.valueOf(0);

        try {
            // Đọc JSON từ body
            BufferedReader reader = request.getReader();
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            JSONObject json = new JSONObject(sb.toString());
            int id = Integer.parseInt(json.getString("productId"));
            int quantity = Integer.parseInt(json.getString("quantity"));

            // Cập nhật số lượng sản phẩm
            for (CartDetail cd : listReOrder) {
                if (cd.getLaptop().getLaptopID() == id) {
                    cd.setQuantity(quantity);
                    itemtotal = cd.getUnitPrice().multiply(BigDecimal.valueOf(cd.getQuantity()));
                    break;
                }
            }

            // Tính tổng tiền các mục đã chọn
            for (CartDetail cartdetail : listReOrder) {
                if (cartdetail.isIsSelect()) {
                    total = total.add(cartdetail.getUnitPrice().multiply(BigDecimal.valueOf(cartdetail.getQuantity())));
                }
            }

            // Lưu lại danh sách đã cập nhật vào session
            session.setAttribute("listReOrder", listReOrder);

            // Trả kết quả về client
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"itemTotal\":\"" + formatCurrency(itemtotal) + "\", \"totalPrice\":\"" + formatCurrency(total) + "\"}");
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request");
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
