class JsonReader(filename)
    def read
        file = File.read("eurofxref-hist-90d.json")
        JSON.parse(file)
    end
end
