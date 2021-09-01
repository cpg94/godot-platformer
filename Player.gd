extends KinematicBody2D

var velocity = Vector2(0, 0)
var coins = 0

const SPEED = 220
const GRAVITY = 40
const JUMP_FORCE = -1000
func _physics_process(_delta):
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("down"):
		$Sprite.play("crouch")
	else:
		$Sprite.play("idle")
		
	
	if not is_on_floor():
		$Sprite.play('air')

	velocity.y = velocity.y+GRAVITY
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE

	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.4)


func _on_FallZone_body_entered(body):
	SceneManager.change_scene("res://Level1.tscn")


func _on_NextLevel_body_entered(body):
	SceneManager.change_scene("res://Level1.tscn")
	
func bounce():
	velocity.y = JUMP_FORCE * 0.5

func hurt(var position_x):
	set_modulate(Color(1, 0, 0, 0.4))
	Input.action_release("left")
	Input.action_release("right")
	print("_______")
	print("PLAYER POS X = ", position.x)
	print("ENEMY POS X = ", position_x)
	print("_______")
	velocity.y = JUMP_FORCE * 0.25
	if position.x < position_x:
		velocity.x = -800
	elif position.x > position_x:
		velocity.x = 800
	
	$Timer.start()


func _on_Timer_timeout():
	SceneManager.reset()
