/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.*;

/**
 *
 * @author Window 11
 */
public class FeeShipDAO extends ConnectDB {

    public List<FeeShip> GetFeeShip() {
        String sql = "select * from ShipFee";
        List<FeeShip> listfeeship = new ArrayList<>();
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                FeeShip fs = new FeeShip();
                fs.setFeeShipID(rs.getInt("ShipFeeID"));
                fs.setFee(rs.getBigDecimal("fee"));
                fs.setDes(rs.getString("Descriptions"));
                listfeeship.add(fs);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listfeeship;
    }
    
    public BigDecimal GetFeeById(int id){
        String sql="select * from ShipFee where ShipfeeID=?";
        BigDecimal fee=new BigDecimal(0);
        try{
            PreparedStatement st=connect.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs=st.executeQuery();
            fee = rs.getBigDecimal("fee");
        }
        catch(SQLException e){
            e.printStackTrace();
        }
        return fee;
    }
    public int GetIDbyWay(String way){
        String sql="select * from ShipFee where Descriptions=?";
        int ID=0;
        try{
        PreparedStatement st=connect.prepareStatement(sql);
        st.setNString(1, way);
        ResultSet rs=st.executeQuery();
        while(rs.next()){
            ID=rs.getInt("ShipFeeID");
        }
        }
        catch(SQLException e){
            e.printStackTrace();
        }
        return ID;
    }
}