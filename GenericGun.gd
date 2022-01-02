extends Spatial

class_name Weapon

export var reload_time = 1.0
export var fire_delay = .1
export var clip_size = 6
export var ammo = 30
export var damage = 10

var can_fire = true
var current_clip = clip_size

onready var gun_flash = $SpotLight
onready var aim_cast = $AimCast

signal reloading(value)

func _ready():
	emit_signal("reloading", false)

func fire():
	if can_fire and current_clip >= 0:
		check_shot()
		muzzle_flash()
		current_clip -= 1
		if current_clip == 0:
			reload()
		else:
			delay_fire()
		

func check_shot():
	if aim_cast.is_colliding():
		var target = aim_cast.get_collider()
		if target.is_in_group("Enemy"):
			target.get_hit(damage)
		
	
func reload():
	emit_signal("reloading", true)
	can_fire = false
	if is_instance_valid(self):
		yield(get_tree().create_timer(reload_time), "timeout")
	if ammo > 0:
		ammo -= clip_size
		current_clip = clip_size
	can_fire = true
	emit_signal("reloading", false)
	
func delay_fire():
	can_fire = false
	if is_instance_valid(self):
		yield(get_tree().create_timer(fire_delay), "timeout")
	can_fire = true
	
func muzzle_flash():
	gun_flash.visible = true
	if is_instance_valid(self):
		yield(get_tree().create_timer(0.05), "timeout")
	gun_flash.visible = false
