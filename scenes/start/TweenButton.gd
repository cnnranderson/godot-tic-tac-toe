extends Button

func _ready():
	get_stylebox("normal", "Button").border_blend = false
	get_stylebox("hover", "Button").border_blend = false

func _on_Button_mouse_entered():
	var current_width = get_stylebox("normal", "Button").border_width_left
	$Tween.interpolate_property(get_stylebox("normal", "Button"), "border_width_left", current_width, 8, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	var current_width2 = get_stylebox("hover", "Button").border_width_left
	$Tween.interpolate_property(get_stylebox("hover", "Button"), "border_width_left", current_width2, 8, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _on_Button_mouse_exited():
	var current_width = get_stylebox("normal", "Button").border_width_left
	$Tween.interpolate_property(get_stylebox("normal", "Button"), "border_width_left", current_width, 2, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	var current_width2 = get_stylebox("hover", "Button").border_width_left
	$Tween.interpolate_property(get_stylebox("hover", "Button"), "border_width_left", current_width2, 2, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
