extends Label
var direction = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "0"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_shifter_touch_button_speed_value(value):
	text = str(direction*value)


func _on_reverse_button_press_state(pressState):
	direction = pressState
	pass # Replace with function body.
