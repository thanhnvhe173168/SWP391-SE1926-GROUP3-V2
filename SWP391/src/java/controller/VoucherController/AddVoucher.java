/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.VoucherController;

import dao.VoucherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import model.User;
import model.Voucher;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "AddVoucher", urlPatterns = {"/AddVoucher"})
public class AddVoucher extends HttpServlet {

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
            out.println("<title>Servlet AddVoucher</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddVoucher at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleID() != 1) {
            request.getRequestDispatcher("/error/404err.jsp").forward(request, response);
        }
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        VoucherDAO vdao = new VoucherDAO();
        String vouchercode = request.getParameter("vouchercode");
        String vouchertype = request.getParameter("vouchertype");
        String quantity0 = request.getParameter("quantity");
        String discount0 = request.getParameter("discount");
        String mess = "";
        try {
            int quantity = Integer.parseInt(quantity0);
            double disount1 = Double.parseDouble(discount0);
            BigDecimal discount = BigDecimal.valueOf(disount1);
            List<Voucher> voucherlist = new ArrayList<>();
            voucherlist = vdao.GetListVoucher();
            for (Voucher v : voucherlist) {
                if (v.getVouchercode().equals(vouchercode) || (v.getVouchertype().equals(vouchertype) && v.getDiscount().compareTo(discount) == 0)) {
                    mess = "Voucher đã tồn tại :(";
                    request.setAttribute("mess", mess);
                    request.getRequestDispatcher("admin/AddVoucher.jsp").forward(request, response);
                    return;
                }
            }
            Voucher v = new Voucher();
            v.setVouchercode(vouchercode);
            v.setVouchertype(vouchertype);
            v.setQuantity(quantity);
            v.setDiscount(discount);
            mess = "Thêm Voucher thành công :)";
            vdao.AddVoucher(v);
            request.setAttribute("mess", mess);
            request.getRequestDispatcher("admin/AddVoucher.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.getRequestDispatcher("admin/AddVoucher.jsp").forward(request, response);
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
