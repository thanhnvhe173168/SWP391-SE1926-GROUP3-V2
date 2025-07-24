/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.OrderController;

import dao.OrderDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.User;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "completed", urlPatterns = {"/completed"})
public class completed extends HttpServlet {

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
            out.println("<title>Servlet completed</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet completed at " + request.getContextPath() + "</h1>");
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
        OrderDAO odao = new OrderDAO();
        User user = (User) session.getAttribute("user");
        String id_raw = request.getParameter("id");
        UserDAO udao = new UserDAO();
        try {
            int id = Integer.parseInt(id_raw);
            if (id == 1) {
                List<Order> orderlist = odao.getListUserOrderByStatusName("Hoàn tất", user.getUserID());
                List<Order> orderneedreview = odao.getListUserOrderNeedEvaluate(user.getUserID());
                List<Integer> orderidneedreview = new ArrayList<>();
                for (Order order : orderneedreview) {
                    if (!orderidneedreview.contains(order.getOrderID())) {
                        orderidneedreview.add(order.getOrderID());
                    }
                }
                request.setAttribute("udao", udao);
                request.setAttribute("title", "Order Completed");
                request.setAttribute("orderidneedreview", orderidneedreview);
                request.setAttribute("OrderStatus", "completed");
                request.setAttribute("orderlist", orderlist);
                request.getRequestDispatcher("user/OrderList.jsp").forward(request, response);
            } else if (id == 2) {
                List<Order> orderlist = odao.getListOrderByStatusName("Hoàn tất");
                request.setAttribute("udao", udao);
                request.setAttribute("OrderStatus", "completed");
                request.setAttribute("orderlist", orderlist);
                request.getRequestDispatcher("admin/managecompleted.jsp").forward(request, response);
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
