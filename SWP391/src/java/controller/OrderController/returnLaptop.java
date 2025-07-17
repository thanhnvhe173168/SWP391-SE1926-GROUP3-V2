package controller.OrderController;

import dao.OrderDAO;
import dao.OrderDetailDAO;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Order;

import model.OrderDetail;

@WebServlet(name = "returnLaptop", urlPatterns = {"/returnLaptop"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class returnLaptop extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        LocalDate returnDate = LocalDate.now();
        String orderIDStr = request.getParameter("orderID");
        String[] laptopIDs = request.getParameterValues("laptopIDs");
        int count = 0;
        OrderDetailDAO oddao = new OrderDetailDAO();
        OrderDAO odao = new OrderDAO();
        if (laptopIDs != null && orderIDStr != null) {
            int orderID = Integer.parseInt(orderIDStr);

            for (String lapidStr : laptopIDs) {
                int laptopID = Integer.parseInt(lapidStr);

                count += 1;
                // Lấy reason
                String reason = request.getParameter("reason_" + laptopID);

                // Upload image(s)
                String imagePath = null;

                for (Part part : request.getParts()) {
                    if (part.getName().equals("image_" + laptopID) && part.getSize() > 0) {
                        String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;

                        String uploadDir = "D:/ImageUploads/";
                        File uploadFolder = new File(uploadDir);
                        if (!uploadFolder.exists()) {
                            uploadFolder.mkdirs();
                        }

                        part.write(uploadDir + File.separator + uniqueFileName);
                        imagePath = "uploads/" + uniqueFileName;
                    }
                }

                // Cập nhật status cho OrderDetail
                oddao.upDateOrderDetailStatuswhenreturn(16, orderID, laptopID);
                oddao.updateReasonReturn(orderID, laptopID, reason, returnDate);
                oddao.updateImageReturn(orderID, laptopID, imagePath);
            }
            int quantity = 0;
            List<OrderDetail> list = oddao.GetListOrderDetailByID(orderID);
            for (OrderDetail orderdetail : list) {
                quantity += 1;
            }
            if (quantity == count) {
                odao.upDateOrderStatus(16, orderID);
            }
            else{
                odao.upDateOrderStatus(17, orderID);
            }
        }
        request.setAttribute("mess", "Gửi yêu cầu hoàn sản phẩm thành công!");
        request.getRequestDispatcher("OrderList").forward(request, response);
    }
}
