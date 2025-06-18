/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.BlogController;

import dao.BlogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Blog;
import org.json.JSONObject;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateBlog", urlPatterns = {"/updateBlog"})
public class UpdateBlog extends HttpServlet {

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
        BlogDAO blogDao = new BlogDAO();
        int blogId = Integer.parseInt(request.getParameter("blogId"));
        Blog blog = blogDao.getBlogById(blogId);
        request.setAttribute("blog", blog);
        request.getRequestDispatcher("/admin/UpdateBlog.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        BlogDAO blogDao = new BlogDAO();
        int blogId = Integer.parseInt(request.getParameter("blogId"));
        String title = request.getParameter("title");
        String avatar = request.getParameter("avatar");
        String content = request.getParameter("content");
        boolean checkExistTitle = blogDao.checkExistBlogTitle(title, blogId);
        JSONObject json = new JSONObject();
        if (checkExistTitle) {
            json.put("message", "Tiêu đề blog đã tồn tại");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json.toString());
            return;
        }
        Blog newBlog = new Blog(blogId, avatar, title, content);
        int check = blogDao.updateBlog(newBlog);
        if (check <= 0) {
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
