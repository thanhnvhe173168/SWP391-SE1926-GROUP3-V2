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
import java.math.BigDecimal;
import java.time.LocalDate;
import dao.*;
import model.*;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "OrderSuccess", urlPatterns = {"/OrderSuccess"})
public class OrderSuccess extends HttpServlet {

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
            out.println("<title>Servlet OrderSuccess</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderSuccess at " + request.getContextPath() + "</h1>");
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
        VoucherDAO voudao = new VoucherDAO();
        PaymentMethodDAO paydao = new PaymentMethodDAO();
        OrderDAO oddao = new OrderDAO();
        String voucher = request.getParameter("voucher");
        String shipid_raw = request.getParameter("chooseway");
        String address = request.getParameter("address");
        String note = request.getParameter("note");
        String phoneNumber = request.getParameter("PhoneNumber");
        String paymentmethod = request.getParameter("payment");
        String total_raw = request.getParameter("totalprice");
        String[] list_id=request.getParameterValues("id");
        try {
            int shipid = Integer.parseInt(shipid_raw);
            int voucherid = voudao.GetIDbyCode(voucher);
            int payid = paydao.GetPaymentIDbyMethod(paymentmethod);
            float total = Float.parseFloat(total_raw);
            Order od = new Order(1, LocalDate.now(), shipid, voucherid, payid, phoneNumber, BigDecimal.valueOf(total), address, note, 5);
            oddao.uppdateorder(od);
            
            request.setAttribute("list_id", list_id);
            request.getRequestDispatcher("OrderDetailServlet").forward(request, response);
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
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
