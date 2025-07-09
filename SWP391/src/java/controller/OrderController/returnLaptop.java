/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.OrderController;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.List;
import model.Order;
import model.OrderDetail;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "returnLaptop", urlPatterns = {"/returnLaptop"})
public class returnLaptop extends HttpServlet {

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
            out.println("<title>Servlet returnLaptop</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet returnLaptop at " + request.getContextPath() + "</h1>");
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
        String lapids = request.getParameter("laptopID");
        String orderids = request.getParameter("orderID");
        String reason = request.getParameter("reason");
        OrderDetailDAO oddao = new OrderDetailDAO();
        OrderDAO odao = new OrderDAO();
        LocalDate returndate = LocalDate.now();
        try{
            int lapid = Integer.parseInt(lapids);
            int orderid = Integer.parseInt(orderids);
            oddao.upDateOrderDetailStatuswhenreturn(15, orderid, lapid);
            Order od = odao.GetOrderByID(orderid);
            List<OrderDetail> orderdetailist = oddao.GetListOrderDetailByID(orderid);
            int quantity=0;
            for(OrderDetail orderdetail : orderdetailist){
                quantity=quantity+1;
            }
            if(quantity>1){
                odao.upDateOrderStatus(25, orderid);
            }
            else{
                odao.upDateOrderStatus(15, orderid);
            }
            odao.updateReasonReturn(orderid, reason, returndate);
            oddao.updateReasonReturn(orderid, lapid, reason, returndate);
            request.setAttribute("mess", "Gửi yêu cầu thành công");
            request.getRequestDispatcher("OrderList").forward(request, response);
        }
        catch(NumberFormatException e){
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
