require 'socket'

def parse(request) #parses request. If GET, return contents of file. Else, return nil.
	if request.match(/^GET/)
		filename = request.split[1]
			if File.exist? (filename)
				fetch(filename)
			else
				return "File not found"
			end
	else
		nil
	end
end

def fetch(filename) #fetches contents of file, if the file exists.
	file = File.open(filename, "r")
		fetched = file.read
		file.close
	fetched
end

code = "500 server error"
server = TCPServer.open(2000)
loop do
	client = server.accept #creates a new TCPSocket object
	p "opened"
	request_line = client.gets #get the request
	response = ["HTTP/1.0", code, "\r\n\r\n"]
	p "got request"
	action = parse(request_line)
		if action == "File not found"
			response[1] = "404 Not found"
			response << action
		elsif action
			response[1] = "200 OK"
			response << action
		end
		#if action
		#	p "GET"
		#	response << fetch(action)
		#	p response.join(' ')
		#end
	client.print(response.join(" "))
	client.close
	p "closed"
end

