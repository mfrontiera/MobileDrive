extends Node2D
var config = ConfigFile.new()
var loadConfig = config.load("user://settings.cfg")
signal ipSignal(ip)
signal ssSignal(value)
signal wsSignal(value)
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("ipSignal",config.get_value("Settings", "IP", "192.168.4.1:4410"))
	emit_signal("ssSignal",config.get_value("Settings", "SS", 0.5))
	emit_signal("wsSignal",config.get_value("Settings", "WS", 0.5))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
