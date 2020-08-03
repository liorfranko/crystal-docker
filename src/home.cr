require "http/server"
require "json"
ENV["LISTEN_ADDR"] ||= "0.0.0.0"
ENV["LISTEN_PORT"] ||= "80"

begin
    puts "Starting http server"
    server = HTTP::Server.new([
      HTTP::ErrorHandler.new,
      HTTP::LogHandler.new
    ]) do |context|
      context.response.content_type = "text/plain"
      case context.request.path
      when "/health"
        context.response.print "ok"
      when "/json"
        context.response.content_type = "application/json"
        string = JSON.build do |json|
          json.object do
            json.field "path", "#{context.request.path}"
            json.field "body", "#{context.request.body}"
            json.field "headers", context.request.headers
          end
        end
        context.response.print string
      else
        context.response.print "HTTP Path: #{context.request.path}\n"
        context.response.print "HTTP Body: #{context.request.body}\n"
        context.response.print "Headers:\n"
        context.request.headers.each do |header|
          context.response.print "\t"
          context.response.print header[0]
          context.response.print ": "
          header[1].each do |h|
            context.response.print h
          end
          context.response.print "\n"
        end
      end
    end

    address = server.bind_tcp ENV["LISTEN_ADDR"].to_s, ENV["LISTEN_PORT"].to_i
    puts "Listening on http://#{ENV["LISTEN_ADDR"].to_s}"
    server.listen
rescue ex
    puts "Error: #{ex.message}"
    puts "#{ex.backtrace}"
    exit 1
end