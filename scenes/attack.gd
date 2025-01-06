extends Node2D
var timer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer = timer + 1 * delta
	if timer > 0.5:
		queue_free()
