module discord

import json
import net.http

pub fn send_attack_logs(username string, host string, port string, time string, method string) {
	mut url := "https://discord.com/api/webhooks/950245555911659570/sP2LPKFZaUsWthtnCstUcr67WHhSZJyGY7dJEJPP1mNU3oBfc2-Shf1NUTg1in-6L9Ot"
	data := {
		"content": "**New Attack Logs**\n```\nUsername: $username\nHost: $host\nPort: $port\nDuration: $time\nMethod: $method```",
		"username": "vAPI Logs"
	}
	payload := json.encode(data)
	http.post_json(url, payload) or {
		panic("Failed to send webhook logs!")
	}
}