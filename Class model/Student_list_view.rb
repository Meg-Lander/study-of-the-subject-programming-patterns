require 'fox16'
include Fox


class Student_list_view < FXMainWindow
  def initialize(app)
    super(app, "Моё FXRuby приложение с вкладками", width: 600, height: 400)

    vertical_frame = FXVerticalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    tab_book = FXTabBook.new(vertical_frame, nil, 0, TABBOOK_NORMAL | LAYOUT_FILL_X | LAYOUT_FILL_Y)

    #Первая вкладка
    tab_item1 = FXTabItem.new(tab_book, "Студенты")
    tab1_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)
    FXLabel.new(tab1_frame, "Это первая вкладка (Student_list_view).")

    #Вторая вкладка
    tab_item2 = FXTabItem.new(tab_book, "Вкладка 2")
    tab2_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)
    FXLabel.new(tab2_frame, "Это вторая вкладка.")

    # Третья вкладка
    tab_item3 = FXTabItem.new(tab_book, "Вкладка 3")
    tab3_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)
    FXLabel.new(tab3_frame, "Это третья вкладка.")

    self.connect(SEL_CLOSE) do |sender, sel, event|
      app.exit
    end
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $PROGRAM_NAME
  app = FXApp.new("MyApp", "FXRubyDemo")
  MyApp.new(app)
  app.create
  app.run
end
