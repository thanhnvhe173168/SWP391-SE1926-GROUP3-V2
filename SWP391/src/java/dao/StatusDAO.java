/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import model.Status;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Brand;

/**
 *
 * @author Window 11
 */
public class StatusDAO extends ConnectDB {

    public Status GetStatus(int statusid) {
        Status status = new Status();
        String sql = "select * from Statuses where StatusID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, statusid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {

                status.setStatusID(statusid);
                status.setStatusName(rs.getNString("StatusName"));
                status.setStatusType(rs.getNString("StatusType"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return status;
    }
}
