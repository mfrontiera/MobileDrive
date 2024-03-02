extends Node

var _ip = "0"
var _port = 0
var ipAndPort = 0;
var steering = 90
var speed = 0
var speed_direction = 0
var _id = "AA"
var udp := PacketPeerUDP.new()

func _ready():
	pass
	

func _process(delta):
	_handle_udp()
	
	
func _on_main_ip_signal(ip):
	ipAndPort = ip.split(":")
	_ip = ipAndPort[0]
	_port = int(ipAndPort[1])

func _on_wheel_texture_deegres(degreesValue):
	steering = degreesValue 


func _on_shifter_touch_button_speed_value(speed_value):
	speed = speed_value


func _on_reverse_button_press_state(pressState):
	speed_direction = pressState

func _handle_udp():
	if !udp.get_packet().get_string_from_utf8().is_empty():
		udp.put_packet(str(_id,"#",speed*speed_direction,";",steering).to_utf8_buffer())
		$ConnectionStatus.texture = preload("res://Textures/Gui/Misc/Connection.png")
	else:
		udp.connect_to_host(_ip, _port)
		udp.put_packet(_id.to_ascii_buffer())
		$ConnectionStatus.texture = preload("res://Textures/Gui/Misc/NoConnection.png")
		
func _on_main_id_signal(id):
	_id = id

