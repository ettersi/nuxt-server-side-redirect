using HTTP
using Sockets

function serve()
    println("http://127.0.0.1:8888/huey")
    HTTP.serve(ip"127.0.0.1", 8888) do request::HTTP.Request
        if request.target == "/huey"
            return HTTP.Response(
                301,
                ["Location" => "/dewey"],
                "Redirecting",
            )
        end
        filename = ".output/public" * request.target
        if isdir(filename)
            filename = joinpath(filename, "index.html")
        end
        if isfile(filename)
            return HTTP.Response(
                200,
                [
                    "Content-Type" =>
                        if splitext(filename)[2] == ".html"
                            "text/html"
                        elseif splitext(filename)[2] == ".css"
                            "text/css"
                        elseif splitext(filename)[2] == ".js"
                            "text/javascript"
                        else
                            "text/plain"
                        end
                ],
                read(filename),
            )
        end
        return HTTP.Response(404, "Not found")
    end
end

if !isinteractive()
    serve()
end