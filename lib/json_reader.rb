require "json"

class JsonReader

  def initialize(filename)
    @filename = filename
  end

  def read
    file = File.read(@filename)
    JSON.parse(file)
  end
end
