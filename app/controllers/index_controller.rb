# require 'sinatra'
# require 'sinatra/content_for'
# require 'date'

def setup_index_view()
    # Perhaps I'm not doing something right...
    # I don't have a single line of duplicated code
    # in those in my get and post calls, so this is 
    # difficult to refactor.
end
def response_page(birth_date,first_name,last_name)
	@first_name = first_name ? first_name : "First"
	@last_name = last_name ? last_name : "Last"
    if valid_birthdate(@birth_date)
     	@birth_display = delimiters(@birth_date) ? DateTime.strptime(@birth_date, "%m/%d/%Y").strftime("%-m/%-d/%Y") : @birth_date
		@page_title = "Numerology App"
		@title = "Here are your Numerology results, #{@first_name}!"
		@subtitle = "Your (#{@first_name} #{@last_name}'s) birthday was entered as #{@birth_display}"
		@message = Person.get_birth_path_number(@birth_date)
		erb :index
    else
    	@countme = only_digits(birth_date.to_s).length
        @page_title = "Numerology App - Oops!"
        @title = @page_title
        @subtitle = "You can tell absolutely nothing about your life based on your birthdate alone, but for kicks we're going to pretend you can..."
        @error = "Please enter a valid birthday (mmddyyyy)! You should enter a valid birthdate in the form of mmddyyyy."
        erb :form
    end
end
def valid_birthdate(this_input)
    valid = true
#    delimiters = this_input.count("/") + this_input.count("-") + this_input.count(".")
#    if( delimiters < 2 || this_input.match(/[A-z]/)) #this_input.match(/[A-z]/)
    if( only_digits(this_input.to_s).length != 8)
        valid = false
    end
    return valid
end
def delimiters(input)
    return input.count("/") + input.count("-") + input.count(".") > 0 ? true : false
end
def only_digits(input)
    return input.scan(/\d+/).join('')
end
get '/' do
    @page_title = "Numerology App"
    @title = @page_title
    @first_name = ""
    @last_name = ""
    @subtitle = "You can tell absolutely nothing about your life based on your birthdate alone, but for kicks we're going to pretend you can..."
    erb :form
end
post '/' do
    first_name = params[:name_first]
    last_name = params[:name_last]
    birth_date = params[:birthdate].gsub("/", "-").to_s
    if valid_birthdate(birth_date)
        redirect "/message/#{@first_name}/#{@last_name}/#{birth_date}"
    else
    	response_page(@birth_date,@first_name,@last_name)
    end
end
get '/message/:name_first/:name_last/:birth_date' do
    @first_name = params[:name_first]
    @last_name = params[:name_last]
    @birth_date = params[:birth_date].gsub("-", "/").gsub(".", "/")
	response_page(@birth_date,@first_name,@last_name)
end
get '/:birth_date' do
    @first_name = "First"
    @last_name = "Last"
    @birth_date = params[:birth_date].gsub("-", "/").gsub(".", "/")
	response_page(@birth_date,@first_name,@last_name)
end
get '/message/:birth_date' do
    @first_name = "First"
    @last_name = "Last"
    @birth_date = params[:birth_date].gsub("-", "/").gsub(".", "/")
	response_page(@birth_date,@first_name,@last_name)
end