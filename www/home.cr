require "http/server"
begin
    puts "Starting http server"
    ENV["LISTEN_ADDR"] ||= "127.0.0.1"
    ENV["LISTEN_PORT"] ||= "8080"
    server = HTTP::Server.new([
      HTTP::ErrorHandler.new,
      HTTP::LogHandler.new
    ]) do |context|
      context.response.content_type = "text/plain"
      context.response.print "HTTP Path: #{context.request.path}\n"
      context.response.print "HTTP Body: #{context.request.body}\n"
      context.response.print "Headers:\n"
      context.request.headers.each {|x| context.response.print "\n", context.response.print x[1][0], context.response.print ": ", context.response.print x[0], context.response.print "\t" }
    end

    address = server.bind_tcp ENV["LISTEN_ADDR"].to_s, ENV["LISTEN_PORT"].to_i
    server.listen
    puts "Listening on http://#{ENV["LISTEN_ADDR"].to_s}"
rescue ex
    puts "Error: #{ex.message}"
    puts "#{ex.backtrace}"
    exit 1
end