extends Sprite2D

var origin_rotation_value
var t = 0.0
var is_used = 0
var last_position
signal deegres(degreesValue)
var comebackSpeed

func _ready():
	origin_rotation_value = rotation_degrees - 90
	rotation_degrees = origin_rotation_value
func _process(delta):
	# Update of RotationLabel
	emit_signal("deegres",int(remap(rotation_degrees,-495,315,0,180)))
	#Return of wheel to an origin value
	if !is_used:
		t += delta * comebackSpeed
		rotation_degrees = lerp(rotation_degrees, origin_rotation_value, t) 
		


#Main logic coordinates
func _on_wheel_touch_button_wheel_touch_event(coordinates):
	look_at(coordinates)	
	rotation_degrees = clamp(rotation_degrees,-495,315)
	is_used = 1
	t = 0.0
#End of touch signal
func _on_wheel_touch_button_released():
	is_used = 0

func _on_main_ws_signal(value):
	comebackSpeed = value

	pass # Replace with function body.
