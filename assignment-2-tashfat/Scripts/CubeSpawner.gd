extends Node3D

@export var spawn_times: Array[float] = [
	1.017, 1.982, 2.937, 4.035, 5.100, 6.119, 7.148, 8.100, 9.109, 10.081,
	11.169, 12.233, 13.295, 14.266, 15.260, 16.239, 17.329, 18.409, 19.505, 20.496,
	21.514, 22.476, 23.451, 24.432, 25.503, 26.482, 27.515, 28.535, 29.568, 30.631,
	31.620, 32.669
]

@export var cube_scene : PackedScene

@export var even_material : Material
@export var odd_material : Material

var elapsed_time = 0.0
var current_spawn_index = 0

func _ready() -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	elapsed_time += delta
	
	if current_spawn_index < spawn_times.size():
		var next_spawn_time = spawn_times[current_spawn_index]
		if elapsed_time >= next_spawn_time and $"../Music".playing:
			var cube_object = cube_scene.instantiate()
			var csg_mesh = cube_object.get_node("CSGMesh3D")
			var area_3d = cube_object.get_node("CSGMesh3D/Area3D")
			
			var offset_x = randf_range(-0.5, 0.5)
			var offset_y = randf_range(-0.25, 0.25)
			var pos : Vector3 = Vector3(0 + offset_x, 1.5 + offset_y, -10.0)
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

			add_child(cube_object)
			current_spawn_index += 1
