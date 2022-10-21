extends Control

onready var coins_label: Label = $VSplitContainer/coins_label

func _on_coin_collected(coin_count: int) -> void:
	coins_label.text = "Coins: %s" % coin_count
