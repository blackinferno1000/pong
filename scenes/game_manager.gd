extends Node2D

#fields
@onready var player_1 = %"Player 1"
@onready var player_2 = %"Player 2"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#quits game
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
