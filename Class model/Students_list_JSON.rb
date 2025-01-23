require 'json'
require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student_short'
require_relative 'Data_list_student_short'
require_relative 'Student'

class Students_list_JSON
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  # Чтение всех значений из файла
  def read_students
    return [] unless File.exist?(file_path) # Если файл не существует, возвращаем пустой массив

    file_content = File.read(file_path)
    JSON.parse(file_content, symbolize_names: true)
  rescue JSON::ParserError => e
    raise "Ошибка парсинга файла JSON: #{e.message}"
  end

  # Запись всех значений в файл
  def write_students(students)
    json_data = students.map do |student|
      {
        id: student.id,
        surname: student.surname,
        name: student.name,
        middle_name: student.middle_name,
        git: student.git,
        contact: student.contact
      }
    end

    File.write(file_path, JSON.pretty_generate(json_data))
  rescue IOError => e
    raise "Ошибка записи в файл: #{e.message}"
  end

  # Получение объекта Student по ID
  def find_student_by_id(id)
    students_data = read_students
    student_data = students_data.find { |student| student[:id] == id }
    raise "Студент с ID #{id} не найден" unless student_data

    Student.new(student_data)
  end

  # Получение списка k по счету n объектов Student_short
  def get_k_n_student_short_list(k, n, data_list = nil)
    students_data = read_students
    total_students = students_data.size

    # Вычисление индексов начала и конца для выборки
    start_index = (k - 1) * n
    end_index = [start_index + n - 1, total_students - 1].min

    # Если нет существующего data_list, создаем новый
    data_list ||= Data_list_student_short.new([])

    # Выбираем нужные записи и преобразуем их в объекты Student_short
    selected_students = students_data[start_index..end_index].map do |student_data|
      StudentShort.new_obj_student_short(Student.new(student_data))
    end

    # Обновляем данные в data_list
    data_list.elements = selected_students
    data_list
  end

  # Сортировка элементов по фамилии и инициалам
  def sort_by_surname_and_initials
    students_data = read_students

    sorted_students = students_data.sort_by do |student|
      "#{student[:surname]} #{student[:name][0]}.#{student[:middle_name][0]}."
    end

    write_students(sorted_students)
    sorted_students
  end

  # Добавление объекта Student в список
  def add_student(new_student)
    students_data = read_students

    # Генерация нового уникального ID
    max_id = students_data.map { |student| student[:id] }.max || 0
    new_id = max_id + 1

    # Создание записи нового студента
    new_student_data = {
      id: new_id,
      surname: new_student.surname,
      name: new_student.name,
      middle_name: new_student.middle_name,
      git: new_student.git,
      contact: new_student.phone || new_student.telegram || new_student.email
    }

    # Добавление и запись обновленного списка
    students_data << new_student_data
    write_students(students_data)

    new_id
  end

  # Замена элемента списка по ID
  def replace_student_by_id(id, updated_student)
    students_data = read_students

    # Поиск индекса студента с нужным ID
    index = students_data.find_index { |student| student[:id] == id }
    raise "Студент с ID #{id} не найден" unless index

    # Обновление данных студента
    students_data[index] = {
      id: id,
      surname: updated_student.surname,
      name: updated_student.name,
      middle_name: updated_student.middle_name,
      git: updated_student.git,
      contact: updated_student.phone || updated_student.telegram || updated_student.email
    }

    # Запись изменений
    write_students(students_data)
  end

  def delete_student_by_id(id)
    students_data = read_students

    # Найти индекс элемента с указанным ID
    index = students_data.find_index { |student| student[:id] == id }
    raise "Студент с ID #{id} не найден" unless index

    # Удалить элемент
    students_data.delete_at(index)

    # Сохранить изменения
    write_students(students_data)

    true # Возвращаем true, если успешно удалено
  end

  # Получение количества элементов
  def get_student_short_count
    students_data = read_students
    students_data.size
  end
  
end
