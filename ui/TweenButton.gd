extends Button

func _ready():
	get_stylebox("normal", "Button").border_blend = false
	get_stylebox("hover", "Button").border_blend = false

func _tween_style(stylebox, property, start, end):
	$Tween.interpolate_property(stylebox, property, start, end, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)

func _on_Button_mouse_entered():
	_tween_style(get_stylebox("normal", "Button"), "border_width_left", 2, 8)
	_tween_style(get_stylebox("normal", "Button"), "border_width_right", 2, 8)
	_tween_style(get_stylebox("hover", "Button"), "border_width_left", 2, 8)
	_tween_style(get_stylebox("hover", "Button"), "border_width_right", 2, 8)
	$Tween.start()

func _on_Button_mouse_exited():
	_tween_style(get_stylebox("normal", "Button"), "border_width_left", 8, 2)
	_tween_style(get_stylebox("normal", "Button"), "border_width_right", 8, 2)
	_tween_style(get_stylebox("hover", "Button"), "border_width_left", 8, 2)
	_tween_style(get_stylebox("hover", "Button"), "border_width_right", 8, 2)
	$Tween.start()
