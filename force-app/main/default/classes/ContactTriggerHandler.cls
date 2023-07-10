public class ContactTriggerHandler  {
    public static void onBeforeInsert(List<Contact> triggerNew) {
        /*call before insert actions*/      
        restrictContactCreate(triggerNew);
    }
    
    public static void onBeforeUpdate(Map<Id, Contact> newMap, Map<Id, Contact> oldMap) {
        /*call before update actions*/
    }
    
    public static void onBeforeDelete(Map<Id, Contact> oldMap) {
        /*call before delete actions*/
    }
    
    public static void onAfterInsert(Map<Id, Contact> newMap){
        /*call after Insert actions*/        
    }    
    
    public static void onAfterUpdate(Map<Id, Contact> newMap, Map<Id, Contact> oldMap){      
        /*call after update actions*/
        List<Contact> al = new List<Contact>();
        for(String id: newMap.keySet())
        {
            Contact cnew = newMap.get(id);
            Contact cold = oldMap.get(id);
            
            if(cnew.MailingCity != cold.MailingCity)
            {
                al.add(cnew);
            }
            
        }
        changeCityOfAccount(al);
    }
    
    public static void onAfterDelete(Map<Id, Contact> oldMap) {
        /*call after delete actions*/
    }
    
    public static void onAfterUnDelete(Map<Id, Contact> newMap) {
        /*call after undelete actions*/
    }
    public static void changeCityOfAccount(List<Contact> al){
        List<Account> updateAccList = new List<Account>();
        for(Contact eac:al){
            Account tmp = new Account();
            tmp.id = eac.AccountId;
            tmp.BillingCity = eac.MailingCity;
            updateAccList.add(tmp);
            System.debug('tmp'+tmp);
        }
        System.debug('updateAccList'+ updateAccList );
        update updateAccList;
    }
    
    public static void restrictContactCreate(List<Contact> triggerNew){
        List<Contact> restrictedContactList = new List<Contact>();
        for(Contact c : triggerNew){
            if(c.LastName == 'honeysingh'){
                c.addError('Conatct cannot be created');
            }
            
            
        }
        
        
    }
}