extends KinematicBody2D

export var acceleration = 0.5
export var deceleration = 0.75
export var max_speed = 300

var velocity = Vector2.ZERO
var direction = 'down'

func _process(_delta):
	var input = get_input_vector()
	var target_speed = input * max_speed

	velocity = velocity.linear_interpolate(target_speed, acceleration if velocity.length() < target_speed.length() else deceleration)

	pick_animation()

	velocity = move_and_slide(velocity)

func pick_animation():
	var horizontal = abs(velocity.x) > abs(velocity.y)
	var sprite: AnimatedSprite = $AnimatedSprite

	if velocity.length() > 1:
		if horizontal:
			direction = 'right' if velocity.x > 0 else 'left'
		else:
			direction = 'down' if velocity.y > 0 else 'up'
	
		sprite.animation = 'walk_' + direction
	else:
		sprite.animation = direction

func get_input_vector():
	return Vector2(
		int(Input.is_action_pressed('right')) - int(Input.is_action_pressed('left')),
		int(Input.is_action_pressed('down')) - int(Input.is_action_pressed('up'))
	).normalized()
