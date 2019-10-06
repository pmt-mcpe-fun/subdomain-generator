class Record < ApplicationRecord
	validates :name, :dns_type, :content, :cloudflare_id, presence: true
	validates :name, :cloudflare_id, uniqueness: true

  belongs_to :user

  attr_readonly :cloudflare_id
  enum dns_type: [ :a, :aaaa, :cname ]
end
