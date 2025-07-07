<%-- 
    Document   : shipperOrderList
    Created on : Jul 3, 2025, 11:29:25 PM
    Author     : Window 11
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<head>
    <style>
        .wrapper {
            display: flex;
        }

        .page-container {
            margin-left: 220px; /* khớp với sidebar width */
            padding: 30px;
            min-height: 100vh;
            background-color: #f4f6f9;
            width: calc(100% - 220px);

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 6px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                font-family: Arial, sans-serif;
                font-size: 15px;
            }

            th, td {
                padding: 12px 16px;
                text-align: left;
            }

            th {
                background-color: #f8f9fa;
                color: #333;
                border-bottom: 2px solid #dee2e6;
                font-weight: bold;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #e9ecef;
            }

            button {
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 6px 12px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }

            button:hover {
                background-color: #0056b3;
            }

            .pagination {
                display: inline-block;
                margin-top: 20px;
            }

            .pagination a,
            .pagination span {
                color: #007bff;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
                border: 1px solid #007bff;
                margin: 0 4px;
                border-radius: 4px;
                transition: background-color 0.3s, color 0.3s;
            }

            .pagination a:hover {
                background-color: #007bff;
                color: white;
            }

            .pagination span {
                background-color: #007bff;
                color: white;
                cursor: default;
            }

        }
    </style>

</head>
<body>
    <div class="wrapper">
        <jsp:include page="/components/ShipperSidebar.jsp"></jsp:include>
            <div class="page-container">
            <c:set var="orderlists" value="${shipperorderlist}"/>
            <c:choose>
                <c:when test="${empty orderlists}">
                    <P>Không có đơn hàng nào</P>
                    </c:when>
                    <c:otherwise>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Ngày đặt hàng</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái đơn hàng</th>
                            <th>Trạng thái thanh toán</th>
                            <th>Xem đơn</th>
                        </tr>
                        <c:forEach items="${orderlists}" var="order" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${order.orderDate}</td>
                                <td><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> VNĐ</td>
                                <td>${order.orderstatus.statusName}</td>
                                <td>${order.paymentstatus.statusName}</td>
                                <td><button onclick="window.location.href = 'OrderDetailScreen?id=${order.orderID}'">Xem đơn</button></td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>
            <!-- Phân trang -->
            <div class="pagination" style="text-align: center;">
                <c:if test="${totalPages > 1}">
                    <c:if test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}">Previous</a>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span>${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?page=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}">Next</a>
                    </c:if>
                </c:if>
            </div> 
        </div>
    </div>
</body> 