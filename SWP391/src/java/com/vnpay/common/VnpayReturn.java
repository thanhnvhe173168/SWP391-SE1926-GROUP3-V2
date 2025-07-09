/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.vnpay.common;

import dao.OrderDAO;
import dao.PaymentDAO;
import dao.StatusDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import model.Order;
import model.Payment;

/**
 *
 * @author HP
 */
@WebServlet(name = "VnpayReturn", urlPatterns = {"/VnpayReturn"})
public class VnpayReturn extends HttpServlet {

    OrderDAO orderDao = new OrderDAO();
    StatusDAO stDao = new StatusDAO();

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
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);
            if (signValue.equals(vnp_SecureHash)) {
                String orderId = request.getParameter("vnp_TxnRef");

                Order order = new Order();
                order = orderDao.GetOrderByID(Integer.parseInt(orderId));

                boolean transSuccess = false;
                String transactionNo = request.getParameter("vnp_TransactionNo");
                double tranNo = Double.parseDouble(transactionNo);
                BigDecimal TranNo = BigDecimal.valueOf(tranNo);
                String amount_req = request.getParameter("vnp_Amount");
                double amount = Double.parseDouble(amount_req);
                BigDecimal Amount = BigDecimal.valueOf(amount);
                String bankcode = request.getParameter("vnp_BankCode");
                String paydate = request.getParameter("vnp_PayDate");
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
                LocalDateTime payDate = LocalDateTime.parse(paydate, formatter);
                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                    //update banking system
                    PaymentDAO pdao = new PaymentDAO();
                    order.setPaymentstatus(stDao.GetStatus(24));
                    Payment p = new Payment();
                    p.setOrderId(order.getOrderID());
                    p.setAmount(Amount.divide(BigDecimal.valueOf(100)));
                    p.setPayDate(payDate);
                    p.setBankCode(bankcode);
                    p.setTransactionNo(TranNo);
                    p.setTransactionStatus(24);
                    pdao.addpayment(p);
                    transSuccess = true;
                } else {
                    order.setPaymentstatus(stDao.GetStatus(23));
                }
                orderDao.updateOrderPaymentStatus(order);
                request.setAttribute("transResult", transSuccess);
                request.getRequestDispatcher("vnpay/paymentResult.jsp").forward(request, response);
            } else {
                //RETURN PAGE ERROR
                System.out.println("GD KO HOP LE (invalid signature)");
            }
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
