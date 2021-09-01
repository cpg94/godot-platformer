extends CanvasLayer


func set_coins_hud():
	$Coins.text = str(Inventory.get_coins())

func _ready():
	set_coins_hud()
	Inventory.add_signal(self)


func on_coin_collected():
	set_coins_hud()
