
package dal;

//import context.ConnectDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Comment;
import model.User;

public class CommentDAO extends ConnectDB{
    
    public ArrayList<Comment> getAllComment() {
        ArrayList<Comment> comments = new ArrayList<>();
        String sql = "select tblcomments.id as comment_id, tblusers.id as user_id, tblusers.fullname, tblcomments.content, tblcomments.rate "
                + "from dbo.comments tblcomments inner join dbo.users tblusers on  tblcomments.user_id = tblusers.id";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setFullname(rs.getString("fullname"));
                Comment comment = new Comment();
                comment.setId(rs.getInt("comment_id"));
                comment.setContent(rs.getString("content"));
                comment.setRate(rs.getInt("rate"));
                comment.setUser(user);
                comments.add(comment);
            }
        } catch (SQLException ex) {

        }
        return comments;
    }
    
    public ArrayList<Comment> getCommentByProduct_Id(int product_Id) {
        ArrayList<Comment> comments = new ArrayList<>();
        String sql = "select tblcomments.id as comment_id, tblusers.id as user_id, tblusers.fullname, tblcomments.content, tblcomments.rate "
                + "from dbo.comments tblcomments inner join dbo.users tblusers on  tblcomments.user_id = tblusers.id "
                + "and tblcomments.product_id = " + product_Id + ";";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setFullname(rs.getString("fullname"));
                Comment comment = new Comment();
                comment.setId(rs.getInt("comment_id"));
                comment.setContent(rs.getString("content"));
                comment.setRate(rs.getInt("rate"));
                comment.setUser(user);
                comments.add(comment);
            }
        } catch (SQLException ex) {

        }
        return comments;
    }
    
    public void insertComment(int user_id, int product_id, String content, int rate) {
    String sql = "INSERT INTO dbo.comments (user_id, product_id, content, rate) VALUES (?, ?, ?, ?);";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, user_id);
        ps.setInt(2, product_id);
        ps.setString(3, content);
        ps.setInt(4, rate);
        ps.execute();
    } catch (SQLException ex) {
       
    }
}

    
    public void deleteComment(int commentId) {
        try {
            String sql = "DELETE FROM dbo.comments WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, commentId);
            ps.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    
}
