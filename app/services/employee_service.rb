# EmployeeService
require 'net/http'
require 'json'

class EmployeeService
  BASE_URL = 'https://dummy-employees-api-8bad748cda19.herokuapp.com/employees'

  def self.get_employees(page: nil)
    url = BASE_URL + (page ? "?page=#{page}" : "")
    begin
      response = Net::HTTP.get(URI(url))
      JSON.parse(response)
    rescue StandardError => e
      Rails.logger.error("Error fetching employees: #{e.message}")
      nil
    end
  end

  def self.get_employee(id)
    url = "#{BASE_URL}/#{id}"
    begin
      response = Net::HTTP.get(URI(url))
      JSON.parse(response)
    rescue StandardError => e
      Rails.logger.error("Error fetching employee with ID #{id}: #{e.message}")
      nil
    end
  end

  def self.create_employee(employee_params)
    uri = URI(BASE_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    request = Net::HTTP::Post.new(uri.path)
    request['Content-Type'] = 'application/json'
    request.body = employee_params.to_json

    begin
      response = http.request(request)
      JSON.parse(response.body)
    rescue StandardError => e
      Rails.logger.error("Error creating employee: #{e.message}")
      nil
    end
  end

  def self.update_employee(id, employee_params)
    uri = URI("#{BASE_URL}/#{id}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    request = Net::HTTP::Put.new(uri.path)
    request['Content-Type'] = 'application/json'
    request.body = employee_params.to_json

    begin
      response = http.request(request)
      JSON.parse(response.body)
    rescue StandardError => e
      Rails.logger.error("Error updating employee with ID #{id}: #{e.message}")
      nil
    end
  end
end
