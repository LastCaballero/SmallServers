


function standard_antwort( laenge){
  http_greeting = "HTTP/1.1 200 OK"
  server_info = "Server: Gawk-Webserver" 
  connection_info = "Connection: close"
  content_length = "Content-length: "laenge
  print http_greeting |& HttpServer
  print server_info |& HttpServer
  print  |& HttpServer
}
