/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quych.dtos;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author caoho
 */
public class OrderDTO implements Serializable , Comparable<OrderDTO> {
    private String orderID;
    private String fullName;
    private String address;
    private String phone;
    private String email;
    private float total;
    private Timestamp timeOfCreate;
    private int status;
    private String username;
    private Date dayOrder;
    private int amountOrder;

    public OrderDTO() {
    }

    public OrderDTO(String orderID, String fullName, String address, String phone, String email, float total, Timestamp timeOfCreate, int status, String username) {
        this.orderID = orderID;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.total = total;
        this.timeOfCreate = timeOfCreate;
        this.status = status;
        this.username = username;
    }

    public OrderDTO(Date dayOrder, int amountOrder) {
        this.dayOrder = dayOrder;
        this.amountOrder = amountOrder;
    }
    
    

  

    public String getOrderID() {
        return orderID;
    }

    public String getFullName() {
        return fullName;
    }

    public String getAddress() {
        return address;
    }

    public String getPhone() {
        return phone;
    }

    public String getEmail() {
        return email;
    }

    public float getTotal() {
        return total;
    }

    public Timestamp getTimeOfCreate() {
        return timeOfCreate;
    }

    public String getUsername() {
        return username;
    }

    public int getStatus() {
        return status;
    }

    public int getAmountOrder() {
        return amountOrder;
    }

    public Date getDayOrder() {
        return dayOrder;
    }
    

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    

    public void setTimeOfCreate(Timestamp timeOfCreate) {
        this.timeOfCreate = timeOfCreate;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setAmountOrder(int amountOrder) {
        this.amountOrder = amountOrder;
    }

    public void setDayOrder(Date dayOrder) {
        this.dayOrder = dayOrder;
    }
    
    
    @Override
    public int compareTo(OrderDTO o) {
        return this.getTimeOfCreate().compareTo(o.getTimeOfCreate());
    }
    
    
}
