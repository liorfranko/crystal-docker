require "http/server"
begin
    puts "Starting http server"
    ENV["LISTEN_ADDR"] ||= "0.0.0.0"
    ENV["LISTEN_PORT"] ||= "80"
    server = HTTP::Server.new([
      HTTP::ErrorHandler.new,
      HTTP::LogHandler.new
    ]) do |context|
      context.response.content_type = "text/plain"
      # puts "Request path is:"
      # pp context.request.path
      # puts "Request body is:"
      # pp context.request.body
      # puts "Request header are:"
      # pp context.request.headers
      context.response.print "HTTP Path: #{context.request.path}\n"
      context.response.print "HTTP Body: #{context.request.body}\n"
      context.response.print "Headers:\n"
      context.request.headers.each {|x| context.response.print "\n", context.response.print x[1][0], context.response.print ": ", context.response.print x[0], context.response.print "\t" }
      
    end

    address = server.bind_tcp ENV["LISTEN_ADDR"].to_s, ENV["LISTEN_PORT"].to_i
    puts "Listening on http://#{ENV["LISTEN_ADDR"].to_s}"
    server.listen
rescue ex
    puts "Error: #{ex.message}"
    puts "#{ex.backtrace}"
    exit 1
end