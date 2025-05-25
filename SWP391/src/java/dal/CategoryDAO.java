/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import model.Category;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Window 11
 */
public class CategoryDAO extends DBContext{
    public List<Category> AllCategory(){
        List<Category> list=new ArrayList();
        String sql= "select * from category";
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs=st.executeQuery();
            while(rs.next()){
                Category ca=new Category();
                ca.setCategoryID(rs.getInt("CategoryID"));
                ca.setCategoryName(rs.getString("CategoryName"));
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
        return list;
    }
    
     public Category GetCategory(int cid){
        Category ca=new Category();
        String sql= "select * from category where categoryid=?";
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cid);
            ResultSet rs=st.executeQuery();
            while(rs.next()){
                
                ca.setCategoryID(rs.getInt("CategoryID"));
                ca.setCategoryName(rs.getString("CategoryName"));
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
        return ca;
    }
}
