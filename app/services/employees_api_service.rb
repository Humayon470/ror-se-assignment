require 'net/http'
require 'json'

class EmployeesApiService
  BASE_URL = 'https://dummy-employees-api-8bad748cda19.herokuapp.com/employees'.freeze

  def self.get_all(page = nil)
    uri = URI("#{BASE_URL}?page=#{page}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.get_employee(id)
    uri = URI("#{BASE_URL}/#{id}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.create_employee(params)
    uri = URI(BASE_URL)
    response = send_request(Net::HTTP::Post, uri, params)
    JSON.parse(response.body)
  end

  def self.update_employee(id, params)
    uri = URI("#{BASE_URL}/#{id}")
    response = send_request(Net::HTTP::Put, uri, params)
    JSON.parse(response.body)
  end

  private

  def self.send_request(request_class, uri, params)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    request = request_class.new(uri.path)
    request['Content-Type'] = 'application/json'
    request.body = params.to_json
    http.request(request)
  end
end
