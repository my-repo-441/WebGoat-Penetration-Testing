import org.owasp.validator.html.*;  
import MyCommentDAO;  
  
public class AntiSamyController {  
     public void saveNewComment(int threadID, int userID, String newComment){  
         Policy p = Policy.getInstance("antisamy-slashdot.xml");  
         AntiSamy as = new AntiSamy();  
         CleanResults cr = as.scan(newComment, p, AntiSamy.DOM);  
         MyCommentDAO.addComment(threadID, userID, cr.getCleanHTML());  
     }  
}  
