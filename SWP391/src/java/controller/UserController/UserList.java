package controller.UserController;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
         HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRoleID() >= 3 ) {
            request.getRequestDispatcher("/error/404err.jsp").forward(request, response);
            return;
        }
        String search = request.getParameter("search");
        String statusParam = request.getParameter("statusId");
        String reset = request.getParameter("reset");

        if ("true".equals(reset)) {
            search = null;
            statusParam = null;
        }

        Integer statusID = null;
        if (statusParam != null && !statusParam.trim().isEmpty()) {
            try {
                statusID = Integer.parseInt(statusParam.trim());
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Giá trị trạng thái không hợp lệ: " + statusParam);
            }
        }

        int pageSize = 5;
        int currentPage = 1;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            currentPage = Integer.parseInt(pageParam);
        }
        int offset = (currentPage - 1) * pageSize;

        UserDAO dao = new UserDAO();
        int totalRecords = dao.getTotalUserCount();
        int totalPages = (totalRecords + pageSize - 1) / pageSize;
        List<User> list;
        if (search != null && !search.trim().isEmpty() || statusID != null) {
            list = dao.searchCustomer(search, statusID);
        } else {
            list = dao.getListUserWithPaging(offset, pageSize);
        }
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("listU", list);
        request.getRequestDispatcher("/admin/UserList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
