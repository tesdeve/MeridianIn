class Employee < ApplicationRecord
require 'roo'


  def self.accessible_attributes 
    ['name', 'surname', 'role', 'payrole', 'telephone']
  end

   def self.import(file)
     spreadsheet = open_spreadsheet(file)
     header = spreadsheet.row(1)
     (2..spreadsheet.last_row).each do |i|
       row = Hash[[header, spreadsheet.row(i)].transpose]
       employee = find_by_id(row["id"]) || new
       employee.attributes = row.to_hash.slice(*accessible_attributes)
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