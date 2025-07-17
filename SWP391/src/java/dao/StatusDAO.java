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

    public List<Status> getListStatusSelect() {
        List<Status> list = new ArrayList<>();
        String sql = "select * from Statuses\n"
                + "where StatusID=7\n"
                + "or StatusID=8\n"
                + "or StatusID=9\n"
                + "or StatusID=18\n"
                + "or StatusID=19\n"
                + "or StatusID=20\n"
                + "or StatusID=21\n"
                + "or StatusID=22";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Status status = new Status();
                status.setStatusID(rs.getInt("StatusID"));
                status.setStatusName(rs.getNString("statusName"));
                status.setStatusType(rs.getNString("statustype"));
                list.add(status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Status> getListPaymentStatusSelect() {
        List<Status> list = new ArrayList<>();
        String sql = "select * from Statuses\n"
                + "where StatusID=26\n"
                + "or StatusID=27\n"
                + "or StatusID=28";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Status status = new Status();
                status.setStatusID(rs.getInt("StatusID"));
                status.setStatusName(rs.getNString("statusName"));
                status.setStatusType(rs.getNString("statustype"));
                list.add(status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Status> getListStatusSelectWhenShip() {
        List<Status> list = new ArrayList<>();
        String sql = "select * from Statuses\n"
                + "where StatusID=10\n"
                + "or StatusID=11\n"
                + "or StatusID=12\n"
                + "or StatusID=13\n"
                + "or StatusID=14\n"
                + "or StatusID=15\n"
                + "or StatusID=23\n"
                + "or StatusID=24\n"
                + "or StatusID=25";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Status status = new Status();
                status.setStatusID(rs.getInt("StatusID"));
                status.setStatusName(rs.getNString("statusName"));
                status.setStatusType(rs.getNString("statustype"));
                list.add(status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
