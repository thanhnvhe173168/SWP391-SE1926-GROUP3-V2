/*
 * Click nfs://.netbeans.org/.../Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.UserController;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.User;

/**
 *
 * @author linhd
 */
@WebServlet(name = "StaffList", urlPatterns = {"/staffList"})
public class StaffList extends HttpServlet {

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
            out.println("<title>Servlet StaffList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffList at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        String search = request.getParameter("search");
        String statusParam = request.getParameter("statusId");
        String reset = request.getParameter("reset"); // Thêm tham số reset
        Integer statusID = null;

        // Reset về danh sách gốc nếu nhấn nút "Trở về"
        if ("true".equals(reset)) {
            search = null;
            statusParam = null;
        }

        // Xử lý chuyển đổi statusParam sang Integer
        if (statusParam != null && !statusParam.trim().isEmpty()) {
            try {
                statusID = Integer.parseInt(statusParam.trim());
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Giá trị trạng thái không hợp lệ: " + statusParam);
            }
        }
        
        UserDAO dao = new UserDAO();
        List<User> list;
        if(search !=null && !search.trim().isEmpty()||statusID !=null){
            list = dao.searchUser(search, statusID);
        }else{
            list= dao.getListStaff();
        }
       
       
        
        request.setAttribute("listStaff", list);
        request.getRequestDispatcher("/admin/StaffList.jsp").forward(request, response);
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
    }
}