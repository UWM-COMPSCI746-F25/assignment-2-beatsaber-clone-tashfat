extends CSGMesh3D

var pos: Vector3

func _ready() -> void:
	pos = position
	
func _physics_process(delta: float) -> void:
	var current_pos = pos + Vector3(0, 0, 0.05)
	pos = current_pos
	position = current_pos
	
	if position.z > 3:
		queue_free()
