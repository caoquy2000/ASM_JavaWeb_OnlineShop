/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quych.dtos;

import java.io.Serializable;

/**
 *
 * @author caoho
 */
public class ProductDTO implements Serializable {
    private String productID;
    private String pName;
    private float pPrice;
    private int pQuantity;
    private String pDescription;
    private int status;
    private String pUrl;
    private String categoryID;
    private String categoryName;
    private int statusCate;

    public ProductDTO() {
    }

    public ProductDTO(String productID, String pName, float pPrice, int pQuantity, String pDescription, int status, String pUrl, String categoryID) {
        this.productID = productID;
        this.pName = pName;
        this.pPrice = pPrice;
        this.pQuantity = pQuantity;
        this.pDescription = pDescription;
        this.status = status;
        this.pUrl = pUrl;
        this.categoryID = categoryID;
    }

    public ProductDTO(String productID, String pName, float pPrice, int pQuantity, String pDescription, int status, String pUrl, String categoryID, String categoryName) {
        this.productID = productID;
        this.pName = pName;
        this.pPrice = pPrice;
        this.pQuantity = pQuantity;
        this.pDescription = pDescription;
        this.status = status;
        this.pUrl = pUrl;
        this.categoryID = categoryID;
        this.categoryName = categoryName;
    }

    public ProductDTO(String productID, String pName, float pPrice, int pQuantity, String pDescription, int status, String pUrl, String categoryID, int statusCate) {
        this.productID = productID;
        this.pName = pName;
        this.pPrice = pPrice;
        this.pQuantity = pQuantity;
        this.pDescription = pDescription;
        this.status = status;
        this.pUrl = pUrl;
        this.categoryID = categoryID;
        this.statusCate = statusCate;
    }
    
    
    

    public String getProductID() {
        return productID;
    }

    public String getpName() {
        return pName;
    }

    public float getpPrice() {
        return pPrice;
    }

    public int getpQuantity() {
        return pQuantity;
    }

    public String getpDescription() {
        return pDescription;
    }

    public int getStatus() {
        return status;
    }

    public String getpUrl() {
        return pUrl;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public int getStatusCate() {
        return statusCate;
    }
    
    public void setProductID(String productID) {
        this.productID = productID;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public void setpPrice(float pPrice) {
        this.pPrice = pPrice;
    }

    public void setpQuantity(int pQuantity) {
        this.pQuantity = pQuantity;
    }

    public void setpDescription(String pDescription) {
        this.pDescription = pDescription;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setpUrl(String pUrl) {
        this.pUrl = pUrl;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public void setStatusCate(int statusCate) {
        this.statusCate = statusCate;
    }
    
}
