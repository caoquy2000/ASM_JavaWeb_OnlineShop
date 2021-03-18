/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quych.models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import quych.db.DBUtils;
import quych.dtos.OrderDetailDTO;

/**
 *
 * @author caoho
 */
public class OrderDetailDAO {

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

    public int countOrderDetail() throws Exception {
        int count = 0;
        try {
            conn = DBUtils.getConnection();
            String sql = "select COUNT(orderDetailID) as CurrentOrderDetail from tblOrderDetails";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                count = Integer.parseInt(rs.getString("CurrentOrderDetail"));
            }
        } finally {
            closeConnection();
        }
        return count;
    }

    public boolean insertMultiRow(List<OrderDetailDTO> listDTO) throws Exception {
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            StringBuffer sql = new StringBuffer("Insert Into tblOrderDetails values(?,?,?,?,?,?)");
            for (int i = 0; i < listDTO.size() - 1;i++) {
                sql.append(",(?,?,?,?,?,?)");
            }
            System.out.println(sql.toString());
            stm = conn.prepareStatement(sql.toString());
            for (int i = 0; i < listDTO.size(); i++) {
                stm.setString(1 + i * 6, listDTO.get(i).getOrderDetailID());
                stm.setFloat(2 + i * 6, listDTO.get(i).getPrice());
                stm.setInt(3 + i * 6, listDTO.get(i).getQuantity());
                stm.setInt(4 + i * 6, listDTO.get(i).getStatus());
                stm.setString(5 + i * 6, listDTO.get(i).getOrderID());
                stm.setString(6 + i * 6, listDTO.get(i).getProductID());
                System.out.println(listDTO.get(i).getOrderID());
            }
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean changeStatus(String orderID) throws Exception {
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            String sql = "Update tblOrderDetails set [status] = 0 where orderID = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, orderID);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    public List<OrderDetailDTO> getListOrderDetailByOrderID(String id) throws Exception {
        List<OrderDetailDTO> result;
        try {
            conn = DBUtils.getConnection();
            String sql = "select o.orderDetailID, p.pName, p.pPrice, o.quantity, p.pUrl "
                    + "from tblOrderDetails o left join tblProducts p on o.productID = p.productID Where o.orderID = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                OrderDetailDTO dto = new OrderDetailDTO();
                dto.setOrderDetailID(rs.getString("orderDetailID"));
                dto.setpName(rs.getString("pName"));
                dto.setpPrice(rs.getFloat("pPrice"));
                dto.setQuantity(rs.getInt("quantity"));
                dto.setpUrl(rs.getString("pUrl"));
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}
