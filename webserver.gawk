#!/usr/bin/gawk -f

BEGIN{
	httphome="http"
	Port = 8080
	RS = ORS = "\r\n"
	Webserver = "/inet/tcp/" Port "/0/0"
	grundgeruest_einlesen()
	while ( 1 ) {
		Webserver |& getline zeile1
		split(zeile1, einzeln, " ")
		angefragte_adresse = einzeln[2]
		if (angefragte_adresse == "/")
			startseite()
		else
			locale_webseite_einlesen(angefragte_adresse)
		send_website()
	}
}

function send_website(){
	Status = 200    
   	StatusWort = "OK"
   	len = length(WEBSEITE) + length(ORS)
   	
	print "HTTP/1.1", Status, StatusWort   	|& Webserver
	print "Connection: Close"              	|& Webserver
   	print "Pragma: no-cache"               	|& Webserver
   	print "Content-length:", len           	|& Webserver
   	print ORS WEBSEITE						|& Webserver
	close(Webserver)
}

function startseite(){
	"cd "httphome";ls -1" | getline verzeichnis
	split(verzeichnis, ar, "\n")
	
	zusammengesetzt = ""
	for ( i = 1 ; i <= length(ar) ; i++ )
		zusammengesetzt += "<a href=\"" ar[i] "\">" ar[i] "</a>"
		
	style = "<style>" "a{display: block; border-radius: 4px}" "</style>"
	zusammengesetzt = "<div style=\"display: grid;grid-template-columns: repeat(3, 33%);grid-gap: 10px\">" \
						zusammengesetzt "</div>"
	zusammengesetzt = "<div style=\"display: flex;justify-content: center\">" \
						zusammengesetzt "</div>"
	WEBSEITE = oben title style head_abschluss body_oben zusammengesetzt body_unten
}

function grundgeruest_einlesen(){
	oben = "<!DOCTYPE html><html lang=\"en\"><head>" \
    			"<meta charset=\"UTF-8\">" \
    			"<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
   	title = "<title>Startseite</title>"
   	head_abschluss = "</head>"
    body_oben = "<body style=\"margin: 45px;font-family:sans\">"
   	body_unten = "</body></html>"
}

function locale_webseite_einlesen(adresse){
	cat_command = "cat "httphome adresse
	cat_command | getline WEBSEITE
	close(cat_command)
}








