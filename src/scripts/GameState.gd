extends Node

var levels = [
  preload('res://levels/Development.tscn'),
  preload('res://levels/Card Flipping.tscn'),
]
var final_scene = preload('res://levels/Final.tscn')
var current_level = 0

func _ready():
  # For debug purposes attempt to find the active scene
  var level_names = []

  for level in levels:
    var inst = level.instance()
    level_names.append(inst.name)

  var index = level_names.find(get_tree().current_scene.name)

  if index != -1:
    current_level = index

func lock_exit():
  var portal = get_tree().get_nodes_in_group('portal').front()
  portal.deactivate()

func unlock_exit():
  var portal = get_tree().get_nodes_in_group('portal').front()
  portal.activate()

func next_level():
  current_level += 1
  if current_level < levels.size():
    get_tree().change_scene_to(levels[current_level])
  else:
    get_tree().change_scene_to(final_scene)
