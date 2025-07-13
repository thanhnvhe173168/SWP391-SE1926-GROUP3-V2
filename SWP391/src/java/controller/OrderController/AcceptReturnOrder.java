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
import java.util.List;
import model.Order;
import model.OrderDetail;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "AcceptReturnOrder", urlPatterns = {"/AcceptReturnOrder"})
public class AcceptReturnOrder extends HttpServlet {

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
            out.println("<title>Servlet AcceptReturnOrder</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AcceptReturnOrder at " + request.getContextPath() + "</h1>");
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
        String id_req = request.getParameter("orderID");
        String[] listlaptopid = request.getParameterValues("selectedItems");
        int count = 0;
        try {
            int id = Integer.parseInt(id_req);
            if (listlaptopid != null) {
                for (String laptopid : listlaptopid) {
                    int laptopID = Integer.parseInt(laptopid);
                    oddao.upDateOrderDetailStatuswhenreturn(18, id, laptopID);
                    count += 1;
                }
            }
            List<OrderDetail> listorderdetaill = oddao.GetListOrderDetailByID(id);
            int quantity = 0;
            for (OrderDetail orderdetail : listorderdetaill) {
                quantity += 1;
                if (orderdetail.getOrderDetailStatus().getStatusID() == 16) {
                    oddao.upDateOrderDetailStatuswhenreturn(22, id, orderdetail.getLaptop().getLaptopID());
                }
            }
            if(quantity==count){
                odao.upDateOrderStatus(18, id);
            }
            else if(count>0){
                odao.upDateOrderStatus(19, id);
            }
            else{
                odao.upDateOrderStatus(22, id);
            }
            request.setAttribute("mess", "Xác nhận thành công!");
            request.getRequestDispatcher("OrderManger").forward(request, response);
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
