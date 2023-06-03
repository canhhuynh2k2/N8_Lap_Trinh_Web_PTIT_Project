
package model;

public class Comment {
    private int id, product_id;
    private User user;
    private String content;
    private int rate;

    public Comment(int id, int product_id, User user, String content, int rate) {
        this.id = id;
        this.product_id = product_id;
        this.user = user;
        this.content = content;
        this.rate = rate;
    }

    public Comment() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    @Override
    public String toString() {
        return "Comment{" + "id=" + id + ", product_id=" + product_id + ", user=" + user + ", content=" + content + ", rate=" + rate + '}';
    }

    
}
