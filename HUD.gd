extends Control

onready var cross_hairs = $CrossHairs
onready var reload_tag = $Reloading

func change_sights(value):
	if value == "enemy":
		cross_hairs.add_color_override("font_color", Color(255,0,0,255))
	else:
		cross_hairs.add_color_override("font_color", Color(255,255,255,255))

func update_reload(value):
	if value == true:
		reload_tag.text = "Reloading..."
	else:
		reload_tag.text = ""

func _ready():
	# basically says 'when Global emits signal x, I will run function y'
	Global.connect("crosshairs_target", self, "change_sights")
	Global.connect("reloading", self, "update_reload")
	reload_tag.text = "Ready"
