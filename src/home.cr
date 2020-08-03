require "http/server"
require "json"
# require "hash"

begin
    puts "Starting http server"
    ENV["LISTEN_ADDR"] ||= "0.0.0.0"
    ENV["LISTEN_PORT"] ||= "80"
    server = HTTP::Server.new([
      HTTP::ErrorHandler.new,
      HTTP::LogHandler.new
    ]) do |context|
      context.response.content_type = "text/plain"
      case context.request.path
      when "/health"
        context.response.print "ok"
      when "/json"
        string = JSON.build do |json|
          json.object do
            json.field "path", "#{context.request.path}"
            json.field "body", "#{context.request.body}"
            json.field "headers", context.request.headers
          end
        end
        context.response.print string
        hash = Hash(String, Hash(String, String)).new
        hash["headers"] = {"test" => "sjdhs"}
        # context.response.print context.request.headers.to_json
        context.request.headers.each do |header|
          # string.test="dasd"
          # hash["headers"] = {header[0] => header[1][0]}
          header[1].each do |h|
            hash["headers"] = {header[0] => h}
          end
          # context.response.print header[0]
          # context.response.print header[1]
        end
        # context.response.print "################"
        # context.response.print hash.to_json
        # context.response.print "################"
        # context.response.print context.request.headers.to_json
      else
        puts "Request path is: #{context.request.path}"
        puts "Request body is: #{context.request.body}"
        puts "Request header are: #{context.request.headers.to_pretty_json}"
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
        # {|x| context.response.print "\n", context.response.print x[1][0], context.response.print ": ", context.response.print x[0], context.response.print "\t" }
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