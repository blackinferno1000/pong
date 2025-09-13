extends Node2D

#fields
@onready var player_1 = %"Player 1"
@onready var player_2 = %"Player 2"
var label_node = preload("res://scenes/user_interface/label.tscn")
var screen_size
@export_enum("Active", "Pause", "Game Over") var game_state: int
@export var score:Array[int] = [0,0]
var p1_score_label
var p2_score_label
@export var speed:int = 300


# Called when the node enters the scene tree for the first time.
func _ready():
#	instantiate score
	p1_score_label = instance(label_node, Vector2(520.0,595.0))
	p2_score_label = instance(label_node, Vector2(590.0,595.0))

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
	p1_score_label.text = str(score[0])
	p2_score_label.text = str(score[1])

func _on_area_2d_area_entered(area):
	print("collided!")

func _on_timer_timeout():
	$Ball.new_ball()

func _on_p_1_goal_body_entered(body):
	score[1] += 1
	$Timer.start()

func _on_p_2_goal_body_entered(body):
	score[0] += 1
	$Timer.start()
