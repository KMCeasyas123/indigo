extends Area2D

signal toggled

var locked = false

func _ready():
	connect('body_entered', self, 'step_on')
	connect('body_exited', self, 'step_off')

func step_on(body):
	if locked:
		return
		
	if body.is_in_group('step_button'):
		$StepButtonUp.visible = false
		$StepButtonDn.visible = true
		emit_signal('toggled', true)
		
func step_off(original_body):
	if locked:
		return

	for body in get_overlapping_bodies():
		if body.is_in_group('step_button') and body != original_body:
			return

	$StepButtonUp.visible = true
	$StepButtonDn.visible = false
	emit_signal('toggled', false)
		
