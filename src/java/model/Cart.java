/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.ProductDAO;
import java.sql.SQLException;
import java.util.*;

/**
 *
 * @author Bach
 */
public class Cart {

    private List<Item> items;

    public Cart() {
        items = new ArrayList<>();
    }
    
    public Cart(String cookieTxt){
        items = new ArrayList<>();
        try {
            if(cookieTxt != null && cookieTxt.length() > 0){
                String cookies[] = cookieTxt.split("#");
                for(String cookie : cookies){
                    String[] tuple = cookie.split("&");
                    int productId = Integer.parseInt(tuple[0]);
                    int itemQuantity = Integer.parseInt(tuple[1]);
                    Product product = new ProductDAO().getByID(productId);
                    Item item = new Item(product, product.getPrice_sale(), itemQuantity);
                    addItem(item);
                }
            }
        } catch (NumberFormatException | SQLException e) {
        }
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }

    public Item getItemByProductId(int productId) {
        for (Item temp : items) {
            if (temp.getProduct().getId() == productId) {
                return temp;
            }
        }
        return null;
    }

    public int getItemQuantityByProductId(int productId) {
        return getItemByProductId(productId).getQuantity();
    }

    public void addItem(Item item) {
        if (getItemByProductId(item.getProduct().getId()) != null) {
            Item existedItem = getItemByProductId(item.getProduct().getId());
            existedItem.setQuantity(item.getQuantity() + existedItem.getQuantity());
        } else {
            items.add(item);
        }
    }

    public void removeItem(int productId) {
        if (getItemByProductId(productId) != null) {
            items.remove(getItemByProductId(productId));
        }
    }
    
    public int getTotalItems(){
        int totalItems = 0;
        for(Item item : items){
            totalItems += item.getQuantity();
        }
        return totalItems;
    }
    
    public int getTotalMoney(){
        int totalMoney = 0;
        for(Item item : items){
            totalMoney += item.getQuantity()*item.getPrice();
        }
        return totalMoney;
    }
    
    public String getCookieTxt(){
        String cookieTxt = "";
        if (!items.isEmpty()) {
            cookieTxt = items.get(0).getProduct().getId() + "&" + items.get(0).getQuantity();
            for (int i = 1; i < items.size(); i++) {
                cookieTxt += "#" + items.get(i).getProduct().getId() + "&" + items.get(i).getQuantity();
            }
        }
        return cookieTxt;
    }

}
