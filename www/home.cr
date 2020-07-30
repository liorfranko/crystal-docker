require "http/server"
puts "Started http server"

server = HTTP::Server.new do |context|
  context.response.content_type = "text/plain"
  
  context.response.print "HTTP Path: #{context.request.path}\n"
  context.response.print "HTTP Body: #{context.request.body}\n"
  context.response.print "Headers:\n"
  context.request.headers.each {|x| context.response.print "\n", context.response.print x[1][0], context.response.print ": ", context.response.print x[0], context.response.print "\t" }
end

address = server.bind_tcp "0.0.0.0", 8080
puts "Listening on http://#{address}"
server.listen
