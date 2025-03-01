require_relative 'Student_List_View'
require_relative 'Student_List_Controller'
require 'fox16'
include Fox


if __FILE__ == $0
  app = FXApp.new
  Student_List_View.new(app)
  app.create
  app.run
end