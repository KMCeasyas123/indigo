extends CanvasLayer

onready var dialogue_box: PanelContainer = $DialogueBox

func _ready():
  dialogue_box.visible = false

func start_dialogue(tree):
  get_tree().paused = true
  dialogue_box.set_tree(tree)
  dialogue_box.visible = true
  
func end_dialogue():
  dialogue_box.visible = false
  get_tree().paused = false
