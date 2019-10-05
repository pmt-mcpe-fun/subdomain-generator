class Record < ApplicationRecord
  belongs_to :user
  attr_readonly :cloudflare_id
  enum dns_type: [ :a, :aaaa, :cname ]
end
