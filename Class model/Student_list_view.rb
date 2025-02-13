require 'fox16'
include Fox

class StudentListView < FXMainWindow
  attr_reader :current_page, :items_per_page

  def initialize(app)
    super(app, "Student list", width: 1200, height: 600)
    @filters = {}
    @current_page = 0
    @items_per_page = 20
    @total_pages = 3
    @sort_column = :name
    @sort_order = :asc

    @students = generate_students(50)

    setup_tabs
    setup_filtration
    setup_table
    setup_pagination
    setup_controls
    refresh_data
  end

  private

  def generate_students(count)
    students = []
    count.times do |i|
      students << {
        id: i + 1,
        name: "Студент #{i + 1}",
        git: i % 5 == 0 ? "" : "git#{i + 1}", 
        email: "student#{i + 1}@example.com",
        phone: "+791500000#{i.to_s.rjust(2, '0')}",
        telegram: i % 3 == 0 ? "" : "@student#{i + 1}" 
      }
    end
    students
  end

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
      setup_filter_section(filter_frame, label, key)
    end

    button_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    FXButton.new(button_frame, "Сбросить", opts: BUTTON_NORMAL | LAYOUT_FILL_X).connect(SEL_COMMAND) do
      reset_filters
    end
    FXButton.new(button_frame, "Применить фильтр", opts: BUTTON_NORMAL | LAYOUT_FILL_X).connect(SEL_COMMAND) do
      apply_filters
    end
  end

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

  def setup_table
    @table = FXTable.new(@main_frame, opts: TABLE_READONLY | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    @table.setTableSize(@items_per_page, 6)

    @table.columnHeader.connect(SEL_COMMAND) do |sender, sel, column|
      if column == 1
        @sort_order = @sort_order == :asc ? :desc : :asc
        refresh_data
      end
    end

    @table.connect(SEL_SELECTED) { update_buttons_state }
    @table.connect(SEL_DESELECTED) { update_buttons_state }

    set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)
  end


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

  def setup_pagination
    nav_frame = FXHorizontalFrame.new(@main_frame, LAYOUT_CENTER_X)
    @prev_button = FXButton.new(nav_frame, "←", opts: BUTTON_NORMAL)
    @page_label = FXLabel.new(nav_frame, "1")
    @next_button = FXButton.new(nav_frame, "→", opts: BUTTON_NORMAL)

    @prev_button.connect(SEL_COMMAND) { change_page(-1) }
    @next_button.connect(SEL_COMMAND) { change_page(1) }
  end

  def setup_controls
    control_frame = FXHorizontalFrame.new(@main_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    
    @add_button = FXButton.new(control_frame, "Добавить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @edit_button = FXButton.new(control_frame, "Изменить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @delete_button = FXButton.new(control_frame, "Удалить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @refresh_button = FXButton.new(control_frame, "Обновить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    
    @add_button.connect(SEL_COMMAND) { handle_action("Добавить") }
    @edit_button.connect(SEL_COMMAND) { handle_action("Изменить") }
    @delete_button.connect(SEL_COMMAND) { handle_action("Удалить") }
    @refresh_button.connect(SEL_COMMAND) { apply_filters }

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

    if count == 1
      @edit_button.enabled = true
      @edit_button.backColor = FXRGB(255, 255, 255) 
    else
      @edit_button.enabled = false
      @edit_button.backColor = FXRGB(192, 192, 192) 
    end

    if count >= 1
      @delete_button.enabled = true
      @delete_button.backColor = FXRGB(255, 255, 255)
    else
      @delete_button.enabled = false
      @delete_button.backColor = FXRGB(192, 192, 192) 
    end
  end

  def exit_application
    getApp.exit
  end

  def apply_filters
    @original_students ||= @students.dup
    
    name_filter = @name_input.text.strip.downcase
    
    @filtered_students = @original_students.select do |s|
      name_match = name_filter.empty? || s[:name].downcase.include?(name_filter)
      
      git_match = apply_contact_filter(s, :git)
      email_match = apply_contact_filter(s, :email)
      phone_match = apply_contact_filter(s, :phone)
      telegram_match = apply_contact_filter(s, :telegram)
      
      name_match && git_match && email_match && phone_match && telegram_match
    end
    
    @current_page = 0
    @total_pages = (@filtered_students.size.to_f / @items_per_page).ceil
    @total_pages = 1 if @total_pages == 0
    update_buttons_state
    refresh_data
  end

  def refresh_data
    current_data = @filtered_students || @original_students || @students
    
    sorted_students = current_data.sort_by { |s| s[:name].downcase }
    sorted_students.reverse! if @sort_order == :desc
    
    start_index = @current_page * @items_per_page
    end_index = [start_index + @items_per_page, sorted_students.size].min
    
    current_students = sorted_students[start_index...end_index] || []
    
    @table.clearItems
    @table.setTableSize(@items_per_page, 6)
    
    current_students.each_with_index do |student, i|
      @table.setItemText(i, 0, (start_index + i + 1).to_s)
      @table.setItemText(i, 1, student[:name])
      @table.setItemText(i, 2, student[:git] || "")
      @table.setItemText(i, 3, student[:email] || "")
      @table.setItemText(i, 4, student[:phone] || "")
      @table.setItemText(i, 5, student[:telegram] || "")
    end
  
    @total_pages = (sorted_students.size.to_f / @items_per_page).ceil
    @page_label.text = "#{@current_page + 1}/#{@total_pages}"
    set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)
    update_buttons_state
  end

  def apply_contact_filter(student, key)
    combo = @filters[key][:combo]
    field = @filters[key][:field]
    
    case combo.currentItem
    when 0 
      student[key]&.downcase&.include?(field.text.strip.downcase)
    when 1
      student[key].nil? || student[key].empty?
    else
      true
    end
  end

  def reset_filters
    @name_input.text = ""
    @filters.each_value { |f| f[:field].text = "" }
    refresh_data
  end

  def handle_action(action)
    puts "Действие: #{action}"
  end

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

if __FILE__ == $0
  app = FXApp.new
  StudentListView.new(app)
  app.create
  app.run
end