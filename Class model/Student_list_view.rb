require 'fox16'
include Fox

class Student_list_view < FXMainWindow
  def initialize(app)
    super(app, "Приложение: Список студентов", width: 800, height: 600)

    main_frame = FXVerticalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    tab_book = FXTabBook.new(main_frame, nil, 0, TABBOOK_NORMAL | LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Вкладка 1: Список студентов
    tab_item1 = FXTabItem.new(tab_book, "Список студентов")
    tab1_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    filter_group = FXGroupBox.new(tab1_frame, "Фильтрация", FRAME_RAISED | LAYOUT_FILL_X)
    filter_group.layoutHints = LAYOUT_FILL_X | LAYOUT_SIDE_TOP

    filter_row1 = FXHorizontalFrame.new(filter_group, LAYOUT_FILL_X)
    FXLabel.new(filter_row1, "Фамилия и инициалы:")
    surname_field = FXTextField.new(filter_row1, 20)

    def create_filter_row(parent, label_text)
      row = FXHorizontalFrame.new(parent, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
      FXLabel.new(row, "#{label_text}:")

      radio_frame = FXHorizontalFrame.new(row, LAYOUT_SIDE_LEFT)
      radio_yes = FXRadioButton.new(radio_frame, "Да")
      radio_no = FXRadioButton.new(radio_frame, "Нет")
      radio_not = FXRadioButton.new(radio_frame, "Не важно")
      radio_not.checkState = true

      text_field = FXTextField.new(row, 20)
      text_field.enabled = false

      radio_yes.connect(SEL_COMMAND) { text_field.enabled = true }
      radio_no.connect(SEL_COMMAND) { text_field.enabled = false }
      radio_not.connect(SEL_COMMAND) { text_field.enabled = false }

      { radio_yes: radio_yes, radio_no: radio_no, radio_not: radio_not, text_field: text_field }
    end

    filter_git = create_filter_row(filter_group, "Git")
    filter_email = create_filter_row(filter_group, "Email")
    filter_phone = create_filter_row(filter_group, "Телефон")
    filter_telegram = create_filter_row(filter_group, "Telegram")

    table_group = FXGroupBox.new(tab1_frame, "Таблица студентов", FRAME_RAISED | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    table = FXTable.new(table_group, opts: LAYOUT_FILL_X | LAYOUT_FILL_Y | TABLE_COL_SIZABLE | TABLE_ROW_SIZABLE)
    table.setTableSize(10, 5) # Пример: 10 строк, 5 столбцов

    table.setColumnText(0, "ID")
    table.setColumnText(1, "Фамилия")
    table.setColumnText(2, "Имя")
    table.setColumnText(3, "Git")
    table.setColumnText(4, "Email")

    sample_students = [
      { id: 1, surname: "Иванов", name: "Иван", git: "ivan_git", email: "ivan@mail.com" },
      { id: 2, surname: "Петров", name: "Петр", git: "petrov_git", email: "petr@mail.com" },
      { id: 3, surname: "Сидоров", name: "Сидор", git: nil, email: "sidor@mail.com" }
    ]
    sample_students.each_with_index do |student, i|
      table.setItemText(i, 0, student[:id].to_s)
      table.setItemText(i, 1, student[:surname])
      table.setItemText(i, 2, student[:name])
      table.setItemText(i, 3, student[:git] || "Нет")
      table.setItemText(i, 4, student[:email])
    end
    table.editable = false

    control_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL_X | LAYOUT_SIDE_BOTTOM)
    add_btn = FXButton.new(control_frame, "Добавить")
    edit_btn = FXButton.new(control_frame, "Изменить")
    delete_btn = FXButton.new(control_frame, "Удалить")
    refresh_btn = FXButton.new(control_frame, "Обновить")

    # Вкладка 2
    tab_item2 = FXTabItem.new(tab_book, "Вкладка 2")
    tab2_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)
    FXLabel.new(tab2_frame, "Содержимое второй вкладки.")

    # Вкладка 3
    tab_item3 = FXTabItem.new(tab_book, "Вкладка 3")
    tab3_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)
    FXLabel.new(tab3_frame, "Содержимое третьей вкладки.")

    self.connect(SEL_CLOSE) { app.exit }
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $PROGRAM_NAME
  app = FXApp.new("Student_list_view", "FXRubyDemo")
  Student_list_view.new(app)
  app.create
  app.run
end
