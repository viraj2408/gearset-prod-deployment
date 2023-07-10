public class ContactTriggersHandler {
    public static void onBeforeInsert(List<Contact> triggerNew) {
        /*call before insert actions*/
        RestrictInsert(triggerNew);
    }
    
    public static void onBeforeUpdate(Map<Id, Contact> newMap, Map<Id, Contact> oldMap) {
        /*call before update actions*/
        
    }
    
    public static void onBeforeDelete(Map<Id, Contact> oldMap) {
        /*call before delete actions*/
    }
    
    public static void onAfterInsert(Map<Id, Contact> newMap){
        /*call after Insert actions*/  
        addressChangeForAccount(newMap);
    }    
    
    public static void onAfterUpdate(Map<Id, Contact> newMap, Map<Id, Contact> oldMap){      
        /*call after update actions*/
        
    addressChangeForAccount1(newMap,oldMap);
        changeOppAddress(newMap,oldMap);
        
    }
    
    public static void onAfterDelete(Map<Id, Contact> oldMap) {
        /*call after delete actions*/
    }
    
    public static void onAfterUnDelete(Map<Id, Contact> newMap) {
        /*call after undelete actions*/
    } 

    public static void RestrictInsert(List<Contact> triggerNew)  {
        for(Contact con : triggerNew){
            if(con.LastName == 'HoneySingh')
            {
                con.addError('You cannot create this Contact' );
            }
        }
    }  
    
    public static void addressChangeForAccount(Map<Id, Contact> newMap){
        Set<Id> accountSetIds = new Set<Id>();
        for(Contact con : newMap.values()){
            if(con.MailingCountry != null){
                accountSetIds.add(con.AccountId);
            } 
        }
        
        Map<Id,Account> accountList = new Map<Id,Account>([Select id from Account WHERE ID IN : accountSetIds]);
        for(Contact con : newMap.values()){
            if(accountList.containsKey(con.AccountId)){
                Account acc = accountList.get(con.AccountId);
                acc.BillingCountry = con.MailingCountry;
                
            }
        }
        update accountList.values();
    }
    
   public static void addressChangeForAccount1(Map<Id, Contact> newMap, Map<Id, Contact> oldMap){
        
    Set<Id> accountSetIds = new Set<Id>();
        for(Contact con : newMap.values()){
            if(con.MailingCountry != oldMap.get(con.id).MailingCountry){
                accountSetIds.add(con.AccountId);
            } 
        }
        
        Map<Id,Account> accountList = new Map<Id,Account>([Select id from Account WHERE ID IN : accountSetIds]);
        for(Contact con : newMap.values()){
            if(accountList.containsKey(con.AccountId)){
                Account acc = accountList.get(con.AccountId);
                acc.BillingCountry = con.MailingCountry;
            }
        }
        update accountList.values();
    }
    
    
        
       // Map<Id,Account> accountMap = new Map<Id,Account>([Select Id from Account WHERE ID IN : accountList]);
        
        
        
       // for(Opportunity oppty : opp.values()){
          //  Contact con = contactList.get(Id);
          //  oppty.Billing_City__c = con.MailingStreet;
            
      //  }
    
    
    public static void changeOppAddress(Map<Id,Contact> newMap, Map<Id,Contact> oldMap)
    {
        Map<Id,Contact> accountContactMap = new Map<Id,Contact>();
        for(Contact c: newMap.values())
        {
            
            Contact acct = oldMap.get(c.id);
            
             if(c.MailingCity != acct.MailingCity || c.MailingCountry != acct.MailingCountry || c.MailingPostalCode != acct.MailingPostalCode || c.MailingState != acct.MailingState || c.MailingStreet != acct.MailingStreet)
             {
                 accountContactMap.put(c.AccountId,c);
                 
             }
            
        }
        if(accountContactMap.isEmpty() == False)
        {
            List<Opportunity> oppList = [Select id,AccountId from opportunity where AccountId in:accountContactMap.KeySet()];
            
            
            for(Opportunity o:oppList){
                Contact c = accountContactMap.get(o.AccountId);
                
                o.Billing_City__c = c.MailingCity;
                
            }
        
            
            
            if(oppList.size()>0)
            {
                update oppList;
            }
            
        }
    }
}