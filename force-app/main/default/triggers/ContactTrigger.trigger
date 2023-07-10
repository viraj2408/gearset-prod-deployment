trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if (trigger.isBefore){
        if(trigger.isInsert){
            ContactTriggersHandler.onBeforeInsert(trigger.new);   
        }else if(trigger.isUpdate){
            
            ContactTriggersHandler.onBeforeUpdate(trigger.newMap, trigger.oldMap);
            
        }else if(trigger.isDelete){
            ContactTriggersHandler.onBeforeDelete(trigger.oldMap);
        }
    }else if(trigger.isAfter){
        if(trigger.isInsert){
            ContactTriggersHandler.onAfterInsert(trigger.newMap);
        }else if(trigger.isUpdate){
            ContactTriggersHandler.onAfterUpdate(trigger.newMap, trigger.oldMap);
        }else if(trigger.isDelete){
           ContactTriggersHandler.onAfterDelete(trigger.Oldmap); 
        }else if(trigger.isUndelete){
            ContactTriggersHandler.onAfterUnDelete(trigger.newMap);
        }
    }
}