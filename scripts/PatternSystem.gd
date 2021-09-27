extends Control


export(String) var default_message = "Draw the Pattern."
export(String) var default_sucess_message = "Sucess!"
export(String) var default_fail_message = "Pattern dont Find."
export (Dictionary) var choices = {"AB":"work!"}
export(String) var last_response = null


onready var dots = {
	'dot1' : {
		'dot' : $PatternArea/GridContainer/dot1,
		'value': 'A',
		'selected': false
	},
	'dot2' : {
		'dot' : $PatternArea/GridContainer/dot2,
		'value': 'B',
		'selected': false
	},
	'dot3' :{
		'dot' : $PatternArea/GridContainer/dot3,
		'value': 'C',
		'selected': false
	},
	'dot4' : {
		'dot' : $PatternArea/GridContainer/dot4,
		'value': 'D',
		'selected': false
	},
	'dot5' : {
		'dot' : $PatternArea/GridContainer/dot5,
		'value': 'E',
		'selected': false
	},
	'dot6' : {
		'dot' : $PatternArea/GridContainer/dot6,
		'value': 'F',
		'selected': false
	},
	'dot7' : {
		'dot' : $PatternArea/GridContainer/dot7,
		'value': 'G',
		'selected': false
	},
	'dot8' : {
		'dot' : $PatternArea/GridContainer/dot8,
		'value': 'H',
		'selected': false
	},
	'dot9' : {
		'dot' : $PatternArea/GridContainer/dot9,
		'value': 'I',
		'selected': false
	},
}

onready var active = false


var selections = []

var pressed = false


func _process(_delta):
	if len(selections) >= 2:
		for i in range(len(selections)-1):
			if i < len(selections):
				var name1 = selections[i]['value']
				var name2 = selections[i+1]['value']
				var list_name = [name1, name2]
				list_name.sort()
				var line_patch = "Lines/"+list_name[0]+list_name[1]
				var line = get_node(line_patch)
				if line:
					line.visible = true
					
func open():
	visible = true
	$Message.text = default_message
	active = true
	
func close():
	active = false
	visible = false
	
func set_choices(dict):
	choices = dict
	
func select_dot(dot):
	if pressed and not dot['selected']:
		selections.append(dot)
		dot['dot'].modulate = Color(0.68, 0.85, 0.9, 1)
		dot['selected'] = true
	
func reset_dots():
	for dot in dots:
		dots[dot]['selected'] = false
		dots[dot]['dot'].modulate = Color(1, 1, 1, 1)
	selections = []
	for line in $Lines.get_children():
		line.default_color = Color(1, 1, 1, 1)
		line.visible = false
	$Message.text = default_message
	$Message.modulate = Color(1, 1, 1, 1)
		
func check_result(result):
	var color = null
	var response = null
	if result in choices:
		response = choices[result]
		$Message.text = default_sucess_message
		color = Color( 0.56, 0.93, 0.56, 1)
	else:
		$Message.text = default_fail_message
		color = Color(0.94, 0.5, 0.5, 1 )
	$Message.modulate = color
	for dot in dots:
		dots[dot]['dot'].modulate = color
	for line in $Lines.get_children():
		line.default_color = color
	
	return response
		
func calculate_result(selecteds):
	var result = ''
	for dot in selecteds:
		result+=dot['value']
	
	last_response = check_result(result)
	
	
func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if active:
		if event is InputEventScreenTouch and event.pressed == true:
			pressed = true
			
		if event is InputEventScreenTouch and event.pressed == false:
			pressed = false
			active = false
			calculate_result(selections)
			yield(get_tree().create_timer(1), "timeout")
			reset_dots()
			close()


func _on_dot1_mouse_entered():
	var dot = dots['dot1']
	select_dot(dot)


func _on_dot2_mouse_entered():
	var dot = dots['dot2']
	select_dot(dot)


func _on_dot3_mouse_entered():
	var dot = dots['dot3']
	select_dot(dot)


func _on_dot4_mouse_entered():
	var dot = dots['dot4']
	select_dot(dot)


func _on_dot5_mouse_entered():
	var dot = dots['dot5']
	select_dot(dot)


func _on_dot6_mouse_entered():
	var dot = dots['dot6']
	select_dot(dot)


func _on_dot7_mouse_entered():
	var dot = dots['dot7']
	select_dot(dot)


func _on_dot8_mouse_entered():
	var dot = dots['dot8']
	select_dot(dot)


func _on_dot9_mouse_entered():
	var dot = dots['dot9']
	select_dot(dot)


func _on_TextureButton_pressed():
	close()
