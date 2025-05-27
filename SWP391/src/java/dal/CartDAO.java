/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Window 11
 */
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Cart;
public class CartDAO extends DBContext{
    public Cart GetCart(int CartID){
        Cart cart=new Cart();
        String sql="select * from Cart where CartID=?";
        try{
            PreparedStatement st=connection.prepareStatement(sql);
            st.setInt(1, CartID);
            ResultSet rs=st.executeQuery();
            while(rs.next()){
                cart.setCartID(CartID);
                cart.setUserID(rs.getInt("UserID"));
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
        return cart;
    }
}
