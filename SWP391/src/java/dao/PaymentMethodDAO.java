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
            e.printStackTrace();
        }
        return list;
    }
    
    public int GetPaymentIDbyMethod(String meth){
        int id=1;
        String sql="select * from paymentmethod where methodname=?";
                try{
                    PreparedStatement st=connect.prepareStatement(sql);
                    st.setNString(1, meth);
                    ResultSet rs=st.executeQuery();
                    while(rs.next()){
                    id=rs.getInt("Paymentmethodid");
                    }
                }
                catch(SQLException e){
                    e.printStackTrace();
                }
                return id;
    }
    
    public PaymentMethod GetPaymentMethodByID(int id){
        PaymentMethod pm =new PaymentMethod();
        String sql="select * from paymentmethod where PaymentMethodID=?";
                try{
                    PreparedStatement st=connect.prepareStatement(sql);
                    st.setInt(1, id);
                    ResultSet rs=st.executeQuery();
                    while(rs.next()){
                    pm.setMethodName(rs.getNString("methodname"));
                    pm.setPaymentMethodID(id);
                    }
                }
                catch(SQLException e){
                    e.printStackTrace();
                }
                return pm;
    }
}

