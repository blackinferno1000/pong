extends StaticBody2D

#fields
@export var SPEED = 750
@export_enum("Player 1", "Player 2") var player: int
var screen_size
var ball_pos : Vector2
var dist : int
var move_by : int
var p_height : int = 190

#functions
func _ready():
# 	get and adjust screen size
	screen_size = get_viewport_rect().size
	screen_size = Vector2(screen_size[0], screen_size[1] - 95)
	
func _physics_process(delta):
	#cpu logic
	ball_pos = $"../Ball".position
	dist = %"Player 2".position.y - ball_pos.y
	if(abs(dist) > SPEED * delta):
		move_by = (SPEED/4) * delta * (dist /abs(dist))
	else:
		move_by = dist * .5
		
#	player 1 movement
	if(player == 0):
		if(Input.is_action_pressed("p1_up")):
			position.y -= SPEED * delta
		if(Input.is_action_pressed("p1_down")):
			position.y += SPEED * delta
			
	#cpu movement
	%"Player 2".position.y -= move_by
	
#	player 2 movement
	if(player == 1):
		if(Input.is_action_pressed("p2_up")):
			position.y -= SPEED * delta
		if(Input.is_action_pressed("p2_down")):
			position.y += SPEED * delta
			
#	position clamp
	position = position.clamp(Vector2(0,95), screen_size)
