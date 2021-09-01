extends KinematicBody2D

var velocity = Vector2(0, 0)
export var direction = -1
export var speed = 50
export var detects_cliffs = true
export var enemy_name = "OK"
func _ready():
	$FloorChecker.enabled = detects_cliffs
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	if detects_cliffs:
		set_modulate(Color(0, 1, 0))
	
	
func _physics_process(delta):
	if is_on_wall() or not $FloorChecker.is_colliding() and detects_cliffs and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	velocity.y += 20
	
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)


func on_top_entered(body):
	speed = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$TopCheck.set_collision_layer_bit(4, false)
	$TopCheck.set_collision_mask_bit(0, false)
	$RightCheck.set_collision_layer_bit(4, false)
	$RightCheck.set_collision_mask_bit(0, false)
	$LeftCheck.set_collision_layer_bit(4, false)
	$LeftCheck.set_collision_mask_bit(0, false)
	$AnimatedSprite.play("squashed")
	$Timer.start()
	body.bounce()


func _on_side_body_entered(body):
	body.hurt(position.x)


func _on_Timer_timeout():
	queue_free()


func _on_RightCheck_body_entered(body):
	body.hurt(position.x)


func _on_BottomChecker_body_entered(body):
	velocity.y = -200
	body.hurt(position.x)
