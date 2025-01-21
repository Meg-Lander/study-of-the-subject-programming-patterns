class Data_table
  attr_accessor :data
  private :data

  def initialize(data)
    self.data = data
  end

  def get_element(row, col)
    self.data[row][col]
  end

  def num_rows
    self.data.size
  end

  def num_columns
    self.data[0].size
    end

  def to_s
    self.data.map {|row| row.join("\t")}.join("\n")
  end

end