extends Node2D
var config = ConfigFile.new()
var loadConfig = config.load("user://settings.cfg")
@onready var SS = $ShifterSlider
@onready var WS = $WheelSlider
@onready var Ip = $IpEnter
@onready var SL = $ShifterLabel
@onready var WL = $WheelLabel
@onready var ID = $IdEnter
# Called when the node enters the scene tree for the first time.
func _ready():
	SS.value = config.get_value("Settings","SS", 0.5)
	WS.value = config.get_value("Settings", "WS", 0.5)
	ID.text = config.get_value("Settings", "ID", "AA")
	Ip.text = config.get_value("Settings", "IP", "192.168.4.1")
	SL.text = str("Gas pedal comeback speed: ", SS.value)
	WL.text = str("Wheel comeback speed: ", WS.value)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func _on_return_button_pressed():
	config.save("user://settings.cfg")
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	pass # Replace with function body.


func _on_ip_enter_text_submitted(new_text):
	config.set_value("Settings","IP",str(new_text))
	pass # Replace with function body.


func _on_shifter_slider_drag_ended(value_changed):
	config.set_value("Settings","SS",SS.value)
	pass # Replace with function body.


func _on_wheel_slider_drag_ended(value_changed):
	config.set_value("Settings","WS",WS.value)
	pass # Replace with function body.


func _on_shifter_slider_value_changed(value):
	SL.text = str("Gas pedal comeback speed: ",value)
	pass # Replace with function body.


func _on_wheel_slider_value_changed(value):
	WL.text = str("Wheel comeback speed: ",value)
	pass # Replace with function body.


func _on_id_enter_text_submitted(new_text):
	config.set_value("Settings","ID",str(new_text)) 
	pass # Replace with function body.
