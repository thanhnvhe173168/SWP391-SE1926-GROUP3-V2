/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package dao;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import model.FeeShip;
import model.Order;
import model.PaymentMethod;
import model.Status;
import model.Voucher;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Window 11
 */
public class OrderDAOTest {

    public OrderDAOTest() {
    }

    @BeforeClass
    public static void setUpClass() {
    }

    @AfterClass
    public static void tearDownClass() {
    }

    @Before
    public void setUp() {
    }

    @After
    public void tearDown() {
    }

    /**
     * Test of uppdateorder method, of class OrderDAO.
     */
    @Test
    public void testUppdateorder() {
        System.out.println("uppdateorder");

        Order od = new Order();
        od.setUserID(1); // giả sử userID = 1 có tồn tại
        od.setOrderDate(LocalDate.now());
        od.setShipfee(new FeeShip(2, BigDecimal.valueOf(20000), "Giao hàng tận nơi"));
        od.setTotalAmount(new BigDecimal("10000000"));
        od.setAddress("123 Đường ABC, Hà Nội");
        od.setNote("Giao trong giờ hành chính");
        od.setPhoneNumber("0909999999");
        od.setOrderstatus(new Status(6, "Orders", "Đang giao"));
        od.setVoucher(null); // hoặc set null nếu cần
        od.setPaymentmethod(new PaymentMethod(1, "VN PAY"));
        od.setPaymentdate(null);
        od.setPaymentstatus(new Status(15, "Payment", "Chưa thanh toán"));
        od.setReturnDate(null);
        od.setReasonReturn(null);

        OrderDAO instance = new OrderDAO();
        try {
            instance.uppdateorder(od);
            assertTrue(true); // Nếu không exception thì coi là pass
        } catch (Exception e) {
            fail("Insert failed: " + e.getMessage());
        }
    }

    /**
     * Test of GetLastOrderID method, of class OrderDAO.
     */
    @Test
    public void testGetLastOrderID() {
        System.out.println("GetLastOrderID");
        int userID = 1; // đảm bảo user ID 1 tồn tại trong DB
        OrderDAO dao = new OrderDAO();
        int lastOrderID = dao.GetLastOrderID(userID);
        assertTrue(lastOrderID > 0); // Kiểm tra là có ít nhất một đơn hàng
        System.out.println("Last Order ID for user 1 = " + lastOrderID);
    }

    /**
     * Test of GetOrderByID method, of class OrderDAO.
     */
    @Test
    public void testGetOrderByID() {
        System.out.println("GetOrderByID");
        int id = 4;
        OrderDAO instance = new OrderDAO();
        Order result = instance.GetOrderByID(id);
        assertNotNull(result);
        assertEquals(id, result.getOrderID());
        System.out.println("Address: " + result.getAddress());
        System.out.println("Total: " + result.getTotalAmount());
    }

    /**
     * Test of getListOrder method, of class OrderDAO.
     */
    @Test
    public void testGetListOrder() {
        System.out.println("getListOrder");
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListOrder();
        assertNotNull(result);         // Không được null
        assertTrue(result.size() > 0); // Danh sách phải có ít nhất 1 đơn
    }

    /**
     * Test of getListOrderByPaymentStatusName method, of class OrderDAO.
     */
    @Test
    public void testGetListOrderByPaymentStatusName() {
        System.out.println("getListOrderByPaymentStatusName");
        String statusname = "Đã thanh toán"; // Trạng thái có thật trong DB
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListOrderByPaymentStatusName(statusname);
        assertNotNull(result);
        assertTrue(result.size() > 0); // Có đơn hàng với trạng thái này
        for (Order od : result) {
            assertEquals(statusname, od.getPaymentstatus().getStatusName());
        }
    }

    @Test
    public void testGetListOrderByPaymentStatusName_invalid() {
        System.out.println("getListOrderByPaymentStatusName - invalid");

        String statusname = "Không tồn tại"; // giả định trạng thái không có thật
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListOrderByPaymentStatusName(statusname);

        assertNotNull(result);             // Phải trả về danh sách (dù rỗng)
        assertEquals(0, result.size());    // Không có đơn hàng nào khớp
    }

    /**
     * Test of getListOrderByStatusName method, of class OrderDAO.
     */
    @Test
    public void testGetListOrderByStatusName_valid() {
        System.out.println("getListOrderByStatusName - valid");

        String statusname = "Đã giao"; // Đảm bảo tồn tại trong bảng Statuses
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListOrderByStatusName(statusname);

        assertNotNull(result);             // Danh sách không được null
        assertTrue(result.size() > 0);     // Có đơn hàng thật

        for (Order od : result) {
            assertEquals(statusname, od.getOrderstatus().getStatusName());
        }
    }

    @Test
    public void testGetListOrderByStatusName_invalid() {
        System.out.println("getListOrderByStatusName - invalid");

        String statusname = "abcxyz"; // Không tồn tại
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListOrderByStatusName(statusname);

        assertNotNull(result);         // Không được null
        assertEquals(0, result.size()); // Danh sách rỗng
    }

    /**
     * Test of getListReturnOrderByStatusName method, of class OrderDAO.
     */
    @Test
    public void testGetListReturnOrderByStatusName_valid() {
        System.out.println("getListReturnOrderByStatusName - valid");
        String statusname1 = "Yêu cầu hoàn đơn";
        String statusname2 = "Đã hoàn";
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListReturnOrderByStatusName(statusname1, statusname2);
        assertNotNull(result);
        assertTrue(result.size() > 0);
        for (Order od : result) {
            String status = od.getOrderstatus().getStatusName();
            assertTrue(status.equals(statusname1) || status.equals(statusname2));
        }
    }

    @Test
    public void testGetListReturnOrderByStatusName_invalid() {
        System.out.println("getListReturnOrderByStatusName - invalid");

        String statusname1 = "Trạng thái không tồn tại";
        String statusname2 = "Lỗi gì đó";

        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListReturnOrderByStatusName(statusname1, statusname2);

        assertNotNull(result);
        assertEquals(0, result.size());
    }

    /**
     * Test of getListOrderNeedEvaluate method, of class OrderDAO.
     */
    @Test
    public void testGetListOrderNeedEvaluate_valid() {
        System.out.println("getListOrderNeedEvaluate");
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListOrderNeedEvaluate();
        assertNotNull(result); // Danh sách không null
        if (!result.isEmpty()) {
            for (Order od : result) {
                // Kiểm tra có các thông tin cần thiết
                assertNotNull(od.getOrderID());
                assertNotNull(od.getOrderDate());
                System.out.println("Order cần đánh giá: ID = " + od.getOrderID());
            }
        } else {
            System.out.println("Không có đơn hàng cần đánh giá.");
        }
    }

    /**
     * Test of getListUserOrder method, of class OrderDAO.
     */
    @Test
    public void testGetListUserOrder_valid() {
        System.out.println("getListUserOrder");
        int userid = 1; // Đảm bảo userID này tồn tại trong DB và có đơn hàng
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListUserOrder(userid);
        assertNotNull(result);
        assertTrue(result.size() > 0); // Có đơn hàng
        for (Order od : result) {
            assertEquals(userid, od.getUserID());
            System.out.println("Đơn hàng #" + od.getOrderID() + " của user " + userid);
        }
    }

    @Test
    public void testGetListUserOrder_invalid() {
        System.out.println("getListUserOrder - invalid user");
        int userid = 9999; // User không có đơn
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListUserOrder(userid);
        assertNotNull(result);
        assertEquals(0, result.size());
    }

    /**
     * Test of getListUserOrderByPaymentStatusName method, of class OrderDAO.
     */
    @Test
    public void testGetListUserOrderByPaymentStatusName_valid() {
        System.out.println("getListUserOrderByPaymentStatusName - valid");
        String statusname = "Đã thanh toán";
        int userid = 1; // user có thật và đã có đơn hàng trong DB
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListUserOrderByPaymentStatusName(statusname, userid);
        assertNotNull(result);
        assertTrue(result.size() > 0);
        for (Order od : result) {
            assertEquals(userid, od.getUserID());
            assertEquals(statusname, od.getPaymentstatus().getStatusName());
        }
    }

    @Test
    public void testGetListUserOrderByPaymentStatusName_invalid() {//th không có kết quả
        System.out.println("getListUserOrderByPaymentStatusName - invalid");

        String statusname = "Trạng thái không tồn tại";
        int userid = 9999; // không tồn tại

        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListUserOrderByPaymentStatusName(statusname, userid);

        assertNotNull(result);
        assertEquals(0, result.size());
    }

    /**
     * Test of getListUserOrderByStatusName method, of class OrderDAO.
     */
    @Test
    public void testGetListUserOrderByStatusName_valid() {
        System.out.println("getListUserOrderByStatusName - valid");
        String statusname = "Đang giao";
        int userid = 1;
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListUserOrderByStatusName(statusname, userid);
        assertNotNull(result);
        assertTrue(result.size() > 0);
        for (Order od : result) {
            assertEquals(userid, od.getUserID());
            assertEquals(statusname, od.getOrderstatus().getStatusName());
        }
    }

    @Test
    public void testGetListUserOrderByStatusName_invalid() {// kh có kq
        System.out.println("getListUserOrderByStatusName - invalid");
        String statusname = "Trạng thái không tồn tại";
        int userid = 9999; // giả định không có user này
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListUserOrderByStatusName(statusname, userid);
        assertNotNull(result);
        assertEquals(0, result.size());
    }

    /**
     * Test of getListUserReturnOrderByStatusName method, of class OrderDAO.
     */
    @Test
    public void testGetListUserReturnOrderByStatusName_valid() {
        System.out.println("getListUserReturnOrderByStatusName - valid");

        String statusname1 = "Yêu cầu hoàn đơn";
        String statusname2 = "Đã hoàn";
        int userid = 1;
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListUserReturnOrderByStatusName(statusname1, statusname2, userid);
        assertNotNull(result);
        assertTrue(result.size() > 0);
        for (Order od : result) {
            String status = od.getOrderstatus().getStatusName();
            assertTrue(status.equals(statusname1) || status.equals(statusname2));
            assertEquals(userid, od.getUserID());
        }
    }

    @Test
    public void testGetListUserReturnOrderByStatusName_invalid() {
        System.out.println("getListUserReturnOrderByStatusName - invalid");
        String statusname1 = "Trạng thái không tồn tại";
        String statusname2 = "Sai tên nữa";
        int userid = 9999;
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListUserReturnOrderByStatusName(statusname1, statusname2, userid);
        assertNotNull(result);
        assertEquals(0, result.size());
    }

    /**
     * Test of getListUserOrderNeedEvaluate method, of class OrderDAO.
     */
    @Test
    public void testGetListUserOrderNeedEvaluate_valid() {
        System.out.println("getListUserOrderNeedEvaluate - valid");
        int userid = 1;
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListUserOrderNeedEvaluate(userid);
        assertNotNull(result);
        if (result.size() > 0) {
            for (Order od : result) {
                assertEquals(userid, od.getUserID());
                System.out.println("Order cần đánh giá: #" + od.getOrderID());
            }
        } else {
            System.out.println("Không có đơn hàng cần đánh giá với userID = " + userid);
        }
    }

    @Test
    public void testGetListUserOrderNeedEvaluate_invalid() {
        System.out.println("getListUserOrderNeedEvaluate - invalid");

        int userid = 9999; // user không tồn tại
        OrderDAO instance = new OrderDAO();
        List<Order> result = instance.getListUserOrderNeedEvaluate(userid);

        assertNotNull(result);
        assertEquals(0, result.size());
    }

    /**
     * Test of upDateOrderStatus method, of class OrderDAO.
     */
    @Test
    public void testUpDateOrderStatus_valid() {
        System.out.println("upDateOrderStatus - valid");
        int statusid = 7; // "Đã giao"
        int orderid = 5;  // Đơn hàng có thật
        OrderDAO dao = new OrderDAO();
        dao.upDateOrderStatus(statusid, orderid); // Cập nhật
        // Kiểm tra lại trạng thái sau khi cập nhật
        Order updatedOrder = dao.GetOrderByID(orderid);
        assertNotNull(updatedOrder);
        assertEquals(statusid, updatedOrder.getOrderstatus().getStatusID());
        System.out.println("Cập nhật trạng thái đơn hàng #" + orderid + " thành công.");
    }

    /**
     * Test of updateReasonReturn method, of class OrderDAO.
     */
    @Test
    public void testUpdateReasonReturn_valid() {
        System.out.println("updateReasonReturn - valid");
        int orderid = 6; // đơn hàng có thật
        String reason = "Máy bị lỗi màn hình";
        LocalDate returndate = LocalDate.now();
        OrderDAO instance = new OrderDAO();
        instance.updateReasonReturn(orderid, reason, returndate); // thực hiện cập nhật
        // Kiểm tra lại xem có cập nhật thành công không
        Order updated = instance.GetOrderByID(orderid);
        assertNotNull(updated);
        assertEquals(reason, updated.getReasonReturn());
        assertEquals(returndate, updated.getReturnDate());
        System.out.println("Lý do trả hàng: " + updated.getReasonReturn());
    }

}
