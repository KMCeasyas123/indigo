extends RigidBody2D

var speed = 225
var velocity = Vector2.ZERO
var idle_timer = 1
var follow_distance = 50
var follow_timer = 1
var sitting = false

onready var player = get_tree().get_nodes_in_group('player').front()
onready var sprite: AnimatedSprite = $AnimatedSprite

func _physics_process(delta):
  var target_speed

  if not sitting:
    follow_timer -= delta
    if follow_timer <= 0:
      adjust_follow_distance()

    if position.distance_to(player.position) > follow_distance:
      target_speed = position.direction_to(player.position) * speed
    else:
      target_speed = Vector2.ZERO
    
    velocity = velocity.linear_interpolate(target_speed, 0.5)
  else:
    velocity *= 0.8

  linear_velocity = velocity
  rotation = 0
  angular_velocity = 0
    
  idle_timer -= delta
  pick_animation()

func _interact(_player):
  sitting = !sitting

func pick_animation():
  if sitting:
    sprite.animation = 'sit'
    sprite.flip_h = position.direction_to(player.position).x >= 0
  else:
    if velocity.length() > 0.1:
      sprite.animation = 'run'
      sprite.speed_scale = lerp(1, 2.5, velocity.length() / speed)
      sprite.flip_h = position.direction_to(player.position).x >= 0

      reset_idle()
    else:
      if idle_timer < -2:
        reset_idle()
      elif idle_timer <= 0:
        sprite.animation = 'idle1'
      else:
        sprite.animation = 'stand'

func adjust_follow_distance():
  follow_distance = rand_range(50, 100)
  follow_timer = rand_range(1.5, 4)

func reset_idle():
  idle_timer = rand_range(1.5, 4)
