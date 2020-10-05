class TotalCheckedInPdf < Prawn::Document

  def initialize(employees)
    super(top_margin: 110, left_margin: 90)
    @employees = employees
    fire_register_title
    date
    move_down 20
    line_items
  end


def fire_register_title
  draw_text " FIRE REGISTER", style: :bold, size: 20, at:[110, 700]
  draw_text " (Meridian - Hello Fresh)", style: :bold, size: 14, at:[110, 680]
  #  move_down 30 will not work because it uses at (X,Y])

end

def date
  #move_down 30
  draw_text "Date: #{ @employees.present? ? @employees.first.created_at.strftime('%d-%b-%y') : "" }", 
  style: :bold, at:[140, 640]
end


def line_items
    move_down 20
    table line_item_rows do 
      row(0).font_style = :bold
      self.header = true
    end
end

def line_item_rows
 [["Name", "Surname", "Job Role", "Time In"]] +
  @employees.map do |employee|
    [employee.name.to_s, employee.surname.to_s, employee.role.to_s, employee.clocked_at.strftime('%H:%M').to_s]
  end
end




end