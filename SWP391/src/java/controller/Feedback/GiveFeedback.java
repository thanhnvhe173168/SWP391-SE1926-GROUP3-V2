package controller.Feedback;

import dao.FeedbackDAO;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import model.Feedback;

@WebServlet(name="GiveFeedback", urlPatterns={"/giveFeedback"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
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
            out.println("<h1>Servlet GiveFeedback at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        int userID = Integer.parseInt(request.getSession().getAttribute("userID").toString());
        int laptopID = Integer.parseInt(request.getParameter("laptopID"));
        int orderID = Integer.parseInt(request.getParameter("orderID"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int rating = Integer.parseInt(request.getParameter("rating"));
        int sellerRating = Integer.parseInt(request.getParameter("sellerRating"));
        int shippingRating = Integer.parseInt(request.getParameter("shippingRating"));
        int statusID = 28; // Mặc định trạng thái Feedback mới

        // Xử lý file upload
        Part filePart = request.getPart("productImage");
        String fileName = extractFileName(filePart);

        // Đường dẫn lưu file trên server (bạn đổi path phù hợp nhé)
        String uploadPath = "C:/MyUploads/Feedback";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Xử lý file trùng tên
        File file = new File(uploadDir, fileName);
        int count = 0;
        String baseName = fileName;
        while (file.exists()) {
            count++;
            fileName = count + "_" + baseName;
            file = new File(uploadDir, fileName);
        }

        filePart.write(file.getAbsolutePath());

        // Link để lưu DB
        String imageURL = "Feedback/" + fileName;

        // Tạo Feedback object
        Feedback fb = new Feedback();
        fb.setUserID(userID);
        fb.setLaptopID(laptopID);
        fb.setOrderID(orderID);
        fb.setTitle(title);
        fb.setContent(content);
        fb.setRating(rating);
        fb.setSellerRating(sellerRating);
        fb.setShippingRating(shippingRating);
        fb.setImageURL(imageURL);
        fb.setStatusID(statusID);

        // Ghi DB
        FeedbackDAO dao = new FeedbackDAO();
        boolean giveF = dao.addFeedback(fb);
        if (giveF) {
            request.setAttribute("mess", "Cảm ơn bạn đã gửi phản hồi!");
            request.getRequestDispatcher("user/feedbackSuccess.jsp").forward(request, response);
        } else {
            request.setAttribute("mess", "Có lỗi xảy ra! Vui lòng thử lại");
            request.getRequestDispatcher("user/GiveFeedback.jsp").forward(request, response);
        }
    }

    // Tách tên file từ part
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String cd : contentDisp.split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf("=") + 2, cd.length() - 1);
                return java.nio.file.Paths.get(fileName).getFileName().toString();
            }
        }
        return "";
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
