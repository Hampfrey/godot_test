extends CharacterBody2D

var speed := 150
var direction := Vector2(1, 1)
var boost = 1
var lifetime = 0
var true_velocity = 0

var level_node
var player_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	level_node = get_parent()
	player_node = level_node.get_node("player")
	velocity = direction * speed
	lifetime = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	true_velocity = velocity * delta * boost
	lifetime += 1
	var collision_info = move_and_collide(true_velocity)
	
	if collision_info:
		print("\n hit " + collision_info.get_collider().name)
		velocity = velocity.bounce(collision_info.get_normal())
		
		var force = collision_info.get_normal() * true_velocity
		force = force[0] + force[1]
		print(force)
		
		if collision_info.get_collider().name == "borders" or collision_info.get_collider().name == "player":
			if force > 10:
				kill()
		else:
			if lifetime > 5 and collision_info.get_collider().lifetime > 5:
				#print("l " + str(((collision_info.get_collider().true_velocity) + (true_velocity)).length()))
				if ((collision_info.get_collider().true_velocity) + (true_velocity)).length() > 10:
					kill()
	if boost > 1:
		boost = boost / 1.01
	else:
		boost = 1

func kill():
	#queue_free()
	pass
	
func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.name == "attack_Area2D":
		velocity = Vector2(position.x - player_node.position.x, position.y - player_node.position.y).normalized() * speed
		if boost < 3:
			boost = 5
		else:
			boost += 3
	print(area.name)

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.name
