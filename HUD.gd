extends Control

onready var cross_hairs = $CrossHairs

func change_sights(value):
	if value == "enemy":
		cross_hairs.add_color_override("font_color", Color(255,0,0,255))
	else:
		cross_hairs.add_color_override("font_color", Color(255,255,255,255))

func _ready():
	# basically says 'when Global emits signal x, I will run function y'
	Global.connect("crosshairs_target", self, "change_sights")

