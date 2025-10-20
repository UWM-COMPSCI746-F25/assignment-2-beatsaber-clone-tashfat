extends Node3D

@export var box_scene : PackedScene
@export var even_material : Material
@export var odd_material : Material

var elapsed_time = 0.0

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	elapsed_time += delta
	
	if elapsed_time >= 1.0 and $"../Music".playing:
		var box_object = box_scene.instantiate()
		var csg_mesh = box_object.get_node("CSGMesh3D")
		var area_3d = box_object.get_node("CSGMesh3D/Area3D")
		
		var offset_x = randf_range(-0.5, 0.5)
		var offset_y = randf_range(-0.25, 0.25)
		var pos: Vector3 = Vector3(0.0 + offset_x, 1.0 + offset_y, -10.0)
		csg_mesh.position = pos
		
		var random_number = randi()
		if random_number % 2 == 0:
			csg_mesh.material = even_material
			area_3d.set_collision_layer_value(17, true)
			area_3d.set_collision_layer_value(9, false)
		else:
			csg_mesh.material = odd_material
			area_3d.set_collision_layer_value(9, true)
			area_3d.set_collision_layer_value(17, false)
		
		add_child(box_object)
		elapsed_time = 0.0
