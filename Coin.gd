extends Area2D


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "bounce":
		queue_free()

func _ready():
	connect("body_entered", self, "_on_Item_body_entered")


func _on_Item_body_entered(_body):
	call_deferred("disconnect", "body_entered", self, "_on_Item_body_entered")
	$AnimationPlayer.play("bounce")
	Inventory.coin_collected()

