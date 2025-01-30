extends Node3D

var map_radius := 3  # Controls the size of the hexagonal shape
var size := 0.59  # Hex tile size
var w := sqrt(3) * size  # Proper width of a hex tile
var h := 2 * size  # Proper height of a hex tile

var hex_tile = preload("res://scenes/random_hex.tscn")

func _ready() -> void:
	generate_map()

func generate_map() -> void:
	for q in range(-map_radius, map_radius + 1):
		for r in range(-map_radius, map_radius + 1):
			var s = -q - r  # Enforce hexagonal shape constraint (q + r + s = 0)
			if abs(s) > map_radius:
				continue  # Skip out-of-bounds hexes

			var hex_tile_instance = hex_tile.instantiate()
			add_child(hex_tile_instance)

			# Convert axial (q, r) to world position
			var x_pos = w * (q + 0.5 * r)  # Staggered row offset
			var z_pos = h * 0.75 * r  # 0.75 ensures tight vertical spacing

			hex_tile_instance.global_transform.origin = Vector3(x_pos, 0, z_pos)
