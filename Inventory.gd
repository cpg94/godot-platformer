extends Node

var _coins = 0
var listeners = []

func add_signal(listener: Node):
	listeners.push_front(listener)

func reset():
	_coins = 0
	listeners = []

func set_coins(amount):
	_coins += amount
	
func get_coins():
	return _coins
	
func coin_collected():
	set_coins(1)
	for item in listeners:
		item.on_coin_collected()
	if _coins == 3:
		SceneManager.change_scene("res://Level1.tscn")
