package controller.Feedback;

import dao.FeedbackDAO;
import dao.OrderDetailDAO;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.File;
import model.Feedback;
import model.OrderDetail;
import model.User;

@WebServlet(name = "GiveFeedback", urlPatterns = {"/giveFeedback"})


public class GiveFeedback extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GiveFeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GiveFeedback at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleID() != 3 ) {
            request.getRequestDispatcher("/error/404err.jsp").forward(request, response);
        }
         String orderId = request.getParameter("orderID");
        String laptopId = request.getParameter("laptopID");
        System.out.println("orderId:" + orderId);
        System.out.println("laptopId:" + laptopId);
        request.setAttribute("orderId", orderId);
        request.setAttribute("laptopId", laptopId);
        request.getRequestDispatcher("user/GiveFeedback.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");

        int userID = user.getUserID();
        OrderDetailDAO oddao = new OrderDetailDAO();
        String orderIDRaw = request.getParameter("orderID");
        String laptopIDRaw = request.getParameter("laptopID");
        if (orderIDRaw == null || laptopIDRaw == null || orderIDRaw.isEmpty() || laptopIDRaw.isEmpty()) {
            request.setAttribute("mess", "Thiếu thông tin đánh giá.");
            request.getRequestDispatcher("user/GiveFeedback.jsp").forward(request, response);
            return;
        }

        int orderID = Integer.parseInt(orderIDRaw);
        int laptopID = Integer.parseInt(laptopIDRaw);

        String title = request.getParameter("title");
        String content = request.getParameter("content");

        int rating = Integer.parseInt(request.getParameter("productRating"));
        int sellerRating = Integer.parseInt(request.getParameter("sellerRating"));
        int shippingRating = Integer.parseInt(request.getParameter("shippingRating"));
        int statusID = 30;

        Feedback fb = new Feedback();
        fb.setUserID(userID);
        fb.setLaptopID(laptopID);
        fb.setOrderID(orderID);
        fb.setTitle(title);
        fb.setContent(content);
        fb.setRating(rating);
        fb.setSellerRating(sellerRating);
        fb.setShippingRating(shippingRating);
        fb.setStatusID(statusID);

        
        FeedbackDAO dao = new FeedbackDAO();

        if (dao.addFeedback(fb)) {
            OrderDetail od = oddao.getOrderDetailByLapID(laptopID, orderID);
            od.setFeedback(dao.getFeedbackByidAndLaptop(orderID, laptopID));
            oddao.updateFeedback(laptopID, orderID, od.getFeedback().getFeedbackID());
            session.setAttribute("mess", "Cảm ơn bạn đã gửi phản hồi!");
            response.sendRedirect("home");
        } else {
            request.setAttribute("mess", "Có lỗi xảy ra! Vui lòng thử lại");
            request.getRequestDispatcher("user/GiveFeedback.jsp").forward(request, response);
        }
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
