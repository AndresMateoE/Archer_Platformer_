extends CharacterBody2D

var speed = 150
var arrow_gravity = 5
var bounces = 1
#var velocity = Vector2()
var vel = Vector2()
var last_velocity = Vector2()
var init_velocity = Vector2()


func _ready():
	set_as_top_level(true)   #quiero que siempre este arriba el sprite
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var player_position = get_parent().get_node("Player").global_position
	velocity.y += arrow_gravity
	
	vel.x = (position.x - ((Vector2.RIGHT).rotated(rotation)*speed).x * delta - player_position.x) /delta
	vel.y = (position.y - (((Vector2.RIGHT).rotated(rotation)*speed).y + velocity.y) * delta - player_position.y) /delta
	
	#init_velocity.x = ((Vector2.RIGHT).rotated(rotation)*speed).x
	#init_velocity.y = ((Vector2.RIGHT).rotated(rotation)*speed).y
	
	position.x += ((Vector2.RIGHT).rotated(rotation)*speed).x * delta
	position.y += (((Vector2.RIGHT).rotated(rotation)*speed).y + velocity.y) * delta
	
	var dir_vel = atan(vel.y/vel.x)
	$Sprite2D.global_rotation = dir_vel
	
	if not is_on_wall():
		last_velocity = vel
	
	if is_on_wall():
		print("exit")
		queue_free()
		
		# SEGUIR DE ACA EL REBOTE
		if bounces > 0:
			bounces += bounces-1
			velocity.x = -last_velocity.x 
			velocity.y = last_velocity.y
			print("bounce")
		elif bounces == 0:
			print("exit")
			queue_free()
	if is_on_floor():
		print("exit")
		queue_free()
	
	move_and_slide()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func arrow():
	pass
