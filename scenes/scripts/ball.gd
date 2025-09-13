extends CharacterBody2D

#fields
var win_size : Vector2
const START_SPEED : int = 500
const ACCEL : int = 75
@export var speed : int
@export var dir : Vector2
const MAX_Y_VECTOR: float = 0.6
const CLAMP_HEIGHT: int = 95

# Called when the node enters the scene tree for the first time.
func _ready():
	win_size = get_viewport_rect().size
	
func new_ball():
	#random position
	position.x = win_size.x/2
	position.y = randi_range(CLAMP_HEIGHT,win_size.y - CLAMP_HEIGHT)
	#random direction and starting speed
	speed = START_SPEED
	dir = random_direction()
	
func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(1, 1)
	return new_dir.normalized()
	
func new_direction(collider):
	#get ball and colliding paddle distance
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir = Vector2()
	
	#reverse x direction
	if dir.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
		
	#get y direction
	new_dir.y = (dist/(collider.p_height / 2)) * MAX_Y_VECTOR
	
	return new_dir.normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		if collider == %"Player 1" or collider == %"Player 2":
			speed += ACCEL
			dir = new_direction(collider)
		else:
			dir = dir.bounce(collision.get_normal())
