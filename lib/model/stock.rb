class Index < ActiveRecord::Base
 has_many :Stocks
end

class Stock < ActiveRecord::Base
 belongs_to :Index
 has_many :Chains
end