/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import config.ConnectDB;
import model.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Window 11
 */
public class PaymentMethodDAO extends ConnectDB{
    public List<PaymentMethod> listpaymentmethod(){
        List<PaymentMethod> list =new ArrayList<>();
        String sql="select * from PaymentMethod";
        try{
            PreparedStatement st=connect.prepareStatement(sql);
            ResultSet rs=st.executeQuery();
            while(rs.next()){
                PaymentMethod pm=new PaymentMethod();
                pm.setMethodName(rs.getString("methodname"));
                pm.setPaymentMethodID(rs.getInt("paymentmethodid"));
                list.add(pm);
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
        return list;
    }
}
