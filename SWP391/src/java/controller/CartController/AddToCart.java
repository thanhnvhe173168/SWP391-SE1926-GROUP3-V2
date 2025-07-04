/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.CartController;

import dao.CartDAO;
import dao.CartDetailDAO;
import dao.LaptopDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;
import model.Cart;
import model.CartDetail;
import model.Laptop;
import model.User;

/**
 *
 * @author Window 11
 */
@WebServlet(name = "AddToCart", urlPatterns = {"/AddToCart"})
public class AddToCart extends HttpServlet {

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
            out.println("<title>Servlet AddToCart</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCart at " + request.getContextPath() + "</h1>");
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
        User user =(User)session.getAttribute("user");
        LaptopDAO ldao = new LaptopDAO();
        CartDAO cdao = new CartDAO();
        CartDetailDAO cddao = new CartDetailDAO();
        String id_raw = request.getParameter("id");
        String mess="";
        Cart cart = cdao.GetCartByUserID(user.getUserID());
        BigDecimal total = cart.getTotal();
        try{
            int id = Integer.parseInt(id_raw);
            Laptop lap = ldao.getLaptopById(id);
            List<CartDetail> listcartdetail = cddao.ListCart(cart.getCartID());
            for(CartDetail cd : listcartdetail){
                if(cd.getLaptop().getLaptopID()==id){
                    mess="Sản phẩm đã có trong giỏ hàng.";
                    request.setAttribute("mess", mess);
                    request.setAttribute("icon", "warning");
                    request.getRequestDispatcher("home").forward(request, response);
                    return;
                }
            }
            CartDetail cartdetail = new CartDetail();
            cartdetail.setCart(cart);
            cartdetail.setLaptop(lap);
            cartdetail.setQuantity(1);
            cartdetail.setUnitPrice(lap.getPrice());
            cartdetail.setIsSelect(true);
            cddao.AddCart(cartdetail);
            total = total.add(cartdetail.getUnitPrice());
            cdao.uppdateTotal(cart.getCartID(), total);
            mess="Thêm vào giỏ hàng thành công !";
            request.setAttribute("mess", mess);
            request.setAttribute("icon", "success");
            request.getRequestDispatcher("home").forward(request, response);
        }
        catch(NumberFormatException e){
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
        HttpSession session = request.getSession();
        User user =(User)session.getAttribute("user");
        LaptopDAO ldao = new LaptopDAO();
        CartDAO cdao = new CartDAO();
        CartDetailDAO cddao = new CartDetailDAO();
        String id_raw = request.getParameter("productId");
        String quantity_raw = request.getParameter("quantity");
        String mess="";
        Cart cart = cdao.GetCartByUserID(user.getUserID());
        BigDecimal total = cart.getTotal();
        try{
            int quantity = Integer.parseInt(quantity_raw);
            int id = Integer.parseInt(id_raw);
            Laptop lap = ldao.getLaptopById(id);
            List<CartDetail> listcartdetail = cddao.ListCart(cart.getCartID());
            for(CartDetail cd : listcartdetail){
                if(cd.getLaptop().getLaptopID()==id){
                    mess="Sản phẩm đã có trong giỏ hàng.";
                    request.setAttribute("mess", mess);
                    request.setAttribute("icon", "warning");
                    request.getRequestDispatcher("productDetail").forward(request, response);
                    return;
                }
            }
            CartDetail cartdetail = new CartDetail();
            cartdetail.setCart(cart);
            cartdetail.setLaptop(lap);
            cartdetail.setQuantity(quantity);
            cartdetail.setUnitPrice(lap.getPrice());
            cartdetail.setIsSelect(true);
            cddao.AddCart(cartdetail);
            total = total.add(cartdetail.getUnitPrice());
            cdao.uppdateTotal(cart.getCartID(), total);
            mess="Thêm vào giỏ hàng thành công !";
            request.setAttribute("mess", mess);
            request.setAttribute("icon", "success");
            request.getRequestDispatcher("productDetail").forward(request, response);
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
