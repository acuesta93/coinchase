extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$InicioTimer.wait_time = randf_range(.3, .8)
	$InicioTimer.start()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemigos"):
		position = Vector2(randf_range(0, get_parent().get_parent().screensize.x), randf_range(0, get_parent().get_parent().screensize.y))

func recoger():
	var tween = create_tween()
	tween.tween_property($AnimatedSprite2D, "scale", Vector2(.1, .1), .2)
	var tween2 = create_tween()
	tween2.tween_property($AnimatedSprite2D, "modulate", Color.RED, .2)
	tween.finished.connect(eliminar)

func eliminar():
	queue_free()
	
func _on_inicio_timer_timeout() -> void:
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.play()
	
