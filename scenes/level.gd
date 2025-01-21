extends Node2D
var target_scene: PackedScene = load("res://scenes/target.tscn")
var target_timer: float = 0
var rate = 6

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _process(delta: float) -> void:
	target_timer = target_timer + 1 * delta
	rate += -0.0005
	if target_timer > rate:
		print("rate " + str(rate))
		target_timer = 0
		var target = target_scene.instantiate()
		add_child(target)
		var rand := RandomNumberGenerator.new()
		var width = get_viewport().get_visible_rect().size[0]
		var height = get_viewport().get_visible_rect().size[1]
		var rand_x = rand.randi_range(0, 1280)
		var rand_y = rand.randi_range(100, 0)
		target.position = Vector2(rand_x, rand_y)
		target.direction = Vector2(rand.randf_range(-1, 1), -1)
	
