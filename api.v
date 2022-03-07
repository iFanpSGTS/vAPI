import vweb
import json
import attack
import os

struct App {
	vweb.Context
}

fn (mut app App) index() vweb.Result {
    return app.html("Welcome to vAPI")
}

fn (mut app App) api() vweb.Result {

	mut check_user := os.read_lines("/database/users.db") ?

	username := app.query["user"]
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

	for check in check_user {
		if check.split("")[0] == username {
			attack.send_attack(username, host, port, times, method)
		}
		else {
			return app.text(json.encode({"error": "Invalid Username!"}))
		}
	}
	output := json.encode(json_data)
	return app.text(output)
}

fn main() {
	mut port := os.args[1] or {
		panic("Failed to run vAPI!")
	}
	vweb.run(&App{}, port.int())
}