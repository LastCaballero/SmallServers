


function standard_antwort( laenge){
  http_greeting = "HTTP/1.1 200 OK"
  server_info = "Server: Gawk-Webserver" 
  connection_info = "Connection: close"
  print http_greeting |& HttpServer
  print server_info |& HttpServer
  print connection_info |& HttpServer
}
