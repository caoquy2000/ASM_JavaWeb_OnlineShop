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
import java.util.ArrayList;
import java.util.List;
import quych.db.DBUtils;
import quych.dtos.CategoryDTO;

/**
 *
 * @author caoho
 */
public class CategoryDAO  {

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

    public List<CategoryDTO> getListCategory() throws Exception {
        List<CategoryDTO> result;
        try {
            conn = DBUtils.getConnection();
            String sql = "Select categoryID, categoryName, cUrl, status From tblCategorys";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                String categoryID = rs.getString("categoryID");
                String categoryName = rs.getString("categoryName");
                String cUrl = rs.getString("cUrl");
                int status = rs.getInt("status");
                CategoryDTO dto = new CategoryDTO(categoryID, categoryName, cUrl, status);
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
            String sql = "Update tblCategorys Set status = ? where categoryID = ?";
            stm = conn.prepareStatement(sql);
            stm.setInt(1, status);
            stm.setString(2, id);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean insertCategory(CategoryDTO dto) throws Exception {
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            String sql = "Insert Into tblCategorys values (?,?,?,?)";
            stm = conn.prepareStatement(sql);
            stm.setString(1, dto.getCategoryID());
            stm.setString(2, dto.getCategoryName());
            stm.setString(3, dto.getcUrl());
            stm.setInt(4, dto.getStatus());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public CategoryDTO getCategoryById(String id) throws Exception {
        CategoryDTO dto;
        try {
            conn = DBUtils.getConnection();
            String sql = "Select categoryID, categoryName, cUrl, status From tblCategorys "
                    + "Where categoryID = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, id);
            dto = new CategoryDTO();
            rs = stm.executeQuery();
            if (rs.next()) {
                dto.setCategoryID(rs.getString("categoryID"));
                dto.setCategoryName(rs.getString("categoryName"));
                dto.setcUrl(rs.getString("cUrl"));
                dto.setStatus(rs.getInt("status"));
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public boolean updateCategory(CategoryDTO dto) throws Exception {
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            String sql = "Update tblCategorys Set categoryName = ?, cUrl = ?, status = ? "
                    + "Where categoryID = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, dto.getCategoryName());
            stm.setString(2, dto.getcUrl());
            stm.setInt(3, dto.getStatus());
            stm.setString(4, dto.getCategoryID());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    public String getImgByID(String id) throws Exception {
        String result = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "Select cUrl From tblCategorys Where categoryID = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getString("cUrl");
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public List<CategoryDTO> searchByLikeName(String name) throws Exception {
        List<CategoryDTO> result;
        try {
            conn = DBUtils.getConnection();
            String sql = "Select categoryID, categoryName, cUrl, status From tblCategorys "
                    + "Where categoryName LIKE ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + name + "%");
            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                String categoryID = rs.getString("categoryID");
                String categoryName = rs.getString("categoryName");
                String cUrl = rs.getString("cUrl");
                int status = rs.getInt("status");
                CategoryDTO dto = new CategoryDTO(categoryID, categoryName, cUrl, status);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}
