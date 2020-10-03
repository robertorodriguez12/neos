require_relative 'near_earth_objects'

def welcome_message
  puts "________________________________________________________________________________________________________________________________"
  puts "Welcome to NEO. Here you will find information about how many meteors, astroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
  puts "Please enter a date in the following format YYYY-MM-DD."
  print ">>"
end

def astroid_details
  NearEarthObjects.find_neos_by_date(@date)
end

def astroid_list
  astroid_details[:astroid_list]
end

def total_number_of_astroids
  astroid_details[:total_number_of_astroids]
end

def largest_astroid
  astroid_details[:biggest_astroid]
end

def print_data
  formated_date = DateTime.parse(@date).strftime("%A %b %d, %Y")
  puts "______________________________________________________________________________"
  puts "On #{formated_date}, there were #{total_number_of_astroids} objects that almost collided with the earth."
  puts "The largest of these was #{largest_astroid} ft. in diameter."
  puts "\nHere is a list of objects with details:"
  puts divider
  puts header
  create_rows(astroid_list, column_data)
  puts divider
end

def header
  "| #{ column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
end

def divider
  "+-#{column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"
end

def column_labels
  { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
end

def column_data
  column_labels.each_with_object({}) do |(col, label), hash|
    hash[col] = {
      label: label,
      width: [astroid_list.map { |astroid| astroid[col].size }.max, label.size].max}
  end
end

def format_row_data(row_data, column_info)
  row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
  puts "| #{row} |"
end

def create_rows(astroid_data, column_info)
  astroid_data.each { |astroid| format_row_data(astroid, column_info) }
end

welcome_message    # displays welcome message
@date = gets.chomp # obtains user input
print_data         # prints_data neatly
