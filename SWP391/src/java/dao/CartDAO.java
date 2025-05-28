/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author Window 11
 */
import config.ConnectDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Cart;
import model.CartDetail;

public class CartDAO extends ConnectDB {

    public Cart GetCart(int CartID) {
        Cart cart = new Cart();
        String sql = "select * from Cart where CartID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, CartID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                cart.setCartID(CartID);
                cart.setUserID(rs.getInt("UserID"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return cart;
    }

    LaptopDAO laptopdao = new LaptopDAO();
    CartDAO cartdao = new CartDAO();

    public List<CartDetail> ListCart(int CartID) {
        List<CartDetail> list = new ArrayList<>();
        String sql = "select * from CartDetail where CartID= ?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, CartID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CartDetail cd = new CartDetail();
                cd.setCart(cartdao.GetCart(CartID));
                cd.setLaptop(laptopdao.GetLaptop(rs.getInt("LaptopID")));
                cd.setQuantity(rs.getInt("Quantity"));
                cd.setUnitPrice(rs.getBigDecimal("UnitPrice"));
                list.add(cd);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public void AddCart(CartDetail cartdetail) {
        String sql = "INSERT INTO CartDetail (CartID, LaptopID, Quantity, UnitPrice)\n"
                + "VALUES \n"
                + "(?, ?, ?, ?),";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, cartdetail.getCart().getCartID());
            st.setInt(2, cartdetail.getLaptop().getLaptopID());
            st.setInt(3, cartdetail.getQuantity());
            st.setBigDecimal(4, cartdetail.getUnitPrice());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void Remove(CartDetail cartdetail) {
        String sql = "DELETE FROM CartDetail WHERE CartID = ? AND LaptopID = ?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, cartdetail.getCart().getCartID());
            st.setInt(2, cartdetail.getLaptop().getLaptopID());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void updateQuantity(int cartID, int laptopID, int newQuantity) {
        String sql = "UPDATE CartDetail SET Quantity = ? WHERE CartID = ? AND LaptopID = ?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, newQuantity);
            st.setInt(2, cartID);
            st.setInt(3, laptopID);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
