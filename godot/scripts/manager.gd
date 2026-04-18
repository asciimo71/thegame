extends Node

@onready var coin_score_label = $CoinScoreLabel
var coins = 0

func add_coin():
	coins += 1
	coin_score_label.text = "Coins:" + str(coins)
	
func get_score():
	return coins
	