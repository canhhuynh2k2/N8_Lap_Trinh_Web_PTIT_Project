/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Huynh
 */
public class Order {
    private int id;
    private User user;
    private String fullname;
    private String phone_number;
    private String email;
    private String address;
    private String note;
    private int status;
    private Date order_date;
    private int total_money;
    private List<OrderDetail> orderItems;
    public Order(int id, User user, String fullname, String phone_number, String email, String address, String note, int status, int total_money) {
        this.id = id;
        this.user = user;
        this.fullname = fullname;
        this.phone_number = phone_number;
        this.email = email;
        this.address = address;
        this.note = note;
        this.status = status;
        this.total_money = total_money;
        orderItems = new ArrayList<>();
    }

    public Order() {
        
    }
    
    public int getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public String getFullname() {
        return fullname;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public String getEmail() {
        return email;
    }

    public String getAddress() {
        return address;
    }

    public String getNote() {
        return note;
    }

    public int getStatus() {
        return status;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public int getTotal_money() {
        return total_money;
    }
    
    public List<OrderDetail> getOrderItems() {
        return orderItems;
    }
    
    public void addOrderItem(OrderDetail item){
        orderItems.add(item);
    }
    
    public void setId(int id){
        this.id = id;
    }
    public void setUser(User user) {
        this.user = user;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public void setFullname(String fullname) {
        this.fullname = fullname;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public void setTotal_money(int total_money) {
        this.total_money = total_money;
    }

    public void setOrderItems(List<OrderDetail> orderItems) {
        this.orderItems = orderItems;
    }
    
    
}
