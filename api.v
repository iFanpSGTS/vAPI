import vweb
import os
import json
import attack

struct App {
	vweb.Context
}

fn (mut app App) index() vweb.Result {
    return app.html("Welcome to vAPI")
}

fn (mut app App) api() vweb.Result {

	username := app.query["username"]
	//key := app.query["key"]
	host := app.query["host"]
	port := app.query["port"]
    times := app.query["times"]
	method := app.query["method"]

	json_data := {
		'host': '$host',
		'port': '$port',
		'times': '$times',
		'method': '$method'
	}
	output := json.encode(json_data)
	attack.send_attack(username, host, port, times, method)
	return app.text(output)
}

fn main() {
	mut port := os.args[1] or {
		panic("Failed to run vAPI!")
	}
	vweb.run(&App{}, port.int())
}