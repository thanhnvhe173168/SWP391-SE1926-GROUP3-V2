/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.LaptopController;

import dao.LaptopDAO;
import dao.StockDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.sql.ResultSet;
import model.Laptop;
import model.Stock;
import model.User;
import org.json.JSONObject;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateLaptop", urlPatterns = {"/updateLaptop"})
public class UpdateLaptop extends HttpServlet {

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
        LaptopDAO laptopDao = new LaptopDAO();
        int laptopId = Integer.parseInt(request.getParameter("laptopId"));
        Laptop laptop = laptopDao.getLaptopById(laptopId);
        ResultSet rsBrand = laptopDao.getData("Select * from Brand");
        ResultSet rsCategory = laptopDao.getData("Select * from Category");
        ResultSet rsCPU = laptopDao.getData("Select * from CPU");
        ResultSet rsScreen = laptopDao.getData("Select * from ScreenSize");

        request.setAttribute("rsBrand", rsBrand);
        request.setAttribute("rsCategory", rsCategory);
        request.setAttribute("rsCPU", rsCPU);
        request.setAttribute("rsScreen", rsScreen);
        request.setAttribute("laptop", laptop);
        request.getRequestDispatcher("/admin/UpdateLaptop.jsp").forward(request, response);
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
        LaptopDAO laptopDao = new LaptopDAO();
        StockDAO stockDao = new StockDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int laptopId = Integer.parseInt(request.getParameter("laptopId"));
        String laptopName = request.getParameter("laptopName");
        int stock = Integer.parseInt(request.getParameter("stock"));
        BigDecimal price = BigDecimal.valueOf(Double.parseDouble(request.getParameter("price")));
        String imageUrl = request.getParameter("imageUrl");
        String description = request.getParameter("description");
        String hardDrive = request.getParameter("hardDrive");
        String warrantyPeriod = request.getParameter("warrantyPeriod");
        String ram = request.getParameter("ram");
        int brandId = Integer.parseInt(request.getParameter("brandId"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int cpuId = Integer.parseInt(request.getParameter("cpuId"));
        int screenId = Integer.parseInt(request.getParameter("screenId"));
        boolean checkExistName = laptopDao.checkExistLaptopName(laptopName, laptopId);
        JSONObject json = new JSONObject();
        if (checkExistName) {
            json.put("message", "Tên sản phẩm đã tồn tại");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json.toString());
            return;
        }
        Laptop laptop = laptopDao.getLaptopById(laptopId);
        Laptop newLaptop = new Laptop(laptopId, laptopName, price, stock, description, imageUrl, hardDrive, 3, warrantyPeriod, cpuId, screenId, ram, brandId, categoryId);
        int checck = laptopDao.updateLaptop(newLaptop);
        if (stock - laptop.getStock() > 0) {
            stockDao.createStock(new Stock(laptopId, user.getUserID(), stock - laptop.getStock(), "add"));
        }
        if (checck <= 0) {
            json.put("message", "Có lỗi xảy ra");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json.toString());
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
