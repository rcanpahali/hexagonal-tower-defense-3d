extends Node

# Load the mesh resources
var archery_building = preload("res://models/exports/archery_building.res")
var castle_building = preload("res://models/exports/castle_building.res")
var farm_building = preload("res://models/exports/farm_building.res")
var grass = preload("res://models/exports/grass.res")
var grass_forest = preload("res://models/exports/grass_forest.res")
var grass_hill = preload("res://models/exports/grass_hill.res")
var house_building = preload("res://models/exports/house_building.res")
var sand_desert = preload("res://models/exports/sand_desert.res")
var sand_rocks = preload("res://models/exports/sand_rocks.res")
var sheep_building = preload("res://models/exports/sheep_building.res")
var stone_hill = preload("res://models/exports/stone_hill.res")
var stone_mountain = preload("res://models/exports/stone_mountain.res")
var stone_rocks = preload("res://models/exports/stone_rocks.res")

#sand_desert,
#sand_rocks,
#stone_hill,
#stone_mountain,
#stone_rocks

var tile_list: Array[Dictionary] = [
	{ "mesh": archery_building, "weight": 2 },
	{ "mesh": castle_building, "weight": 1 },
	{ "mesh": farm_building, "weight": 3 },
	{ "mesh": grass, "weight": 0 },
	{ "mesh": grass_forest, "weight": 0 },
	{ "mesh": grass_hill, "weight": 4 },
	{ "mesh": house_building, "weight": 2 },
	{ "mesh": sheep_building, "weight": 3 }
]

var used_tile_ids: Array[RID] = []

func _ready():
	pass

# todo: this is a rough implementation -> implement smarter version
func get_random_weighted_tile():
	var filler_tiles = tile_list.filter(func(item): return item.weight == 0)
	
	var random_tile = get_random_tile()
	var random_tile_id: RID = get_tile_id(random_tile)
	
	# check if random tile is used before
	if (used_tile_ids.has(random_tile_id)):
		# check how many times it has been used
		var used_count = get_used_tile_count(random_tile_id)
		var tile_weight = get_tile_weight(random_tile_id)
		# return filler tile if we hit the weight
		if(used_count >= tile_weight):
			var filler_tile = filler_tiles.pick_random()
			return filler_tile.mesh;
		else:
			used_tile_ids.push_back(random_tile_id)
			return random_tile.mesh
	else:
		used_tile_ids.push_back(random_tile_id)
		return random_tile.mesh;

func get_random_tile():
	return tile_list.pick_random()

# method to check how many times the tile has been used
func get_used_tile_count(rid: RID):
	return used_tile_ids.filter(func(id): return id == rid).size()

func get_tile_id(tile):
	return tile.mesh.get_rid()

# method to return used tile weight
func get_tile_weight(rid: RID):
	# todo: convert this to find
	var tile = tile_list.filter(func(res): return get_tile_id(res) == rid)
	assert(tile.size() > 0, "Random tile id not found in the list")
	return tile[0].weight;
