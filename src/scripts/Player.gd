extends KinematicBody2D

export var acceleration = 0.5
export var deceleration = 0.75
export var max_speed = 300

var velocity = Vector2.ZERO

func _process(_delta):
	var input = get_input_vector()
	var target_speed = input * max_speed

	velocity = velocity.linear_interpolate(target_speed, acceleration if velocity.length() < target_speed.length() else deceleration)

	velocity = move_and_slide(velocity)

func get_input_vector():
	return Vector2(
		int(Input.is_action_pressed('right')) - int(Input.is_action_pressed('left')),
		int(Input.is_action_pressed('down')) - int(Input.is_action_pressed('up'))
	).normalized()
