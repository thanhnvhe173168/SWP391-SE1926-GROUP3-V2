package dao;

/**
 *
 * @author Window 11
 */
import config.ConnectDB;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Cart;

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
                cart.setTotal(rs.getBigDecimal("total"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return cart;
    }

    public void uppdateTotal(int CartID, BigDecimal total) {
        String sql = "UPDATE Cart SET total = ? WHERE CartID = ?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setBigDecimal(1, total);
            st.setInt(2, CartID);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public Cart GetCartByUserID(int UserID) {
        Cart cart = new Cart();
        String sql = "select * from Cart where UserID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, UserID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                cart.setCartID(rs.getInt("CartID"));
                cart.setUserID(UserID);
                cart.setTotal(rs.getBigDecimal("total"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return cart;
    }

    public void CreateCart(int userID) {
        String sql = "INSERT INTO Cart (UserID)\n"
                + "VALUES \n"
                + "(?)";
        try{
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, userID);
            st.executeUpdate();
        }
        catch(SQLException e){
            e.printStackTrace();
        }
    }
}
