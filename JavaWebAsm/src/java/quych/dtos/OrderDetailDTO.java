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
public class OrderDetailDTO implements Serializable {
    private String orderDetailID;
    private float price;
    private int quantity;
    private int status;
    private String orderID;
    private String productID;
    private String pName;
    private float pPrice;
    private String pUrl;


    public OrderDetailDTO() {
    }

    public OrderDetailDTO(String orderDetailID, float price, int quantity, int status, String orderID, String productID) {
        this.orderDetailID = orderDetailID;
        this.price = price;
        this.quantity = quantity;
        this.status = status;
        this.orderID = orderID;
        this.productID = productID;
    }

    public String getpUrl() {
        return pUrl;
    }
    
    public String getpName() {
        return pName;
    }

    public float getpPrice() {
        return pPrice;
    }
    
    public String getOrderDetailID() {
        return orderDetailID;
    }

    public float getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getStatus() {
        return status;
    }

    public String getOrderID() {
        return orderID;
    }

    public String getProductID() {
        return productID;
    }

    public void setOrderDetailID(String orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
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

    public void setpUrl(String pUrl) {
        this.pUrl = pUrl;
    }
    
    
}
