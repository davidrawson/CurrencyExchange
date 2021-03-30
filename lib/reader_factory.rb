require_relative "json_reader"

# Public: Factory for producing file readers
class ReaderFactory
  # Public: Creates reader for appropriate file type
  #
  # filename - name of file containing exchange rates
  #
  # Returns a new file reader
  # Raises RuntimeError if file extension not supported
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
