class Record < ApplicationRecord
  belongs_to :user

  enum type: [ :a, :aaaa, :cname ]
end
