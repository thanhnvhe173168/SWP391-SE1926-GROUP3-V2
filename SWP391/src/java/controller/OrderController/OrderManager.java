/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.OrderController;

import dao.OrderDAO;
import dao.StatusDAO;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderDetail;
import model.Status;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "OrderManager", urlPatterns = {"/OrderManager"})
public class OrderManager extends HttpServlet {

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
        doPost(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        String mess = (String) request.getAttribute("mess");
        OrderDAO odao = new OrderDAO();
        UserDAO udao = new UserDAO();
        StatusDAO sdao = new StatusDAO();
        
        int page = 1;
        int pageSize = 10;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }
        int offset = (page - 1) * pageSize;
        int totalOrders = odao.countOrders();
        int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
        List<Order> list = odao.getOrdersByPage(offset, pageSize);
        List<Order> listOrderHaveReview = odao.getListOrderHaveEvaluate();
        List<Integer> listOrderIdHaveReview = new ArrayList<>();
        for (Order order : listOrderHaveReview) {
            if (!listOrderIdHaveReview.contains(order.getOrderID())) {
                listOrderIdHaveReview.add(order.getOrderID());
            }
        }
        List<Status> selectWaitConfirm = sdao.getListStatusSelectWaitConfirm();
        List<Status> selectWantCancel = sdao.getListStatusSelectWantCancel();
        List<Status> selectConfirm = sdao.getListStatusSelectConfirm();
        List<Status> selectWhenDVVCtakesuccess = sdao.getListStatusSelectWhenDVVCtakesuccess();
        List<Status> selectWhendelivering = sdao.getListStatusSelectWhendelivering();
        List<Status> selectWhenDelivered = sdao.getListStatusSelectWhenDelivered();
        List<Status> selectWhenFail= sdao.getListStatusSelectWhenFail();
        List<Status> selectWhenReShip= sdao.getListStatusSelectWhenReShip();
        List<Status> selectWhenReShipFail= sdao.getListStatusSelectWhenReShipFail();
        List<Status> selectWhenRequestReturn= sdao.getListStatusSelectWhenRequestReturn();
        List<Status> selectWhenRequestReturn1part= sdao.getListStatusSelectWhenRequestReturn1part();
        List<Status> selectWhenRequestReturnPass= sdao.getListStatusSelectWhenRequestReturnPass();
        List<Status> selectWhenDVVCTakeReturnItem= sdao.getListStatusSelectWhenDVVCTakeReturnItem();
        List<Status> selectWhenReturnItemShipping= sdao.getListStatusSelectWhenReturnItemShipping();
        List<Status> selectWhenShopTakeSuccess= sdao.getListStatusSelectWhenShopTakeSuccess();
        if (mess != null) {
            request.setAttribute("mess", mess);
        }
        request.setAttribute("listorderidhavereview", listOrderIdHaveReview);
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
        request.setAttribute("list", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("OrderStatus", "OrderList");
        request.getRequestDispatcher("admin/OrderManager.jsp").forward(request, response);
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
