extends TouchScreenButton
var was_pressed = 0
signal press_state(pressState)
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("press_state",1)
	texture_normal = preload("res://Textures/Gui/Misc/reverseButtonPressed.png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func _on_pressed():
	if !was_pressed:
		was_pressed = 1
		texture_normal = preload("res://Textures/Gui/Misc/reverseButtonPressed.png")
		emit_signal("press_state",-1)
	else: 
		was_pressed = 0
		texture_normal = preload("res://Textures/Gui/Misc/reverseButton.png")
		emit_signal("press_state",1)
	pass # Replace with function body.
