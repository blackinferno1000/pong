extends CharacterBody2D

#fields
@export var SPEED = 350
@export_enum("Player 1", "Player 2") var player: int
var screen_size

#functions
func _ready():
# 	get and adjust screen size
	screen_size = get_viewport_rect().size
	screen_size = Vector2(screen_size[0], screen_size[1] - 125)
	#print(screen_size)
	
func _physics_process(delta):
#	player 1 movement
	if(player == 0):
		if(Input.is_action_pressed("p1_up")):
			position.y -= SPEED * delta
		if(Input.is_action_pressed("p1_down")):
			position.y += SPEED * delta
	
#	player 2 movement
	if(player == 1):
		if(Input.is_action_pressed("p2_up")):
			position.y -= SPEED * delta
		if(Input.is_action_pressed("p2_down")):
			position.y += SPEED * delta
#	position clamp
	position = position.clamp(Vector2(0,125), screen_size)
