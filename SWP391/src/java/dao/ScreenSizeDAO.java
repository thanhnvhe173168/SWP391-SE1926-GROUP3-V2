/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import config.ConnectDB;
import model.ScreenSize;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Window 11
 */
public class ScreenSizeDAO extends ConnectDB {

    public List<ScreenSize> AllScreen() {
        List<ScreenSize> list = new ArrayList<>();
        String sql = "select * from ScreenSize";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ScreenSize screen = new ScreenSize();
                screen.setScreenID(rs.getInt("ScreenID"));
                screen.setSize(rs.getNString("Size"));
                list.add(screen);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public ScreenSize GetScreen(int screenid) {
        ScreenSize screen = new ScreenSize();
        String sql = "select * from ScreenSize where ScreenID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, screenid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {

                screen.setScreenID(rs.getInt("ScreenID"));
                screen.setSize(rs.getString("Size"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return screen;
    }
}
