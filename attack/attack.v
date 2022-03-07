module attack

import discord

pub fn send_attack(username string, host string, port string, times string, method string) {
	discord.send_attack_logs(username, host, port, times, method)
}