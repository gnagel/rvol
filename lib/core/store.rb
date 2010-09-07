require "pstore"
#
# Store objects on disk
#
class Store
  

  
  def Store.saveObject(key,obj)
    kdb = PStore.new("rfinance.pstore")
    
    kdb.transaction do
      kdb[key] = obj
      kdb.commit
    end
    
  end
  
  def Store.listContents
    kdb = PStore.new("rfinance.pstore")
    kdb.transaction do
    kdb.roots
    end
  
  end
  
  def Store.get(key)
    kdb = PStore.new("rfinance.pstore")
    kdb.transaction do
    @value = kdb[key]
    end
    @value
  end
    
end