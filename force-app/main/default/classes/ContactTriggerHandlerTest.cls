@isTest
public class ContactTriggerHandlerTest {
	@isTest
    public static void testContact(){
        Contact con = new Contact();
        con.LastName = 'test contact';
        insert con;
        
        con.MailingCity = 'Mumbai';
        update con;
        
        delete con;
    }
}