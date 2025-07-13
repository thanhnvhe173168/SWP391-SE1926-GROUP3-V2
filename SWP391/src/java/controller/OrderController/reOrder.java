/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.OrderController;

import dao.CartDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import model.Cart;
import model.CartDetail;
import model.Order;
import model.OrderDetail;
import model.User;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "reOrder", urlPatterns = {"/reOrder"})
public class reOrder extends HttpServlet {

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
            out.println("<title>Servlet reOrder</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet reOrder at " + request.getContextPath() + "</h1>");
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
        CartDAO cdao =new CartDAO();
        Cart cart = cdao.GetCartByUserID(user.getUserID());
        String ids = request.getParameter("id");
        OrderDAO odao = new OrderDAO();
        OrderDetailDAO oddao = new OrderDetailDAO();
        BigDecimal total = BigDecimal.valueOf(0);
        List<CartDetail> lists = new ArrayList<>();
        try{
            int id = Integer.parseInt(ids);
            List<OrderDetail> list = oddao.GetListOrderDetailByID(id);
            for(OrderDetail odd : list){
                CartDetail cd =new CartDetail();
                cd.setCart(cart);
                cd.setLaptop(odd.getLaptop());
                cd.setQuantity(odd.getQuantity());
                cd.setUnitPrice(odd.getUnitPrice());
                cd.setIsSelect(true);
                total=total.add(odd.getUnitPrice().multiply(BigDecimal.valueOf(odd.getQuantity())));
                lists.add(cd);
                
            }
            session.setAttribute("listReOrder", lists);
            request.setAttribute("totalPrice", total);
            request.getRequestDispatcher("user/reOrder.jsp").forward(request, response);
        }
        catch(IOException e){
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
