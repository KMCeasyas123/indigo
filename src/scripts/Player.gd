extends KinematicBody2D

var acceleration = 0.4
var deceleration = 0.75
var max_speed = 250

var velocity = Vector2.ZERO
var direction = 'down'
var walk_frame = 0

onready var activator: KinematicBody2D = $ActivateBox

func _process(_delta):
  var input = get_input_vector()
  var target_speed = input * max_speed

  velocity = velocity.linear_interpolate(target_speed, acceleration if velocity.length() < target_speed.length() else deceleration)

  pick_animation()

  velocity = move_and_slide(velocity)

func _unhandled_input(_event):
  if Input.is_action_just_pressed('interact'):
    var activated = activator.get_overlapping_bodies()

    for thing in activated:
      if thing.has_method('_interact'):
        thing._interact(self)
        break

func pick_animation():
  var horizontal = abs(velocity.x) > abs(velocity.y)
  var sprite: AnimatedSprite = $AnimatedSprite
  var last_anim = sprite.animation

  if velocity.length() > 1:
    if horizontal:
      direction = 'right' if velocity.x > 0 else 'left'
    else:
      direction = 'down' if velocity.y > 0 else 'up'
      
    sprite.animation = 'walk_' + direction
    
    if !last_anim.begins_with('walk_'):
      sprite.frame = walk_frame
    else:
      walk_frame = sprite.frame
  else:
    sprite.animation = direction


  sprite.speed_scale = lerp(1, 2.5, velocity.length() / max_speed)

func get_input_vector():
  return Vector2(
    int(Input.is_action_pressed('right')) - int(Input.is_action_pressed('left')),
    int(Input.is_action_pressed('down')) - int(Input.is_action_pressed('up'))
  ).normalized()
