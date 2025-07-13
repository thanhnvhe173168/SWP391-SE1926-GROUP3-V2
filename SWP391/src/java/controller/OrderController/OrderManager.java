/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.OrderController;

import dao.OrderDAO;
import dao.StatusDAO;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderDetail;
import model.Status;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "OrderManager", urlPatterns = {"/OrderManager"})
public class OrderManager extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        String mess = (String) request.getAttribute("mess");
        OrderDAO odao = new OrderDAO();
        List<Order> list = odao.getListOrder();
        UserDAO udao = new UserDAO();
        StatusDAO sdao = new StatusDAO();
        List<Order> listOrderHaveReview = odao.getListOrderHaveEvaluate();
        List<Integer> listOrderIdHaveReview = new ArrayList<>();
        for (Order order : listOrderHaveReview) {
            if (!listOrderIdHaveReview.contains(order.getOrderID())) {
                listOrderIdHaveReview.add(order.getOrderID());
            }
        }
        List<Status> liststatus = sdao.getListStatusSelect();
        List<Status> listpaymentstatus = sdao.getListPaymentStatusSelect();
        if (mess != null) {
            request.setAttribute("mess", mess);
        }
        request.setAttribute("listPaymentStatus", listpaymentstatus);
        request.setAttribute("listorderidhavereview", listOrderIdHaveReview);
        request.setAttribute("liststatus", liststatus);
        request.setAttribute("udao", udao);
        request.setAttribute("list", list);
        request.setAttribute("OrderStatus", "OrderList");
        request.getRequestDispatcher("admin/OrderManager.jsp").forward(request, response);
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
