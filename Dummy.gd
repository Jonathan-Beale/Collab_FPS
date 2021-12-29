extends KinematicBody


export var health = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_hit(damage):
	health -= damage
	if health <= 0:
		queue_free()
