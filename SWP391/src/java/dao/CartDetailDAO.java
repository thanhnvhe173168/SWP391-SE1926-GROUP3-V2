/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import model.CartDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Window 11
 */
public class CartDetailDAO extends ConnectDB {

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
                cd.setLaptop(laptopdao.getLaptopById(rs.getInt("LaptopID")));
                cd.setQuantity(rs.getInt("Quantity"));
                cd.setUnitPrice(rs.getBigDecimal("UnitPrice"));
                cd.setIsSelect(rs.getBoolean("is_selected"));
                list.add(cd);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public CartDetail GetCartDetail(int id){
        String sql="select * from CartDetail where laptopID=?";
        CartDetail cd =new CartDetail();
        try{
            PreparedStatement st=connect.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs=st.executeQuery();
            while(rs.next()){
                cd.setCart(cartdao.GetCart(rs.getInt("cartID")));
                cd.setIsSelect(rs.getBoolean("is_selected"));
                cd.setLaptop(laptopdao.getLaptopById(id));
                cd.setQuantity(rs.getInt("quantity"));
                cd.setUnitPrice(rs.getBigDecimal("unitprice"));
            }
        }
        catch(SQLException e){
            System.out.println(e.getMessage());
        }
        return cd;
    }
    
    public void AddCart(CartDetail cartdetail) {
        String sql = "INSERT INTO CartDetail (CartID, LaptopID, Quantity, UnitPrice, is_selected)\n"
                + "VALUES \n"
                + "(?, ?, ?, ?, ?)";
        try{
            PreparedStatement st=connect.prepareStatement(sql);
            st.setInt(1, cartdetail.getCart().getCartID());
            st.setInt(2, cartdetail.getLaptop().getLaptopID());
            st.setInt(3, cartdetail.getQuantity());
            st.setBigDecimal(4, cartdetail.getUnitPrice());
            st.setBoolean(5, cartdetail.isIsSelect());
            st.executeUpdate();
    }catch(SQLException e){
            System.out.println(e.getMessage());
    }
}
    
    public void Remove(CartDetail cartdetail){
        String sql="DELETE FROM CartDetail WHERE CartID = ? AND LaptopID = ?";
        try{
            PreparedStatement st=connect.prepareStatement(sql);
            st.setInt(1, cartdetail.getCart().getCartID());
            st.setInt(2, cartdetail.getLaptop().getLaptopID());
            st.executeUpdate();
        }
        catch(SQLException e){
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

    public void updateBoolean(int cartID, int laptopID, boolean is_select) {
    String sql = "UPDATE CartDetail SET is_selected = ? WHERE CartID = ? AND LaptopID = ?";
    try {
        PreparedStatement st = connect.prepareStatement(sql);
        st.setBoolean(1, is_select);
        st.setInt(2, cartID);
        st.setInt(3, laptopID);
        st.executeUpdate();
    } catch (SQLException e) {
        System.out.println(e.getMessage());
    }
}
}
