extends Node
	
func on_coin_collected():
	print("COIN COLLECTED ", Inventory._coins)
	if Inventory._coins == 3:
		change_scene("res://Level1.tscn")

func change_scene(scene):
	Inventory.reset()
	get_tree().change_scene(scene)
	
func reset():
	change_scene("res://Level1.tscn")
	
func change_level(level):
	change_scene("res://Level" + level + ".tscn")
