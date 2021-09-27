extends Node2D

onready var pattern_menu = get_node("PatternSystem")

var selected = "None"

var options_dict = {
	"CBADEFIHG" : 'You draw the letter "S"',
	"CBADGHI" : 'You draw the letter "C"',
}

func _ready():
	pattern_menu.set_choices(options_dict)

func _process(delta):
	if pattern_menu.last_response:
		selected = pattern_menu.last_response
	$Text.text = selected

func _on_Button_pressed():
	pattern_menu.open()
