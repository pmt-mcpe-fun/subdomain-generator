require 'httparty'
require 'json'

class RecordsController < ApplicationController
	before_action :authenticate_user!

  def index
  	@records = Record.all
  end

	def show
    @record = Record.find(params[:id])
  end

	def new
	end

	def create
		dns_record = create_dns_record(record_params['name'], record_params['dns_type'].upcase, record_params['content'])

		if dns_record['success'] != true
			flash.now.alert = dns_record['errors'][0]['message']
			render :new
		else
			@record = Record.new(record_params.merge(user_id: current_user.id, cloudflare_id: dns_record['result']['id']))
			@record.save
			redirect_to @record	
		end
	end

	def destroy
		@record = Record.find(params[:id])

		if @record.user_id == current_user.id || current_user.admin?
			status_code = delete_dns_record(@record.cloudflare_id)
		
			if status_code != 200
				flash.now.alert = 'DNS record does not exist'
				redirect_to @record
			else
				@record.destroy
				redirect_to records_path
			end
		else
			flash.now.alert = 'You don\'t have permission to delete this record'
			redirect_to @record
		end
	end

  private
	  def record_params
	    params.require(:record).permit(:name, :dns_type, :content)
	  end

	  def create_dns_record(name, dns_type, content)
	  	response = HTTParty.post("https://api.cloudflare.com/client/v4/zones/#{ENV['CLOUDFLARE_ZONE_ID']}/dns_records",
	  		:body => {
	  			:type => dns_type,
	  			:name => name,
	  			:content => content
	  		}.to_json,
	  		:headers => { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{ENV['CLOUDFLARE_API_TOKEN']}" })

	  	JSON.parse(response.body)
	  end

	  def delete_dns_record(cloudflare_id)
	  	response = HTTParty.delete("https://api.cloudflare.com/client/v4/zones/#{ENV['CLOUDFLARE_ZONE_ID']}/dns_records/#{cloudflare_id}",
	  		:headers => { 'Authorization' => "Bearer #{ENV['CLOUDFLARE_API_TOKEN']}" })

	  	response.code
		end
end
