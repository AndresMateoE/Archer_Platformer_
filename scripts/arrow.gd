extends Area2D

var speed = 150
var arrow_gravity = 5
var velocity = Vector2()
var vel = Vector2()

#@onready var player_node = get_parent().get_node("Player")



func _ready():
	set_as_top_level(true)   #quiero que siempre este arriba el sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var player_position = get_parent().get_node("Player").global_position
	velocity.y += arrow_gravity
	
	vel.x = (position.x - ((Vector2.RIGHT).rotated(rotation)*speed).x * delta - player_position.x) /delta
	vel.y = (position.y - (((Vector2.RIGHT).rotated(rotation)*speed).y + velocity.y) * delta - player_position.y) /delta
	
	position.x += ((Vector2.RIGHT).rotated(rotation)*speed).x * delta
	position.y += (((Vector2.RIGHT).rotated(rotation)*speed).y + velocity.y) * delta
	
	var dir_vel = atan(vel.y/vel.x)
	var dir_p = atan(position.x/position.y)
	print(dir_vel)
	$Sprite2D.global_rotation = dir_vel 

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func arrow():
	pass
