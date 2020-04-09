extends Control

var tree = []
var current_item = 0

onready var dialogue_name: Label = $MarginContainer/HBoxContainer/VBoxContainer/MarginContainer/Label
onready var dialogue_body: Label = $MarginContainer/HBoxContainer/VBoxContainer2/Label2
onready var dialogue_next: Label = $MarginContainer/HBoxContainer/VBoxContainer2/Button

func _input(_event):
	if Input.is_action_just_pressed('cancel') and self.visible:
		get_tree().set_input_as_handled()
		get_node('/root/UiMainLayer').end_dialogue()
	elif Input.is_action_just_pressed('interact') and self.visible:
		get_tree().set_input_as_handled()
		advance()

func set_tree(items):
	tree = items
	current_item = 0
	read_item()

func read_item():
	if current_item >= tree.size():
		get_node('/root/UiMainLayer').end_dialogue()
	else:
		dialogue_name.text = tree[current_item].name
		dialogue_body.text = tree[current_item].body
		dialogue_next.visible = current_item + 1 < tree.size()

func advance():
	current_item += 1
	read_item()
