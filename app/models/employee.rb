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
    ['name', 'surname', 'payroll', 'role', 'telephone']
  end

  enum status: {Booked: 0, Clocked_In:1, DNA:2 }

  before_create :set_create_attributes
  def set_create_attributes
    self.status ||= 0
  end

  after_save :delete_duplicates
  def delete_duplicates
    employees = Employee.all.group_by{|employee| [employee.name, employee.surname, employee.payroll, employee.role, employee.telephone]}
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
     employee.name = employee.name.upcase.to_s.strip
     employee.surname = employee.surname.upcase.to_s.strip
     employee.role = employee.role.upcase.to_s.strip 
     employee.payroll = employee.payroll.upcase.to_s.strip
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

##################################################################################################

# Methods for deleting DUPLICATES


 # def delete_duplicates
 #   # find all models and group them on keys which should be common
 #   grouped = all.group_by{|employee| [model.name,model.year,model.trim,model.make_id] }
 #   grouped.values.each do |duplicates|
 #     # the first one we want to keep right?
 #     first_one = duplicates.shift # or pop for last one
 #     # if there are any more left, they are duplicates
 #     # so delete all of them
 #     duplicates.each{|double| double.destroy} # duplicates can now be destroyed
 #   end
 # end



# Works well but it is missing many other validations such taking into account other fields
#def delete_duplicates
#  employees = Employee.group(:name).having('count("name") > 1').count(:name)
#  employees.each do |key, value|  
#    duplicates = Employee.where(name: key)[1..value-1]
#    puts "#{key} = #{duplicates.count}"
#     duplicates.each(&:destroy)
#  end 
#end

##############################################################################################


#class Employee < ApplicationRecord
#require 'roo'
##attr_accessor 
#def attr_accessor
#  ['name', 'surname', 'role', 'payrole', 'telephone']
#end
#
# def self.import(file)
#  #accessible_attribut = ['name', 'surname', 'role', 'payrole', 'telephone']
#   spreadsheet = open_spreadsheet(file)
#   header = spreadsheet.row(1)
#   (1..spreadsheet.last_row).each do |i|
#     row = Hash[[header, spreadsheet.row(i)].transpose]
#     employee = find_by_id(row["id"]) || new
#     employee.attributes = row.to_hash.slice(attr_accessor)
#     employee.save!
#   end
# end
#
#def self.open_spreadsheet(file)
#  case File.extname(file.original_filename)
#  when ".csv" then Roo::Csv.new(file.path)
#  when ".xls" then Roo::Excel.new(file.path)
#  when ".xlsx" then Roo::Excelx.new(file.path)
#  else raise "Unknown file type: #{file.original_filename}"
#  end
#end
#
#
## def self.open_spreadsheet(file)
##   case File.extname(file.original_filename)
##       when ".csv" then Csv.new(file.path, nil, :ignore)
##       when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
##       when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
##       else raise "Tipo de arquivo desconhecido: #{file.original_filename}"
##   end
##nd
#
#
#end
#
#