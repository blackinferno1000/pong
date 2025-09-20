extends Node2D


#fields
var label_node = preload("res://scenes/user_interface/label.tscn")
@export var score:Array[int] = [0,0]
@export var goal = 5
var p1_score_label
var p2_score_label



# Called when the node enters the scene tree for the first time.
func _ready():
	#instantiate score
	p1_score_label = instance(label_node, Vector2(520.0,595.0))
	p2_score_label = instance(label_node, Vector2(590.0,595.0))
	
	#get and connect menu buttons
	var mainStart = get_node("Main Menu/HBoxContainer/Start")
	mainStart.pressed.connect(on_start)
	var mainQuit = get_node("Main Menu/HBoxContainer/Quit")
	mainQuit.pressed.connect(on_quit)
	var toggle = get_node("Main Menu/HBoxContainer/Toggle")
	toggle.pressed.connect(on_toggle)
	var pauseRestart = get_node("Pause Menu/HBoxContainer/Restart")
	pauseRestart.pressed.connect(on_restart)
	var pauseQuit = get_node("Pause Menu/HBoxContainer/Quit")
	pauseQuit.pressed.connect(on_quit)

#start button handler
func on_start():
	get_tree().paused = false
	get_node("Main Menu").visible = not get_node("Main Menu").visible
	$Ball.new_ball()

#quit button handler
func on_quit():
	get_tree().quit()

#cpu vs. player select
func on_toggle():
	get_node("%Player 2").cpu = not get_node("%Player 2").cpu

#restart button handler
func on_restart():
	score = [0,0]
	get_node("Win Text").visible = false
	get_node("Pause Menu").visible = not get_node("Pause Menu").visible
	get_node("Main Menu").visible = not get_node("Main Menu").visible

#instantiating helper function
func instance(inst, pos: Vector2):
	var instanced = inst.instantiate()
	add_child(instanced)
	instanced.position = pos
	return instanced

#pauses game and opens pause menu
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = not get_tree().paused
		get_node("Pause Menu").visible = not get_node("Pause Menu").visible
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	#update score
	p1_score_label.text = str(score[0])
	p2_score_label.text = str(score[1])

#timer handler
func _on_timer_timeout():
	$Ball.new_ball()

#handles when player 2 scores
func _on_p_1_goal_body_entered(_body):
	score[1] += 1
	if(score[1] == goal):
		get_node("Win Text").text = "PLAYER 2 WON!!!"
		get_node("Win Text").visible = true
		get_node("Pause Menu").visible = true
	else:
		$Timer.start()

#handles when player 1 scores
func _on_p_2_goal_body_entered(_body):
	score[0] += 1
	if(score[0] == goal):
		get_node("Win Text").text = "PLAYER 1 WON!!!"
		get_node("Win Text").visible = true
		get_node("Pause Menu").visible = true
	else:
		$Timer.start()
