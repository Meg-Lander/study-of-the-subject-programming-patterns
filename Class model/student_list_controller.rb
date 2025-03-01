require_relative 'Data_list_student_short'
require_relative 'Student_List_View'
require_relative 'Students_list_JSON'
require_relative 'Students_list'


require 'fox16'
include Fox

class Student_List_Controller
  attr_reader :student_list, :current_page

  def initialize(view)
    @view = view
    @student_list = Students_list.new('students.json', Students_list_JSON.new)
    @data_list = Data_list_student_short.new([])
    @data_list.add_observer(@view)
    @current_page = 0
  end

  def next_page
    @current_page += 1
    refresh_data
  end

  def prev_page
    @current_page -= 1 if @current_page > 0
    refresh_data
  end

  def set_page(page)
    @current_page = page
    refresh_data
  end

   def refresh_data
    @student_list.read
    
    @total_items = @student_list.get_student_short_count
    
    total_pages = (@total_items.to_f / @view.items_per_page).ceil
    @current_page = [[@current_page, total_pages - 1].min, 0].max
    
    k = @current_page + 1
    n = @view.items_per_page
    @student_list.get_k_n_student_short_list(k, n, @data_list)
    
    @data_list.notify
  end

  def get_student_count
    @student_list.get_student_short_count
  end

end
