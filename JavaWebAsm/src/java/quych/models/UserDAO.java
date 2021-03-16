/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quych.models;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import quych.db.DBUtils;
import quych.dtos.UserDTO;

/**
 *
 * @author caoho
 */
public class UserDAO implements Serializable {
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
    public UserDTO getAnUser(String username, String password) throws Exception {
        UserDTO dto = new UserDTO();
        try {
            conn = DBUtils.getConnection();
            String sql = "Select username, password, fullName, roleID from tblUsers Where username = ? And password = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            rs = stm.executeQuery();
            if (rs.next()) {
                String userName = rs.getString("username");
                String pass = rs.getString("password");
                String fullname = rs.getString("fullName");
                String roleID = rs.getString("roleID");
                dto.setUsername(userName);
                dto.setPassword(pass);
               dto.setFullname(fullname);
                dto.setRoleID(roleID);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    public String getRoleName(String roleID) throws Exception {
        String result = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "Select roleName from tblRoles where roleID = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, roleID);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getString("roleName");
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    public boolean createNewUser(UserDTO dto) throws Exception {
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            String sql = "Insert Into tblUsers values (?,?,?,?)";
            stm = conn.prepareStatement(sql);
            stm.setString(1, dto.getUsername());
            stm.setString(2, dto.getPassword());
            stm.setString(3, dto.getFullname());
            stm.setString(4, dto.getRoleID());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
}
