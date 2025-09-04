extends Node2D

#fields
@onready var player_1 = %"Player 1"
@onready var player_2 = %"Player 2"
var ball_node = preload("res://scenes/objects/ball.tscn")
var label_node = preload("res://scenes/user_interface/label.tscn")
var ball
var screen_size
@export_enum("Active", "Score", "Game Over") var game_state: int
@export var p1_score:int = 0
@export var p2_score:int = 0
var p1_score_label
var p2_score_label
@export var speed:int = 300
var point


# Called when the node enters the scene tree for the first time.
func _ready():
#	instantiate ball at center
	ball = instance(ball_node,Vector2(575.0,312.0))
	p1_score_label = instance(label_node, Vector2(520.0,595.0))
	p1_score_label.text = str(p1_score)
	p2_score_label = instance(label_node, Vector2(590.0,595.0))
	p2_score_label.text = str(p2_score)
	print(ball)
	print(ball.position)
# 	get and adjust screen size
	screen_size = get_viewport_rect().size
	screen_size = Vector2(screen_size[0], screen_size[1] - 125)
#	get intial ball move position
	point = randf_range(screen_size[0],screen_size[1])
	print(point)

func instance(inst, pos: Vector2):
	var instance = inst.instantiate()
	add_child(instance)
	instance.position = pos
	return instance

#quits game
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#	move ball
	#ball.position = ball.position.move_toward(Vector2(point,screen_size[1]), speed * delta)
	pass
	
#	position clamp
	#ball.position = position.clamp(Vector2(0,125), screen_size)
	
