class Employee < ApplicationRecord

  require 'roo'

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
    #CSV.generate do |csv|
      csv << column_names
      all.each do |employee|
        csv << employee.attributes.values_at(*column_names)
      end
    end
  end


  def self.accessible_attributes 
    ['name', 'surname', 'payroll', 'role']  #, 'telephone'
  end

#searchable do
#  text :name
#  text :surname, :boost => 5
#  text :payroll  
#end

  enum status: {Booked: 0, Clocked_In:1, DNA:2 }

  before_create :set_create_attributes
  def set_create_attributes
    self.status ||= 0
  end


  after_save :delete_duplicates
  def delete_duplicates
    employees = Employee.all.group_by{|employee| [employee.name, employee.surname, employee.payroll, employee.role]} #, employee.telephone
    employees.values.each do |duplicates|  
    #the first one we want to keep right?
       first_one = duplicates.shift # or pop for last one
       # if there are any more left, they are duplicates
       # so delete all of them
      duplicates.each{|double| double.destroy}
    end 
  end

  def self.import(file)
   spreadsheet = open_spreadsheet(file)
   header = spreadsheet.row(1)
   (2..spreadsheet.last_row).each do |i|
     row = Hash[[header, spreadsheet.row(i)].transpose]
     employee = find_by_id(row["id"]) || new
     employee.attributes = row.to_hash.slice(*accessible_attributes)
     # strip any leading and trailing whitespace from the inputs
     # also add the to_s method in case there is any  nil variable or any other type different form string
     employee.name = employee.name.titleize.to_s.strip
     employee.surname = employee.surname.titleize.to_s.strip
     employee.role = employee.role.upcase.to_s.strip 
     employee.payroll = employee.payroll.to_s.upcase.strip
     employee.telephone = employee.telephone.to_s.strip
     employee.save!
   end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end


end
