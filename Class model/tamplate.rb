class Character
  def prepare
    select_class
    equip_gear
    setup_skills
  end

  private

  def select_class
    puts "Выбор класса персонажа..."
  end

  # Абстрактные методы
  def equip_gear
    raise NotImplementedError, "Метод 'equip_gear' должен быть реализован"
  end

  def setup_skills
    raise NotImplementedError, "Метод 'setup_skills' должен быть реализован"
  end
end

# Подкласс для Воина
class Warrior < Character
  private

  def equip_gear
    puts "Снаряжение: Меч, Щит, Латы..."
  end

  def setup_skills
    puts "Настройка навыков: Удар щитом, Рывок, Защита..."
  end
end

# Подкласс для Мага
class Mage < Character
  private

  def equip_gear
    puts "Снаряжение: Посох, Магическая мантия..."
  end

  def setup_skills
    puts "Настройка навыков: Огненный шар, Ледяной шип, Щит маны..."
  end
end
