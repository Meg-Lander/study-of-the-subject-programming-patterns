require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student_short'
require_relative 'Data_list_student_short'
require_relative 'Student'
require_relative 'strategy_list_file'
require 'pg'
require_relative 'Student'

class Students_list_DB
  def initialize(db_params)
    @conn = PG.connect(db_params)
  end

  def close
    @conn.close
  end

  # Получить объект класса Student по ID
  def get_student_by_id(id)
    result = @conn.exec_params('SELECT * FROM students WHERE id = $1', [id])
    if result.ntuples > 0
      student_data = result[0]
      Student.new(
        id: student_data['id'],
        surname: student_data['surname'],
        name: student_data['name'],
        middle_name: student_data['middle_name'],
        git: student_data['git'],
        phone: student_data['phone'],
        email: student_data['email'],
        telegram: student_data['telegram']
      )
    else
      raise "Студент с ID #{id} не найден"
    end
  end

  # Получить список k по счету n объектов класса Student_short
  def get_k_n_student_short_list(k, n)
    offset = (k - 1) * n
    result = @conn.exec_params('SELECT * FROM students LIMIT $1 OFFSET $2', [n, offset])

    students = result.map do |row|
      StudentShort.new_obj_student_short(
        Student.new(
          id: row['id'],
          surname: row['surname'],
          name: row['name'],
          middle_name: row['middle_name'],
          git: row['git'],
          phone: row['phone'],
          email: row['email'],
          telegram: row['telegram']
        )
      )
    end

    Data_list_student_short.new(students)
  end

  # Добавить объект класса Student в список
  def add_student(new_student)
    result = @conn.exec_params(
      'INSERT INTO students (surname, name, middle_name, git, phone, email, telegram) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id',
      [
        new_student.surname,
        new_student.name,
        new_student.middle_name,
        new_student.git,
        new_student.phone,
        new_student.email,
        new_student.telegram
      ]
    )
    result[0]['id'].to_i
  end

  # Заменить элемент списка по ID
  def replace_student_by_id(id, updated_student)
    @conn.exec_params(
      'UPDATE students SET surname = $1, name = $2, middle_name = $3, git = $4, phone = $5, email = $6, telegram = $7 WHERE id = $8',
      [
        updated_student.surname,
        updated_student.name,
        updated_student.middle_name,
        updated_student.git,
        updated_student.phone,
        updated_student.email,
        updated_student.telegram,
        id
      ]
    )
  end

  # Удалить элемент списка по ID
  def delete_student_by_id(id)
    @conn.exec_params('DELETE FROM students WHERE id = $1', [id])
  end

  # Получить количество элементов
  def get_student_count
    result = @conn.exec('SELECT COUNT(*) FROM students')
    result[0]['count'].to_i
  end
end
