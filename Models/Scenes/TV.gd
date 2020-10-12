extends Spatial

export var TV : NodePath

onready var tv_node = get_node(TV)
var tv_on = false;

func _ready():
	turn_tv_on()
	
func turn_tv_on():
	tv_node.get_mesh().surface_get_material(1).set_emission(Color(1,1,1,1) if tv_on else Color(0,0,0,0))

func _on_PowerButton_send_power(value):
	tv_on = value;
	if(tv_node):
		turn_tv_on()
	print(tv_on)


func _on_Set1Button_send_button_set(value):
	if(tv_on):
		tv_node.get_mesh().surface_get_material(1).set_emission(Color(1,0,0,1))


func _on_Set2Button_send_button_set(value):
	if(tv_on):
		tv_node.get_mesh().surface_get_material(1).set_emission(Color(0,1,0,1))


func _on_Set3Button_send_button_set(value):
	if(tv_on):
		tv_node.get_mesh().surface_get_material(1).set_emission(Color(0,0,1,1))


func _on_RotationBtn_send_button_rotation(value):
	if(tv_on):
		print(value)
		tv_node.get_mesh().surface_get_material(1).set_emission_energy(float(value)/10.0)
