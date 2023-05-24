/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author chaum
 */
public class Product {
    private int id;
    private Category category;
    private String name;
    private String description;
    private String thumbnail;
    private String unit;
    private String branch;
    private int capacity;
    private Double alcohol;
    private int quantity;
    private int price;
    private int price_sale;

    public Product(){
        
    }
    
    public Product(int id, Category category, String name, String description, String thumbnail, String unit, String branch, int capacity, Double alcohol, int quantity, int price, int price_sale) {
        this.id = id;
        this.category = category;
        this.name = name;
        this.description = description;
        this.thumbnail = thumbnail;
        this.unit = unit;
        this.branch = branch;
        this.capacity = capacity;
        this.alcohol = alcohol;
        this.quantity = quantity;
        this.price = price;
        this.price_sale = price_sale;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public Double getAlcohol() {
        return alcohol;
    }

    public void setAlcohol(Double alcohol) {
        this.alcohol = alcohol;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getPrice_sale() {
        return price_sale;
    }

    public void setPrice_sale(int price_sale) {
        this.price_sale = price_sale;
    }

   

}