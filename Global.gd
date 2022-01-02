extends Node

var weapon_reloading = false

# creates a signal called 'crosshairs_target' which other scripts can detect
signal crosshairs_target(value)
signal reloading(value)

func _ready():
	pass # Replace with function body.

func set_crosshairs(value):
	# emits the signal to alert the HUD that it should update
	emit_signal("crosshairs_target", value)

func set_reloading(value):
	emit_signal("reloading", value)
