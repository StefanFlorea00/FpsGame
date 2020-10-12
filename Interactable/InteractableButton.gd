extends Interactable

signal send_button_set(value)

export var btn : NodePath

onready var btn_node = get_node(btn)

func _ready():
	pass
	
	
func get_interaction_text():
	return "Press"
	
func interact():
	emit_signal("send_button_set", true)

	
