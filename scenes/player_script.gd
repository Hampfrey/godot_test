extends CharacterBody2D
var attack_scene: PackedScene = load("res://scenes/attack.tscn")
@export var speed := 300
var attack_dist := 128

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement_control()
	action_control()
	menu_control()
	
func movement_control() -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()

func action_control() -> void:
	var mouse_x = get_global_mouse_position().x
	var mouse_y = get_global_mouse_position().y
	var player_x = self.position.x
	var player_y = self.position.y
	
	var mouse_angle = atan2(player_y - mouse_y, player_x - mouse_x) * 180 / PI
	
	if Input.is_action_just_pressed("action"):
		var attack = attack_scene.instantiate()
		add_child(attack)
		attack.position = Vector2(cos(mouse_angle * PI / 180) * -attack_dist, sin(mouse_angle * PI / 180) * -attack_dist)
		#attack.rotation = (mouse_angle - 90) * PI / 180

func menu_control():
	if Input.is_action_just_pressed("fullscreen") and DisplayServer.window_get_mode() == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif Input.is_action_just_pressed("fullscreen") and DisplayServer.window_get_mode() == 3:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
