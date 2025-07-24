/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.OrderController;

import dao.CategoryDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.StatusDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Order;
import model.Status;
import model.User;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "confirmed", urlPatterns = {"/confirmed"})
public class confirmed extends HttpServlet {

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
            out.println("<title>Servlet confirmed</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet confirmed at " + request.getContextPath() + "</h1>");
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
        StatusDAO sdao = new StatusDAO();
        OrderDAO odao = new OrderDAO();
        OrderDetailDAO oddao = new OrderDetailDAO();
        CategoryDAO cdao = new CategoryDAO();
        User user = (User) session.getAttribute("user");
        String id_raw = request.getParameter("id");
        UserDAO udao = new UserDAO();
        int page = 1;
        int pageSize = 10;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }
        int offset = (page - 1) * pageSize;
        try {
            int id = Integer.parseInt(id_raw);
            if (id == 1) {
                int totalOrders = odao.countOrdersByStatusIDAndUserID(8, user.getUserID());
                int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
                List<Order> orderlist = odao.getUserOrdersByPageAndStatusID(offset, pageSize, user.getUserID(), 8);
                request.setAttribute("udao", udao);
                request.setAttribute("title", "Order confirmed");
                request.setAttribute("cdao", cdao);
                request.setAttribute("oddao", oddao);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("OrderStatus", "confirmed");
                request.setAttribute("list", orderlist);
                request.getRequestDispatcher("user/OrderList.jsp").forward(request, response);
            } else if (id == 2) {
                int totalOrders = odao.countOrdersByStatusID(8);
                int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
                List<Order> orderlist = odao.getOrdersByPageandStatus(offset, pageSize, 8);
                List<Status> liststatus = sdao.getListStatusSelect();
                request.setAttribute("liststatus", liststatus);
                request.setAttribute("udao", udao);
                request.setAttribute("cdao", cdao);
                request.setAttribute("oddao", oddao);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("OrderStatus", "confirmed");
                request.setAttribute("list", orderlist);
                request.getRequestDispatcher("admin/OrderManager.jsp").forward(request, response);
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
