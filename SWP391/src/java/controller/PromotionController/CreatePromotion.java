/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.PromotionController;

import dao.PromotionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Promotion;
import model.PromotionLaptop;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CreatePromotion", urlPatterns = {"/createPromotion"})
public class CreatePromotion extends HttpServlet {

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
        request.getRequestDispatcher("/admin/CreatePromotion.jsp").forward(request, response);
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
        try {
            PromotionDAO promotionDao = new PromotionDAO();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            StringBuilder buffer = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            String data = buffer.toString();
            JSONObject jsonObject = new JSONObject(data);
            String title = jsonObject.getString("title");
            String imgae = jsonObject.getString("image");
            Date startDate = dateFormat.parse(jsonObject.getString("startDate"));
            Date endDate = dateFormat.parse(jsonObject.getString("endDate"));
            Promotion promotion = new Promotion(imgae, title, startDate, endDate);
            JSONArray productsArray = jsonObject.getJSONArray("products");
            ArrayList<PromotionLaptop> promotionLaptops = new ArrayList<>();
            for (int i = 0; i < productsArray.length(); i++) {
                JSONObject productJSON = productsArray.getJSONObject(i);
                int productId = productJSON.getInt("productId");
                double discountPrice = productJSON.getDouble("discountPrice");
                promotionLaptops.add(new PromotionLaptop(productId, BigDecimal.valueOf(discountPrice)));
            }
            promotionDao.createPromotion(promotion, promotionLaptops);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            JSONObject responseJson = new JSONObject();
            responseJson.put("success", true);
            response.getWriter().write(responseJson.toString());
        } catch (ParseException ex) {
            Logger.getLogger(CreatePromotion.class.getName()).log(Level.SEVERE, null, ex);
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
