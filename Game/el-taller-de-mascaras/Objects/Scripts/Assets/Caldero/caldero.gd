extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta): # Most things happen here.
	# SeeCast
	if %CalderoSeeCast.is_colliding():
		var target = %CalderoSeeCast.get_collider()
		if target != null && target.has_method("interactCaldero"):
			target.interactCaldero()		

var displayName = "MERGE"
const WORLD_ITEM_SCENE = preload("uid://d06616oqh27ou")
const SUBSTANCE_1 = preload("uid://bkhqck3y0gsbs")

func interact():
	var grid = get_tree().root.find_child("InventoryCalderoGridContainer", true, false)
	if not grid: return

	var resultados = {}
	for slot in grid.get_children():
		if slot.item != null:
			var path = slot.item.resource_path
			resultados[path] = resultados.get(path, 0) + 1

	if resultados.is_empty():
		print("El caldero estaba vacío.")
		return

	# Variables de conteo
	var p1 = resultados.get("res://Objects/Scripts/Assets/Potions/potion1.tres", 0)
	var p2 = resultados.get("res://Objects/Scripts/Assets/Potions/potion2.tres", 0)
	var p3 = resultados.get("res://Objects/Scripts/Assets/Potions/potion3.tres", 0)
	var p4 = resultados.get("res://Objects/Scripts/Assets/Potions/potion4.tres", 0)
	var p5 = resultados.get("res://Objects/Scripts/Assets/Potions/potion5.tres", 0)
	var p6 = resultados.get("res://Objects/Scripts/Assets/Potions/potion6.tres", 0)
	var p7 = resultados.get("res://Objects/Scripts/Assets/Potions/potion7.tres", 0)
	var p8 = resultados.get("res://Objects/Scripts/Assets/Potions/potion8.tres", 0)
	var p9 = resultados.get("res://Objects/Scripts/Assets/Potions/potion9.tres", 0)
	var p10 = resultados.get("res://Objects/Scripts/Assets/Potions/potion10.tres", 0)

	print("--- PROCESO DE MEZCLA ---")
	if p1 == 1 and p2 == 1 and p3 == 1:
		print("¡Combinación Triple lograda!")
		# Instanciar la nueva sustancia y lanzarla
		spawn_and_launch(SUBSTANCE_1)
	else:
		# Si no hay combinación, devolver todos los objetos al mundo
		for slot in grid.get_children():
			if slot.item != null:
				spawn_and_launch(slot.item)

	# Limpiar el inventario visualmente al final
	for slot in grid.get_children():
		slot.item = null
		if slot.has_method("update_ui"):
			slot.update_ui()

# Función reutilizable para instanciar y lanzar
func spawn_and_launch(resource_item: Resource):
	var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	var target_height : float = 4.0
	var max_angle_degrees : float = 20.0
	
	var new_obj = WORLD_ITEM_SCENE.instantiate()
	
	# Configurar datos del objeto
	new_obj.set_meta("item_data", resource_item)
	var mesh_node = new_obj.get_node_or_null("MeshInstance3D")
	if mesh_node:
		mesh_node.mesh = resource_item.mesh
	
	get_tree().current_scene.add_child(new_obj)
	
	# Posicionamiento inicial (encima del caldero)
	new_obj.global_position = self.global_position + Vector3(0.8, 1.5, 0.5)
	
	# Lógica de física de lanzamiento
	var vy = sqrt(2 * gravity * target_height)
	var random_direction = randf_range(0, TAU)
	var angle_rad = deg_to_rad(max_angle_degrees)
	var horizontal_speed = vy * tan(angle_rad)
	
	var vx = cos(random_direction) * horizontal_speed
	var vz = sin(random_direction) * horizontal_speed
	
	new_obj.linear_velocity = Vector3.ZERO
	var final_velocity = Vector3(vx, vy, vz)
	new_obj.apply_central_impulse(final_velocity * new_obj.mass)
