# encoding: utf-8
require 'dm-core'
require 'dm-validations'
#
#
#
class Stockcorrelation
    include DataMapper::Resource
    property :id,                          Serial    # An auto-increment integer key
    property :created_at,                  DateTime, :required => true  # A DateTime, for any date you might like.
    property :symbol,                      String,  :required => true
    property :symbol2,                     String,  :required => true
    property :correlation,                 Float,  :required => true
end