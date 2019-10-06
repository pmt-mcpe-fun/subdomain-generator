module RecordsHelper
	def record_info_link(record)
		if record.dns_type.downcase == 'aaaa'
			return 'https://www.cloudflare.com/learning/dns/dns-records/dns-a-record/'
		else
			return "https://www.cloudflare.com/learning/dns/dns-records/dns-#{record.dns_type.downcase}-record/"
		end
	end
end
