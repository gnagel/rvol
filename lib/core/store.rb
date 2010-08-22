require "pstore"
#
# Store objects on disk
#
class Store
  
  @@kdb = PStore.new("rfinance.pstore")
  
  
  def Store.saveObject(key,obj)
    
    
    @@kdb.transaction do
    
    @@kdb[key] = obj
    @@kdb.commit
    end
    
  end
  
  def Store.listContents
  
    @@kdb.transaction do
    @@kdb.roots
    end
  
  end
  
  def Store.get(key)
   
    @@kdb.transaction do
    value = @@kdb[key]
   
    end
   
  end
    
end