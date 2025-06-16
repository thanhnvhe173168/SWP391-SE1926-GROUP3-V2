package controller.UserController;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import java.io.IOException;
import java.util.List;

public class getListUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy giá trị từ request
        String search = request.getParameter("search");
        String roleParam = request.getParameter("role");
        String statusParam = request.getParameter("status");

// Khởi tạo giá trị mặc định là null
        Integer roleID = null;
        Integer statusID = null;

// Xử lý chuyển đổi roleParam sang Integer
        if (roleParam != null && !roleParam.trim().isEmpty()) {
            try {
                roleID = Integer.parseInt(roleParam.trim());
            } catch (NumberFormatException e) {
                System.out.println("Giá trị role không hợp lệ: " + roleParam);
            }
        }

// Xử lý chuyển đổi statusParam sang Integer
        if (statusParam != null && !statusParam.trim().isEmpty()) {
            try {
                statusID = Integer.parseInt(statusParam.trim());
            } catch (NumberFormatException e) {
                System.out.println("Giá trị status không hợp lệ: " + statusParam);
            }
        }

        UserDAO dao = new UserDAO();
        List<User> list = dao.getListUser();
        List<User> listSearch = dao.searchUsers(search, roleID, statusID); 

        request.setAttribute("listU", list);
        request.setAttribute("listU", listSearch);
        request.getRequestDispatcher("admin/UserManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet hiển thị danh sách người dùng";
    }
}
