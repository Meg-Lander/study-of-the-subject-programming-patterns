require 'fox16'
include Fox

class StudentListView < FXMainWindow
  attr_reader :current_page, :items_per_page

  def initialize(app)
    super(app, "Student list", width: 1200, height: 600)
    @filters = {}
    @current_page = 0
    @items_per_page = 20
    @total_pages = 3 # Временное значение, будет пересчитываться
    @sort_column = :name
    @sort_order = :asc

    # Синтетические данные
    @students = generate_students(50)

    # Инициализация интерфейса
    setup_tabs
    setup_filtration
    setup_table
    setup_pagination
    setup_controls
    refresh_data
  end

  private

  # Генерация синтетических данных
  def generate_students(count)
    students = []
    count.times do |i|
      students << {
        id: i + 1,
        name: "Студент #{i + 1}",
        git: "git#{i + 1}",
        email: "student#{i + 1}@example.com",
        phone: "+791500000#{i.to_s.rjust(2, '0')}",
        telegram: "@student#{i + 1}"
      }
    end
    students
  end

  # Настройка вкладок
  def setup_tabs
    tab_book = FXTabBook.new(self, nil, 0, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Первая вкладка (основная)
    tab1 = FXTabItem.new(tab_book, " Студенты ", nil)
    @main_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Заглушки для остальных вкладок
    FXTabItem.new(tab_book, " Вкладка 2 ", nil)
    FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)
    FXTabItem.new(tab_book, " Вкладка 3 ", nil)
    FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)
  end

  # Настройка фильтрации
  def setup_filtration
    filter_frame = FXVerticalFrame.new(@main_frame, LAYOUT_FILL_X)

    # Фильтр по ФИО
    name_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(name_frame, "ФИО:", opts: LAYOUT_FIX_WIDTH, width: 80)
    @name_input = FXTextField.new(name_frame, 30, opts: LAYOUT_FILL_X)

    # Фильтры для Git/Email/Телефона/Telegram
    [
      ["Git:",     :git],
      ["Почта:",   :email],
      ["Телефон:", :phone],
      ["Telegram:", :telegram]
    ].each do |label, key|
      setup_filter_section(filter_frame, label, key)
    end

    # Кнопки "Сбросить" и "Применить фильтр" в одной строке
    button_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    FXButton.new(button_frame, "Сбросить", opts: BUTTON_NORMAL | LAYOUT_FILL_X).connect(SEL_COMMAND) do
      reset_filters
    end
    FXButton.new(button_frame, "Применить фильтр", opts: BUTTON_NORMAL | LAYOUT_FILL_X).connect(SEL_COMMAND) do
      apply_filters
    end
  end

  # Настройка секции фильтра
  def setup_filter_section(parent, label, key)
    section_frame = FXHorizontalFrame.new(parent, LAYOUT_FILL_X)
    FXLabel.new(section_frame, label, opts: LAYOUT_FIX_WIDTH, width: 80)

    combo_box = FXComboBox.new(section_frame, 3, opts: COMBOBOX_STATIC | LAYOUT_FILL_X)
    combo_box.appendItem("Да")
    combo_box.appendItem("Нет")
    combo_box.appendItem("Не важно")
    combo_box.setCurrentItem(2)

    input_field = FXTextField.new(section_frame, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    input_field.enabled = false

    combo_box.connect(SEL_COMMAND) do
      input_field.enabled = (combo_box.currentItem == 0)
      input_field.text = "" unless input_field.enabled?
    end

    @filters[key] = { combo: combo_box, field: input_field }
  end

  # Настройка таблицы
  def setup_table
    @table = FXTable.new(@main_frame, opts: TABLE_READONLY | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    @table.setTableSize(@items_per_page, 6)

    # Обработчик клика только для колонки с ФИО (колонка 1)
    @table.columnHeader.connect(SEL_COMMAND) do |sender, sel, column|
      if column == 1 # Колонка с ФИО
        @sort_order = @sort_order == :asc ? :desc : :asc
        refresh_data
      end
    end

    set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)
  end


  # Метод для настройки параметров таблицы
  def set_table_params(column_names, whole_entities_count)
    display_names = {
      
      'name' => 'ФИО',
      'git' => 'Git',
      'email' => 'Почта',
      'phone' => 'Телефон',
      'telegram' => 'Telegram'
    }
    @table.setColumnText(0, "№")
    column_names.each_with_index do |name, id|
      display_name = display_names[name] || name
      @table.setColumnText(id + 1, display_name)
    end
    @table.setColumnWidth(0, 30)
    @table.setColumnWidth(1, 200)
    @table.setColumnWidth(2, 150)
    @table.setColumnWidth(3, 200)
    @table.setColumnWidth(4, 150)
    @table.setColumnWidth(5, 150)
  end

  # Настройка пагинации
  def setup_pagination
    nav_frame = FXHorizontalFrame.new(@main_frame, LAYOUT_CENTER_X)
    @prev_button = FXButton.new(nav_frame, "←", opts: BUTTON_NORMAL)
    @page_label = FXLabel.new(nav_frame, "1")
    @next_button = FXButton.new(nav_frame, "→", opts: BUTTON_NORMAL)

    @prev_button.connect(SEL_COMMAND) { change_page(-1) }
    @next_button.connect(SEL_COMMAND) { change_page(1) }
  end

  # Настройка кнопок управления
  def setup_controls
    control_frame = FXHorizontalFrame.new(@main_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    %w[Добавить Изменить Удалить Закрыть].each do |btn|
      FXButton.new(control_frame, btn, opts: BUTTON_NORMAL | LAYOUT_FILL_X).connect(SEL_COMMAND) do
        case btn
        when "Закрыть" then exit_application
        else handle_action(btn)
        end
      end
    end
  end

  # Закрытие приложения
  def exit_application
    getApp.exit
  end

  # Применение фильтров
  def apply_filters
    name_filter = @name_input.text.strip.downcase
    
    filtered = @students.select do |s|
      (name_filter.empty? || s[:name].downcase.include?(name_filter)) &&
      apply_contact_filter(s, :git) &&
      apply_contact_filter(s, :email) &&
      apply_contact_filter(s, :phone) &&
      apply_contact_filter(s, :telegram)
    end

    @students = filtered
    @current_page = 0
    refresh_data
  end

  # Обновление данных в таблице
  def refresh_data
    # Сортировка только по имени
    sorted_students = @students.sort_by { |s| s[:name].downcase }
    sorted_students.reverse! if @sort_order == :desc

    # Пагинация
    start_index = @current_page * @items_per_page
    end_index = start_index + @items_per_page
    current_students = sorted_students[start_index...end_index] || []
    
    # Обновление таблицы
    @table.clearItems
    @table.setTableSize(@items_per_page, 6)

    current_students.each_with_index do |student, i|
      @table.setItemText(i, 0, (start_index + i + 1).to_s)
      @table.setItemText(i, 1, student[:name])
      @table.setItemText(i, 2, student[:git])
      @table.setItemText(i, 3, student[:email])
      @table.setItemText(i, 4, student[:phone])
      @table.setItemText(i, 5, student[:telegram])
    end
    
    set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)
    @page_label.text = "#{@current_page + 1}/#{(sorted_students.size.to_f / @items_per_page).ceil}"
  end

  def apply_contact_filter(student, key)
    combo = @filters[key][:combo]
    field = @filters[key][:field]
    
    case combo.currentItem
    when 0 # Да
      student[key]&.downcase&.include?(field.text.strip.downcase)
    when 1 # Нет
      student[key].nil? || student[key].empty?
    else   # Не важно
      true
    end
  end
  # Сброс фильтров
  def reset_filters
    @name_input.text = ""
    @filters.each_value { |f| f[:field].text = "" }
    refresh_data
  end

  # Обработка действий (заглушка)
  def handle_action(action)
    puts "Действие: #{action}"
  end

  # Переключение страниц
  def change_page(delta)
    new_page = @current_page + delta
    return if new_page < 0 || new_page >= @total_pages
    @current_page = new_page
    refresh_data
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

# Запуск приложения
if __FILE__ == $0
  app = FXApp.new
  StudentListView.new(app)
  app.create
  app.run
end