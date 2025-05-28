/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.ConnectDB;
import model.CPU;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Window 11
 */
public class CPUDAO extends ConnectDB {

    public List<CPU> AllCPU() {
        List<CPU> list = new ArrayList();
        String sql = "select * from CPU";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CPU cpu = new CPU();
                cpu.setCpuID(rs.getInt("CPUID"));
                cpu.setCpuInfo(rs.getString("CPUInfo"));
                list.add(cpu);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public CPU GetCPU(int cpuid) {
        CPU cpu = new CPU();
        String sql = "select * from CPU where CPUID=?";
        try {
            PreparedStatement st = connect.prepareStatement(sql);
            st.setInt(1, cpuid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {

                cpu.setCpuID(cpuid);
                cpu.setCpuInfo(rs.getString("CPUInfo"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return cpu;
    }
}
