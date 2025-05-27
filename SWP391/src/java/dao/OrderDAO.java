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
public class OrderDAO extends ConnectDB{
    public List<OrderDetail> orderlist(){ 
        List<OrderDetail> list=new ArrayList<>();
    return list;
}
    
}
