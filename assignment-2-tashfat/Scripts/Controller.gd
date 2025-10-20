extends XRController3D

@export var raycast_length = 1.0
@onready var sound_effect = $"../../SoundEffect"

func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	var origin = global_position
	var dir = global_basis.z * -1
	var end = origin + (dir * raycast_length)
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	
	$"LineRenderer".points[0] = origin + dir * 0.1
	$"LineRenderer".points[1] = end
	
	if result:
		$"LineRenderer".points[1] = result.position


func _on_area_3d_area_entered(area: Area3D) -> void:
	sound_effect.play()
	area.get_parent_node_3d().queue_free()
	
func _on_button_pressed(name: String) -> void:
	if name == "primary_click":
		XRServer.center_on_hmd(XRServer.RESET_FULL_ROTATION, true)


func _on_ax_button_pressed(name: String) -> void:
	if name == "ax_button":
		print(name)
		if $"LineRenderer".visible == false:
			$"LineRenderer".visible == true
			self.find_child("CollisionShape3D").disabled = false
		else:
			$"LineRenderer".visible == false
			self.find_child("CollisionShape3D").disabled = true
