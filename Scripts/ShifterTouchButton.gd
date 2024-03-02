									## SHIFTER MAIN LOGIC ##
extends TouchScreenButton

var button_index = -1
var follow_movment_speed = 0.5
var comeback_movment_speed
var start_position
signal speed_value(speed_value)

func _ready():
	start_position = global_position
func _process(delta):
	# Pass "speed value" to other nodes
	emit_signal("speed_value",int(global_position.distance_to(start_position)))
	# Return to start position after release
	if !is_pressed() and global_position.y != start_position.y:
		global_position.y = lerp(global_position.y,start_position.y,comeback_movment_speed*delta)

func _input(event):
	if not event is InputEventScreenTouch and not event is InputEventScreenDrag:
		return
	if is_pressed() and global_position.distance_to(event.position) < 400:
		# Follow input
		global_position.y = lerp(global_position.y,event.position.y,follow_movment_speed)
		# Limit movment
		global_position.y = clamp(global_position.y,start_position.y-256,start_position.y)
		

func _on_main_ss_signal(value):
	comeback_movment_speed = value
	pass # Handle config values


