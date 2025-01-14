extends Node2D
var value := Vector2(1, 1)
var life = 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position + value
	life += -1 * delta
	if life < 0:
		queue_free()
		pass
	pass
