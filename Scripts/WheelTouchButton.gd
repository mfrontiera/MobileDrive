								## Main script for a wheel logistic ##
extends TouchScreenButton
var max = 0
signal wheel_touch_event(coordinates)
var button_index = -1;

func _ready():
	pass
	
func _process(delta):
	pass

#Touch handler
func _input(event):
	if not event is InputEventScreenTouch and not event is InputEventScreenDrag: # Not a touch
		return
	if is_pressed() and global_position.distance_to(event.position) < 270:
		emit_signal("wheel_touch_event", event.position)
		
