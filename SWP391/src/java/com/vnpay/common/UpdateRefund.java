/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.vnpay.common;

import dao.OrderDAO;
import dao.PaymentDAO;
import dao.RefundDAO;
import dao.StatusDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.Order;
import model.Refund;
import model.User;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "UpdateRefund", urlPatterns = {"/UpdateRefund"})
public class UpdateRefund extends HttpServlet {

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
            out.println("<title>Servlet UpdateRefund</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateRefund at " + request.getContextPath() + "</h1>");
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
        PaymentDAO pdao = new PaymentDAO();
        RefundDAO rdao = new RefundDAO();
        OrderDAO odao = new OrderDAO();
        StatusDAO sdao = new StatusDAO();
        String orderId_req = request.getParameter("vnp_TxnRef");
        String tranNo_req = request.getParameter("vnp_TransactionNo");
        String amount_req = request.getParameter("vnp_Amount");
        String responseCode = request.getParameter("vnp_ResponseCode");
        String tranType = request.getParameter("vnp_TransactionType");
        String createDate = request.getParameter("vnp_CreateDate");
        //String status = request.getParameter("vnp_TransactionStatus");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        LocalDateTime dateTime = LocalDateTime.parse(createDate, formatter);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        BigDecimal amount = new BigDecimal(amount_req);
        int orderid = Integer.parseInt(orderId_req);
        if("00".equals(responseCode)){
        Refund refund = new Refund();
        refund.setAmount(amount);
        refund.setCreateBy(user.getFullName());
        refund.setCreateDate(dateTime);
        refund.setPaymentId(pdao.getPayment(orderid).getPaymentId());
        refund.setRefundTransactionNo(tranNo_req);
        refund.setRefundType(tranType);
        refund.setStatusId(29);
        rdao.addRefund(refund);
        Order order = odao.GetOrderByID(orderid);
        order.setPaymentstatus(sdao.GetStatus(28));
        odao.updateOrderPaymentStatus(order);
        }
        request.getRequestDispatcher("OrderManager").forward(request, response);
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
