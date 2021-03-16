/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quych.models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import quych.db.DBUtils;
import quych.dtos.OrderDTO;

/**
 *
 * @author caoho
 */
public class OrderDAO {

    private Connection conn;
    private PreparedStatement stm;
    private ResultSet rs;

    public void closeConnection() throws Exception {
        if (rs != null) {
            rs.close();
        }
        if (stm != null) {
            stm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }

    public int countOrder() throws Exception {
        int count = 0;
        try {
            conn = DBUtils.getConnection();
            String sql = "select COUNT(orderID) as CurrentOrder from tblOrders";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                count = Integer.parseInt(rs.getString("CurrentOrder"));
            }
        } finally {
            closeConnection();
        }
        return count;
    }

    public boolean insertOrder(OrderDTO dto) throws Exception {
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            String sql = "Insert Into tblOrders values(?,?,?,?,?,?,?,?,?)";
            stm = conn.prepareStatement(sql);
            stm.setString(1, dto.getOrderID());
            stm.setString(2, dto.getFullName());
            stm.setString(3, dto.getAddress());
            stm.setString(4, dto.getPhone());
            stm.setString(5, dto.getEmail());
            stm.setFloat(6, dto.getTotal());
            stm.setTimestamp(7, dto.getTimeOfCreate());
            stm.setInt(8, dto.getStatus());
            stm.setString(9, dto.getUsername());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public List<OrderDTO> getListOrderById(String id) throws Exception {
        List<OrderDTO> result;
        try {
            conn = DBUtils.getConnection();
            String sql = "Select orderID ,fullName,address ,phone ,email ,total ,timeOfCreate ,status ,username From tblOrders Where username = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, id);
            result = new ArrayList();
            rs = stm.executeQuery();
            while (rs.next()) {
                String orderId = rs.getString("orderID");
                String fullName = rs.getString("fullName");
                String address = rs.getString("address");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                float total = Float.parseFloat(rs.getString("total"));
                Timestamp timeOfCreate = rs.getTimestamp("timeOfCreate");
                int status = rs.getInt("status");
                String username = rs.getString("username");
                OrderDTO dto = new OrderDTO(orderId, fullName, address, phone, email, total, timeOfCreate, status, username);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<OrderDTO> getListOrder() throws Exception {
        List<OrderDTO> result;
        try {
            conn = DBUtils.getConnection();
            String sql = "Select orderID ,fullName,address ,phone ,email ,total ,timeOfCreate ,status ,username From tblOrders";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                String orderId = rs.getString("orderID");
                String fullName = rs.getString("fullName");
                String address = rs.getString("address");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                float total = Float.parseFloat(rs.getString("total"));
                Timestamp timeOfCreate = rs.getTimestamp("timeOfCreate");
                int status = rs.getInt("status");
                String username = rs.getString("username");
                OrderDTO dto = new OrderDTO(orderId, fullName, address, phone, email, total, timeOfCreate, status, username);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean changStatus(int status, String id) throws Exception {
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            String sql = "Update tblOrders Set status = ? where orderID = ?";
            stm = conn.prepareStatement(sql);
            stm.setInt(1, status);
            stm.setString(2, id);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
}
