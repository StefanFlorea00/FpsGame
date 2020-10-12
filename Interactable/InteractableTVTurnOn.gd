extends Interactable

signal send_power(value)

export var powerBtn : NodePath
export var on_by_default = true
export var screen_opacity_on = 1
export var screen_opacity_off = 0
		

onready var powerBtn_node = get_node(powerBtn)

onready var on = on_by_default

func _ready():
	turn_tv_on(on)
	
	
func get_interaction_text():
	return "Open TV" if on else "Close Tv"
	
func interact():
	on = !on
	turn_tv_on(on)
	
func turn_tv_on(tv_on):
	if(tv_on):
		powerBtn_node.get_mesh().surface_get_material(0).set_emission(Color(1,0,0,1))
		emit_signal("send_power", !tv_on)
	else:
		powerBtn_node.get_mesh().surface_get_material(0).set_emission(Color(0,1,0,1))
		emit_signal("send_power", !tv_on)

