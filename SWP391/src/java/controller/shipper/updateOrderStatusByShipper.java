/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.shipper;

import dao.LaptopDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.List;
import model.OrderDetail;
import org.json.JSONObject;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "updateOrderStatusByShipper", urlPatterns = {"/updateOrderStatusByShipper"})
public class updateOrderStatusByShipper extends HttpServlet {

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
            out.println("<title>Servlet updateOrderStatusByShipper</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateOrderStatusByShipper at " + request.getContextPath() + "</h1>");
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
        OrderDAO odao = new OrderDAO();
        OrderDetailDAO oddao = new OrderDetailDAO();
        LaptopDAO ldao = new LaptopDAO();
        try {
            BufferedReader reader = request.getReader();
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            JSONObject json = new JSONObject(sb.toString());
            String orderId = json.getString("orderId");
            String statusId = json.getString("newStatusID");
            int statusid = Integer.parseInt(statusId);
            int orderid = Integer.parseInt(orderId);
            List<OrderDetail> listod = oddao.GetListOrderDetailByID(orderid);
            if (statusid == 23 || statusid == 24 || statusid == 25) {
                for (OrderDetail odd : listod) {
                    if (odd.getOrderDetailStatus().getStatusID() == 18) {
                        oddao.upDateOrderDetailStatuswhenreturn(statusid, orderid, odd.getLaptop().getLaptopID());
                    }
                }
                odao.upDateOrderStatus(statusid, orderid);
            } else {
                odao.upDateOrderStatus(statusid, orderid);
                oddao.upDateOrderDetailStatusByAdmin(statusid, orderid);
            }
            response.setContentType("text/plain");
            response.getWriter().write("success");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request");
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
