    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.OrderController;

import dao.*;
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
import model.*;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "Ordering", urlPatterns = {"/Order"})
public class Ordering extends HttpServlet {

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
            out.println("<title>Servlet Order</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Order at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        String id_raw=request.getParameter("id");
        String ids = request.getParameter("ids");
        CartDetailDAO cartdetaildao = new CartDetailDAO();
        List<CartDetail> listordering =new ArrayList<>();
        CartDetail cd =new CartDetail();
        BigDecimal total =new BigDecimal("0");
        if(ids !=null){
            try{
                int id = Integer.parseInt(id_raw);
                int ID = Integer.parseInt(ids);
                if(ID==1){
                    HttpSession session = request.getSession();
                    List<CartDetail> listReOrder =(List<CartDetail>) session.getAttribute("listReOrder");
                    for(CartDetail cd1 : listReOrder){
                        if(cd1.getLaptop().getLaptopID()==id){
                            listordering.add(cd1);
                            total=cd1.getUnitPrice().multiply(BigDecimal.valueOf(cd1.getQuantity()));
                        }
                    }
                }
            }
            catch(NumberFormatException e){
                e.printStackTrace();
            }
        }
        else{
        try{
           int id=Integer.parseInt(id_raw);
           cd=cartdetaildao.GetCartDetail(id);
           listordering.add(cd);
           total=cd.getUnitPrice().multiply(BigDecimal.valueOf(cd.getQuantity()));
        }
        catch(NumberFormatException e){
            e.printStackTrace();
        }
        }
        request.setAttribute("total", total);
        request.setAttribute("listordering", listordering);
        request.getRequestDispatcher("user/order.jsp").forward(request, response);
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
