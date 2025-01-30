extends MeshInstance3D

func _ready():
	# Assign the mesh to the MeshInstance3D
	var random_hex_mesh = GameManager.get_random_weighted_tile()
	self.mesh = random_hex_mesh
