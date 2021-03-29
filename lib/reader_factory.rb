require_relative "json_reader"

class ReaderFactory

  def create_reader(filename)
    file_extension = File.extname(filename)

    case file_extension
    when ".json"
      JsonReader.new(filename)
    else
      raise "File with extension #{file_extension} does not have a corresponding Reader."
    end
  end
end
