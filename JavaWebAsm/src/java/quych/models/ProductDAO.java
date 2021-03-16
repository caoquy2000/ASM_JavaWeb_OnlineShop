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
import quych.dtos.ProductDTO;

/**
 *
 * @author caoho
 */
public class ProductDAO implements Serializable {

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

    public List<ProductDTO> getListProduct() throws Exception {
        List<ProductDTO> result;
        try {
            conn = DBUtils.getConnection();
            String sql = "Select productID, pName, pPrice, pQuantity, pDescription, status, pUrl, categoryID From tblProducts";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                String productID = rs.getString("productID");
                String pName = rs.getString("pName");
                float pPrice = rs.getFloat("pPrice");
                int pQuantity = rs.getInt("pQuantity");
                String pDescription = rs.getString("pDescription");
                int status = rs.getInt("status");
                String pUrl = rs.getString("pUrl");
                String categoryID = rs.getString("categoryID");
                ProductDTO dto = new ProductDTO(productID, pName, pPrice, pQuantity, pDescription, status, pUrl, categoryID);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<ProductDTO> getListProductAndCategoryName() throws Exception {
        List<ProductDTO> result;
        try {
            conn = DBUtils.getConnection();
            String sql = "Select productID, pName, pPrice, pQuantity, pDescription, p.status, pUrl , p.categoryID, categoryName "
                    + "from tblProducts as p left join tblCategorys as c on p.categoryID = c.categoryID ";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                String productID = rs.getString("productID");
                String pName = rs.getString("pName");
                float pPrice = rs.getFloat("pPrice");
                int pQuantity = rs.getInt("pQuantity");
                String pDescription = rs.getString("pDescription");
                int status = rs.getInt("status");
                String pUrl = rs.getString("pUrl");
                String categoryID = rs.getString("categoryID");
                String categoryName = rs.getString("categoryName");
                ProductDTO dto = new ProductDTO(productID, pName, pPrice, pQuantity, pDescription, status, pUrl, categoryID, categoryName);
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
            String sql = "Update tblProducts Set status = ? where productID = ?";
            stm = conn.prepareStatement(sql);
            stm.setInt(1, status);
            stm.setString(2, id);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean insertProduct(ProductDTO dto) throws Exception {
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            String sql = "Insert into tblProducts values (?,?,?,?,?,?,?,?)";
            stm = conn.prepareStatement(sql);

            stm.setString(1, dto.getProductID());
            stm.setString(2, dto.getpName());
            stm.setFloat(3, dto.getpPrice());
            stm.setInt(4, dto.getpQuantity());
            stm.setString(5, dto.getpDescription());
            stm.setInt(6, dto.getStatus());
            stm.setString(7, dto.getpUrl());
            stm.setString(8, dto.getCategoryID());

            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public ProductDTO getProductById(String id) throws Exception {
        ProductDTO dto;
        try {
            conn = DBUtils.getConnection();
            String sql = "Select pName, pPrice, pQuantity, pDescription, status, pUrl, categoryID From tblProducts Where productID = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, id);
            dto = new ProductDTO();
            
            rs = stm.executeQuery();
            if (rs.next()) {
                dto.setProductID(id);
                dto.setpName(rs.getString("pName"));
                dto.setpPrice(rs.getFloat("pPrice"));
                dto.setpQuantity(rs.getInt("pQuantity"));
                dto.setpDescription(rs.getString("pDescription"));
                dto.setStatus(rs.getInt("status"));
                dto.setpUrl(rs.getString("pUrl"));
                dto.setCategoryID(rs.getString("categoryID"));
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public boolean updateProduct(ProductDTO dto) throws Exception {
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            String sql = "Update tblProducts Set pName = ?, pPrice = ?, pQuantity = ?, pDescription = ?, status = ?, pUrl = ?, categoryID = ? "
                    + "Where productID = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, dto.getpName());
            stm.setFloat(2, dto.getpPrice());
            stm.setInt(3, dto.getpQuantity());
            stm.setString(4, dto.getpDescription());
            stm.setInt(5, dto.getStatus());
            stm.setString(6, dto.getpUrl());
            stm.setString(7, dto.getCategoryID());
            stm.setString(8, dto.getProductID());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public String getImgProductByID(String id) throws Exception {
        String result = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "Select pUrl From tblProducts Where productID = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getString("pUrl");
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public List<ProductDTO> searchByLikeName(String name) throws Exception {
        List<ProductDTO> result;
        try {
            conn = DBUtils.getConnection();
            String sql = "Select productID, pName, pPrice, pQuantity, pDescription, p.status, pUrl , p.categoryID, categoryName "
                    + "from tblProducts as p left join tblCategorys as c on p.categoryID = c.categoryID Where pName LIKE ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + name + "%");
            rs = stm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                String productID = rs.getString("productID");
                String pName = rs.getString("pName");
                float pPrice = rs.getFloat("pPrice");
                int pQuantity = rs.getInt("pQuantity");
                String pDescription = rs.getString("pDescription");
                int status = rs.getInt("status");
                String pUrl = rs.getString("pUrl");
                String categoryID = rs.getString("categoryID");
                String categoryName = rs.getString("categoryName");
                ProductDTO dto = new ProductDTO(productID, pName, pPrice, pQuantity, pDescription, status, pUrl, categoryID,categoryName);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public boolean checkQuantity(String id, int quantity) throws Exception {
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            String sql = "Select pQuantity from tblProducts where productID = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();
            int currentQuantityOfProduct = 0;
            if (rs.next()) {
                currentQuantityOfProduct = Integer.parseInt(rs.getString("pQuantity"));
            }
            if (quantity < currentQuantityOfProduct) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }
}
