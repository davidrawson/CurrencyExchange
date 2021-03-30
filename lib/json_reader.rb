require "json"

#Public: Reads JSON file and parses contents to a hash
class JsonReader
  # Public: Initialise the object
  #
  # filename - name of JSON file
  def initialize(filename)
    @filename = filename
  end

  # Public: reads file and parses contents to a hash
  #
  # Returns a hash
  def read
    file = File.read(@filename)
    JSON.parse(file)
  end
end
