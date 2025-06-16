package controller.UserController;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "ViewerUser", urlPatterns = {"/viewerUser"})
public class ViewerUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy ID từ request
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            request.setAttribute("error", "Thiếu tham số ID người dùng");
            request.getRequestDispatcher("/admin/ViewUserDetail.jsp").forward(request, response);
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            UserDAO dao = new UserDAO();
            User user = dao.getUserByIDForView(userId);

            if (user == null) {
                request.setAttribute("error", "Không tìm thấy người dùng");
            } else {
                request.setAttribute("user", user);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID người dùng không hợp lệ");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

        request.getRequestDispatcher("/admin/ViewUserDetail.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Xem chi tiết người dùng";
    }
}
