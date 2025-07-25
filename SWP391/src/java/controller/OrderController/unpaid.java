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
@WebServlet(name = "unpaid", urlPatterns = {"/unpaid"})
public class unpaid extends HttpServlet {

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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleID() ==4) {
            request.getRequestDispatcher("/error/404err.jsp").forward(request, response);
            return;
        }
        response.setContentType("text/html;charset=UTF-8");
        String id_raw = request.getParameter("id");
        StatusDAO sdao = new StatusDAO();
        OrderDAO odao = new OrderDAO();
        OrderDetailDAO oddao = new OrderDetailDAO();
        CategoryDAO cdao = new CategoryDAO();
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
                int totalOrders = odao.countOrdersByPaymentstatusIDAndUserID(26, user.getUserID());
                int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
                List<Order> list = odao.getUserOrdersByPageAndPaymentstatusID(offset, pageSize, user.getUserID(), 26);
                request.setAttribute("udao", udao);
                request.setAttribute("title", "Unpaid order");
                request.setAttribute("cdao", cdao);
                request.setAttribute("oddao", oddao);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("OrderStatus", "unpaid");
                request.setAttribute("list", list);
                request.getRequestDispatcher("user/OrderList.jsp").forward(request, response);
            } else if (id == 2) {
                int totalOrders = odao.countOrdersByPaymentstatusID(26);
                int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
                List<Order> orderlist = odao.getOrdersByPageAndPaymentstatusID(offset, pageSize, 26);
                List<Status> selectWaitConfirm = sdao.getListStatusSelectWaitConfirm();
                List<Status> selectWantCancel = sdao.getListStatusSelectWantCancel();
                List<Status> selectConfirm = sdao.getListStatusSelectConfirm();
                List<Status> selectWhenDVVCtakesuccess = sdao.getListStatusSelectWhenDVVCtakesuccess();
                List<Status> selectWhendelivering = sdao.getListStatusSelectWhendelivering();
                List<Status> selectWhenDelivered = sdao.getListStatusSelectWhenDelivered();
                List<Status> selectWhenFail = sdao.getListStatusSelectWhenFail();
                List<Status> selectWhenReShip = sdao.getListStatusSelectWhenReShip();
                List<Status> selectWhenReShipFail = sdao.getListStatusSelectWhenReShipFail();
                List<Status> selectWhenRequestReturn = sdao.getListStatusSelectWhenRequestReturn();
                List<Status> selectWhenRequestReturn1part = sdao.getListStatusSelectWhenRequestReturn1part();
                List<Status> selectWhenRequestReturnPass = sdao.getListStatusSelectWhenRequestReturnPass();
                List<Status> selectWhenDVVCTakeReturnItem = sdao.getListStatusSelectWhenDVVCTakeReturnItem();
                List<Status> selectWhenReturnItemShipping = sdao.getListStatusSelectWhenReturnItemShipping();
                List<Status> selectWhenShopTakeSuccess = sdao.getListStatusSelectWhenShopTakeSuccess();
                request.setAttribute("selectWaitConfirm", selectWaitConfirm);
                request.setAttribute("selectWantCancel", selectWantCancel);
                request.setAttribute("selectConfirm", selectConfirm);
                request.setAttribute("selectWhenDVVCtakesuccess", selectWhenDVVCtakesuccess);
                request.setAttribute("selectWhendelivering", selectWhendelivering);
                request.setAttribute("selectWhenDelivered", selectWhenDelivered);
                request.setAttribute("selectWhenFail", selectWhenFail);
                request.setAttribute("selectWhenReShip", selectWhenReShip);
                request.setAttribute("selectWhenReShipFail", selectWhenReShipFail);
                request.setAttribute("selectWhenRequestReturn", selectWhenRequestReturn);
                request.setAttribute("selectWhenRequestReturn1part", selectWhenRequestReturn1part);
                request.setAttribute("selectWhenRequestReturnPass", selectWhenRequestReturnPass);
                request.setAttribute("selectWhenDVVCTakeReturnItem", selectWhenDVVCTakeReturnItem);
                request.setAttribute("selectWhenReturnItemShipping", selectWhenReturnItemShipping);
                request.setAttribute("selectWhenShopTakeSuccess", selectWhenShopTakeSuccess);
                request.setAttribute("udao", udao);
                request.setAttribute("cdao", cdao);
                request.setAttribute("oddao", oddao);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("OrderStatus", "unpaid");
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
