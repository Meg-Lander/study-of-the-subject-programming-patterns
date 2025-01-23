class File_strategy
  def read(file_path)
    raise NotImplementedError, "Метод read должен быть реализован в подклассе"
  end

  def write(file_path, data)
    raise NotImplementedError, "Метод write должен быть реализован в подклассе"
  end
end
