require 'fox16'
include Fox

class Student_list_view < FXMainWindow
  def initialize(app)
    super(app, "Моё FXRuby приложение с вкладками", width: 600, height: 400)

    vertical_frame = FXVerticalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    tab_book = FXTabBook.new(vertical_frame, nil, 0, TABBOOK_NORMAL | LAYOUT_FILL_X | LAYOUT_FILL_Y)

    #Вкладка "Список студентов"
    tab_item1 = FXTabItem.new(tab_book, "Список студентов")
    tab1_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)
    
    @table = FXTable.new(tab1_frame, opts: LAYOUT_FILL_X | LAYOUT_FILL_Y | TABLE_COL_SIZABLE | TABLE_ROW_SIZABLE)
    @table.visibleRows = 10
    @table.visibleColumns = 4

    @table.setTableSize(10, 4)
    @table.setColumnText(0, "ID")
    @table.setColumnText(1, "Фамилия")
    @table.setColumnText(2, "Имя")
    @table.setColumnText(3, "Гит")

    students = [
      { id: 1, surname: "Иванов", name: "Иван", git: "ivanov_git" },
      { id: 2, surname: "Петров", name: "Петр", git: "petrov_git" },
      { id: 3, surname: "Сидоров", name: "Сидор", git: nil }
    ]

    students.each_with_index do |student, i|
      @table.setItemText(i, 0, student[:id].to_s)
      @table.setItemText(i, 1, student[:surname])
      @table.setItemText(i, 2, student[:name])
      @table.setItemText(i, 3, student[:git] || "Нет")
    end

    @table.editable = false

    # Вторая вкладка
    tab_item2 = FXTabItem.new(tab_book, "Вкладка 2")
    tab2_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)
    FXLabel.new(tab2_frame, "Это вторая вкладка.")

    # Третья вкладка
    tab_item3 = FXTabItem.new(tab_book, "Вкладка 3")
    tab3_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)
    FXLabel.new(tab3_frame, "Это третья вкладка.")

    self.connect(SEL_CLOSE) { app.exit }
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $PROGRAM_NAME
  app = FXApp.new("Student_list_view", "FXRubyDemo")
  MyApp.new(app)
  app.create
  app.run
end
