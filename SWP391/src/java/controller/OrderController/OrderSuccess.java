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
import jakarta.servlet.http.HttpSession;
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
        HttpSession session = request.getSession(); 
        User user = (User)session.getAttribute("user");
        PaymentMethodDAO paydao = new PaymentMethodDAO();
        OrderDAO oddao = new OrderDAO();
        FeeShipDAO fsdao=new FeeShipDAO();
        StatusDAO sdao=new StatusDAO();
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
            double total = Double.parseDouble(total_raw);
            Order od = new Order(user.getUserID(), LocalDate.now(), fsdao.getFeeShipByID(shipid), voudao.GetVoucherByID(voucherid), paydao.GetPaymentMethodByID(payid), phoneNumber, BigDecimal.valueOf(total), address, note, sdao.GetStatus(5),sdao.GetStatus(15),null);
            oddao.uppdateorder(od);
            request.setAttribute("paymentmethodid", payid);
            request.setAttribute("total", total);
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
