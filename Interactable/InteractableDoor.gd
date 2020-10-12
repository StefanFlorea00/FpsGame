extends Interactable

export var door : NodePath
export var open_by_default = true
export var rotation_closed = 90
export var rotation_open = 0

onready var door_node = get_node(door)
onready var open = open_by_default

func _ready():
	set_door_rotation()
	
func get_interaction_text():
	return "Close door" if open else "Open door"
	
func interact():
	open = !open
	set_door_rotation()
	
func set_door_rotation():
	door_node.set_rotation(Vector3(0, rotation_open if open else rotation_closed, 0))
	
