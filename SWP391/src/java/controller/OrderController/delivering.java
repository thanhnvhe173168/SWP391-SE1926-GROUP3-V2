/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.OrderController;

import dao.CartDAO;
import dao.CategoryDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.StatusDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Cart;
import model.Order;
import model.Status;
import model.User;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "delivering", urlPatterns = {"/delivering"})
public class delivering extends HttpServlet {

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
        StatusDAO sdao = new StatusDAO();
        OrderDAO odao = new OrderDAO();
        OrderDetailDAO oddao = new OrderDetailDAO();
        CategoryDAO cdao = new CategoryDAO();
        String id_raw = request.getParameter("id");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try {
            int id = Integer.parseInt(id_raw);
            if (id == 1) {
                List<Order> list = odao.getListUserOrderByStatusName("Đang giao", user.getUserID());
                request.setAttribute("title", "Order in transit");
                request.setAttribute("cdao", cdao);
                request.setAttribute("oddao", oddao);
                request.setAttribute("OrderStatus", "delivering");
                request.setAttribute("list", list);
                request.getRequestDispatcher("user/OrderList.jsp").forward(request, response);
            } else if (id == 2) {
                List<Order> orderlist = odao.getListOrderByStatusName("Đang giao");
                List<Status> liststatus = sdao.getListStatusSelect();
                request.setAttribute("liststatus", liststatus);
                request.setAttribute("cdao", cdao);
                request.setAttribute("oddao", oddao);
                request.setAttribute("OrderStatus", "delivering");
                request.setAttribute("list", orderlist);
                request.getRequestDispatcher("admin/OrderManager.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
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
