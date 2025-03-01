require_relative 'Student_List_Controller'

require 'fox16'
include Fox

class Student_List_View < FXMainWindow
  attr_reader :current_page, :items_per_page

  def initialize(app)
    super(app, "Student list", width: 1200, height: 800)
    @controller = Student_List_Controller.new(self)
    @current_page = 0
    @items_per_page = 20

    @sort_order = :asc
    @current_data = Data_table.new([])
    
    setup_tabs
    setup_filtration
    setup_table
    setup_pagination
    setup_controls
    @controller.refresh_data
  end

  def set_table_params(column_names, whole_entities_count)
    display_names = {
      'surname_with_initials' => 'Фамилия и инициалы',
      'contact' => 'Контакт',
      'git' => 'Git'
    }
    @table.setColumnText(0, "№")
    column_names.each_with_index do |name, id|
      display_name = display_names[name] || name
      @table.setColumnText(id + 1, display_name)
    end
    @table.setColumnWidth(0, 30)
    @table.setColumnWidth(1, 150)
    @table.setColumnWidth(2, 150)
    @table.setColumnWidth(3, 200)
  end

  def setup_dummy_filter_section(parent, label)
    section_frame = FXHorizontalFrame.new(parent, LAYOUT_FILL_X)
    FXLabel.new(section_frame, label, opts: LAYOUT_FIX_WIDTH, width: 80)

    combo_box = FXComboBox.new(section_frame, 3, opts: COMBOBOX_STATIC | LAYOUT_FILL_X)
    combo_box.appendItem("Да")
    combo_box.appendItem("Нет")
    combo_box.appendItem("Не важно")
    combo_box.setCurrentItem(2)

    FXTextField.new(section_frame, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X).enabled = false
  end

  def set_table_data(data_table)
  
    @current_data = data_table

    @table.setTableSize(data_table.num_rows, data_table.num_columns)

    data_table.num_rows.times do |row|
      data_table.num_columns.times do |col|
        @table.setItemText(row, col, data_table.get_element(row, col).to_s)
      end
    end
    set_column_widths([50, 150, 200, 150])
    update_page_label
    update_buttons_state
  end

  def sort_by_name
    @sort_order = (@sort_order == :asc) ? :desc : :asc

    data_array = []
    @current_data.num_rows.times do |row|
      student = {
        name: @current_data.get_element(row, 1),
        git: @current_data.get_element(row, 2),
        email: @current_data.get_element(row, 3)
      }
      data_array << student
    end

    sorted_data = data_array.sort_by { |student| student[:name] }
    sorted_data.reverse! if @sort_order == :desc

    table_data = sorted_data.map.with_index do |student, index|
      [index + 1, student[:name], student[:git], student[:email]]
    end
    sorted_data_table = Data_table.new(table_data)

    
    set_table_data(sorted_data_table)
  end

  private

  def setup_tabs
    tab_book = FXTabBook.new(self, nil, 0, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    tab1 = FXTabItem.new(tab_book, " Студенты ", nil)
    @main_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    FXTabItem.new(tab_book, " Вкладка 2 ", nil)
    FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)
    FXTabItem.new(tab_book, " Вкладка 3 ", nil)
    FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y)
  end

  def setup_filtration
    filter_frame = FXVerticalFrame.new(@main_frame, LAYOUT_FILL_X)

    name_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(name_frame, "ФИО:", opts: LAYOUT_FIX_WIDTH, width: 80)
    @name_input = FXTextField.new(name_frame, 30, opts: LAYOUT_FILL_X)

    [
      ["Git:", :git],
      ["Почта:", :email],
      ["Телефон:", :phone],
      ["Telegram:", :telegram]
    ].each do |label, key|
      setup_dummy_filter_section(filter_frame, label)
    end

    button_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    FXButton.new(button_frame, "Сбросить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    FXButton.new(button_frame, "Применить фильтр", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
  end

  def setup_table
    @table = FXTable.new(@main_frame, opts: TABLE_READONLY | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    @table.setTableSize(@items_per_page, 6)

    @table.columnHeader.connect(SEL_COMMAND) do |sender, sel, column|
    if column == 1
      sort_by_name
    end
  end

    @table.connect(SEL_SELECTED) { update_buttons_state }
    @table.connect(SEL_DESELECTED) { update_buttons_state }
  end

  def set_column_widths(widths)
    widths.each_with_index do |width, index|
      @table.setColumnWidth(index, width)
    end
  end

  def setup_pagination
    nav_frame = FXHorizontalFrame.new(@main_frame, LAYOUT_CENTER_X)
    @prev_button = FXButton.new(nav_frame, "←", opts: BUTTON_NORMAL)
    @page_label = FXLabel.new(nav_frame, "1")
    @next_button = FXButton.new(nav_frame, "→", opts: BUTTON_NORMAL)

    @prev_button.connect(SEL_COMMAND) { @controller.prev_page }
    @next_button.connect(SEL_COMMAND) { @controller.next_page }

    update_page_label
  end

  def update_page_label
    total_items = @controller.get_student_count
    total_pages = (total_items.to_f / @items_per_page).ceil
    current_page = @controller.current_page + 1
    @page_label.text = "#{current_page}/#{total_pages}"
  end

  def setup_controls
    control_frame = FXHorizontalFrame.new(@main_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)

    @add_button = FXButton.new(control_frame, "Добавить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @edit_button = FXButton.new(control_frame, "Изменить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @delete_button = FXButton.new(control_frame, "Удалить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @refresh_button = FXButton.new(control_frame, "Обновить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)

    @refresh_button.connect(SEL_COMMAND) do
      @controller.refresh_data
      update_page_label
      update_buttons_state
    end

    @add_button.connect(SEL_COMMAND) { handle_action("Добавить") }
    @edit_button.connect(SEL_COMMAND) { handle_action("Изменить") }
    @delete_button.connect(SEL_COMMAND) { handle_action("Удалить") }
    @refresh_button.connect(SEL_COMMAND) { @controller.refresh_data }

    @table.connect(SEL_SELECTED) { update_buttons_state }
    @table.connect(SEL_DESELECTED) { update_buttons_state }
  end

  def update_buttons_state
    if @table.selStartRow < 0 || @table.selEndRow < 0
      @edit_button.enabled = false
      @delete_button.enabled = false
      @edit_button.backColor = FXRGB(192, 192, 192)
      @delete_button.backColor = FXRGB(192, 192, 192)
      return
    end

    selected_rows = @table.selStartRow..@table.selEndRow
    count = selected_rows.size

    @edit_button.enabled = (count == 1)
    @delete_button.enabled = (count >= 1)

    @edit_button.backColor = @edit_button.enabled? ? FXRGB(255, 255, 255) : FXRGB(192, 192, 192)
    @delete_button.backColor = @delete_button.enabled? ? FXRGB(255, 255, 255) : FXRGB(192, 192, 192)
  end

  def handle_action(action)
    
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
