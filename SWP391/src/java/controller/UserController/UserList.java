package controller.UserController;

import dao.UserDAO;
import java.io.IOException;
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
@WebServlet(name = "UserList", urlPatterns = {"/userList"})
public class UserList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        String statusParam = request.getParameter("statusId"); 
        String reset = request.getParameter("reset"); 

        // Reset về danh sách gốc nếu nhấn nút "Trở về"
        if ("true".equals(reset)) {
            search = null;
            statusParam = null;
        }

        // Xử lý chuyển đổi statusParam sang Integer
        Integer statusID = null;
        if (statusParam != null && !statusParam.trim().isEmpty()) {
            try {
                statusID = Integer.parseInt(statusParam.trim());
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Giá trị trạng thái không hợp lệ: " + statusParam);
            }
        }

        UserDAO dao = new UserDAO();
        List<User> list;
        if (search != null && !search.trim().isEmpty() || statusID != null) {
            list = dao.searchUser(search, statusID); // Sử dụng phương thức searchUser
        } else {
            list = dao.getAllUser(); // Lấy tất cả nếu không có điều kiện tìm kiếm
        }

        request.setAttribute("listU", list);
        request.getRequestDispatcher("/admin/UserList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}