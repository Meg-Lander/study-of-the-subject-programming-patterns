require 'fox16'
include Fox

class StudentListView < FXMainWindow
  def initialize(app)
    super(app, "Список студентов", width: 800, height: 500)
    
    main_frame = FXVerticalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)


    filter_frame = FXMatrix.new(main_frame, 2, MATRIX_BY_COLUMNS | LAYOUT_FILL_X)


    FXLabel.new(filter_frame, "ФИО: ")
    @filter_name = FXTextField.new(filter_frame, 20)


    @git_label = FXLabel.new(filter_frame, "Git: ")
    @git_combo = FXComboBox.new(filter_frame, 3, opts: COMBOBOX_STATIC | LAYOUT_FILL_X)
    @git_combo.appendItem("Не важно")
    @git_combo.appendItem("Да")
    @git_combo.appendItem("Нет")
    @git_combo.numVisible = 3
    @git_field = FXTextField.new(filter_frame, 20, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    @git_field.enabled = false

    @git_combo.connect(SEL_COMMAND) do
      @git_field.enabled = @git_combo.currentItem == 1
    end


    @email_label = FXLabel.new(filter_frame, "Email: ")
    @email_combo = FXComboBox.new(filter_frame, 3, opts: COMBOBOX_STATIC | LAYOUT_FILL_X)
    @email_combo.appendItem("Не важно")
    @email_combo.appendItem("Да")
    @email_combo.appendItem("Нет")
    @email_combo.numVisible = 3
    @email_field = FXTextField.new(filter_frame, 20, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    @email_field.enabled = false

    @email_combo.connect(SEL_COMMAND) do
      @email_field.enabled = @email_combo.currentItem == 1
    end


    @phone_label = FXLabel.new(filter_frame, "Телефон: ")
    @phone_combo = FXComboBox.new(filter_frame, 3, opts: COMBOBOX_STATIC | LAYOUT_FILL_X)
    @phone_combo.appendItem("Не важно")
    @phone_combo.appendItem("Да")
    @phone_combo.appendItem("Нет")
    @phone_combo.numVisible = 3
    @phone_field = FXTextField.new(filter_frame, 20, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    @phone_field.enabled = false

    @phone_combo.connect(SEL_COMMAND) do
      @phone_field.enabled = @phone_combo.currentItem == 1
    end

    @tg_label = FXLabel.new(filter_frame, "Telegram: ")
    @tg_combo = FXComboBox.new(filter_frame, 3, opts: COMBOBOX_STATIC | LAYOUT_FILL_X)
    @tg_combo.appendItem("Не важно")
    @tg_combo.appendItem("Да")
    @tg_combo.appendItem("Нет")
    @tg_combo.numVisible = 3
    @tg_field = FXTextField.new(filter_frame, 20, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    @tg_field.enabled = false

    @tg_combo.connect(SEL_COMMAND) do
      @tg_field.enabled = @tg_combo.currentItem == 1
    end

    FXButton.new(filter_frame, "Применить фильтр", opts: BUTTON_NORMAL | LAYOUT_FILL_X).connect(SEL_COMMAND) do
      apply_filter
    end

    # --- Таблица студентов ---
    @table = FXTable.new(main_frame, opts: TABLE_COL_SIZABLE | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    @table.setTableSize(0, 4)
    ["ID", "ФИО", "Git", "Контакты"].each_with_index do |header, index|
      @table.setColumnText(index, header)
    end

    # Область управления
    control_frame = FXHorizontalFrame.new(main_frame, LAYOUT_FILL_X)
    FXButton.new(control_frame, "Добавить").connect(SEL_COMMAND) { add_student }
    FXButton.new(control_frame, "Редактировать").connect(SEL_COMMAND) { edit_student }
    FXButton.new(control_frame, "Удалить").connect(SEL_COMMAND) { delete_student }
    FXButton.new(control_frame, "Закрыть").connect(SEL_COMMAND) { exit_application }

    load_students
  end

  def apply_filter
    name_filter = @filter_name.text.strip.downcase
    git_filter = @git_combo.currentItem == 1 ? @git_field.text.strip.downcase : nil
    email_filter = @email_combo.currentItem == 1 ? @email_field.text.strip.downcase : nil
    phone_filter = @phone_combo.currentItem == 1 ? @phone_field.text.strip.downcase : nil
    tg_filter = @tg_combo.currentItem == 1 ? @tg_field.text.strip.downcase : nil

    @table.clearItems
    @table.setTableSize(0, 4)

    # Пример данных
    students = [
      { id: "1", name: "Иванов Иван", git: "ivanov_git", email: "ivanov@mail.com", phone: "123456", tg: "@ivanov" },
      { id: "2", name: "Петров Петр", git: "petrov_git", email: "petrov@mail.com", phone: "654321", tg: "@petrov" }
    ]

    filtered_students = students.select do |student|
      (name_filter.empty? || student[:name].downcase.include?(name_filter)) &&
      (git_filter.nil? || student[:git].downcase.include?(git_filter)) &&
      (email_filter.nil? || student[:email].downcase.include?(email_filter)) &&
      (phone_filter.nil? || student[:phone].downcase.include?(phone_filter)) &&
      (tg_filter.nil? || student[:tg].downcase.include?(tg_filter))
    end

    # Заполняем таблицу отфильтрованными данными
    @table.appendRows(filtered_students.size)
    filtered_students.each_with_index do |student, i|
      @table.setItemText(i, 0, student[:id])
      @table.setItemText(i, 1, student[:name])
      @table.setItemText(i, 2, student[:git])
      @table.setItemText(i, 3, student[:email])
    end

    puts "Фильтр применён: ФИО=#{name_filter}, Git=#{git_filter}, Email=#{email_filter}, Телефон=#{phone_filter}, Telegram=#{tg_filter}"
  end


  # Метод для загрузки студентов (заглушка)
  def load_students
    @table.appendRows(2)
    @table.setItemText(0, 0, "1")
    @table.setItemText(0, 1, "Иванов Иван")
    @table.setItemText(0, 2, "ivanov_git")
    @table.setItemText(0, 3, "ivanov@mail.com")

    @table.setItemText(1, 0, "2")
    @table.setItemText(1, 1, "Петров Петр")
    @table.setItemText(1, 2, "petrov_git")
    @table.setItemText(1, 3, "petrov@mail.com")
  end

  # Заглушки для кнопок
  def add_student
    puts "Добавление студента"
  end

  def edit_student
    puts "Редактирование студента"
  end

  def delete_student
    puts "Удаление студента"
  end

  # Метод для закрытия окна
  def exit_application
    getApp().exit
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  app = FXApp.new
  StudentListView.new(app)
  app.create
  app.run
end
