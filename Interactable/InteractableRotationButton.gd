extends Interactable

signal send_button_rotation(value)

export var btn : NodePath

onready var btn_node = get_node(btn)
var value = 0

func _ready():
	pass
	
	
func get_interaction_text():
	return "Press"
	
func interact():
	value += 1
	if(value==10):
		btn_node.rotate_object_local(Vector3(0,1,0), -4.5)
		value = 0
	#btn_node.set_rotation(Vector3(btn_node.get_rotation().x, value, btn_node.get_rotation().z))
	#btn_node.set_rotation(Vector3(btn_node.get_rotation().x, btn_node.get_rotation().y, value))
	btn_node.rotate_object_local(Vector3(0,1,0), value/10.0)
	print(btn_node.get_rotation())
	emit_signal("send_button_rotation", value)

	
