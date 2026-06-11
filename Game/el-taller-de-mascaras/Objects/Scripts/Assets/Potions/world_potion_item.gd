extends RigidBody3D

# Asegúrate de que este nombre coincida con lo que esperas en el HUD
@export var displayName: String = "Potion" 
@export var item_data: Resource
func _ready() -> void:
	if item_data:
		# Se autoconfigura al iniciar el juego
		set_meta("item_data", item_data)
		get_node("MeshInstance3D").mesh = item_data.mesh

func interact():
	Global.isMouseVisible = !Global.isMouseVisible
	# Global.DialogicStart("res://Objects/assets/potions/potionDrop.dtl")
	if not has_meta("item_data"):
		print("Error: Este objeto no tiene metadatos 'item_data'")
		return
	
	var data = get_meta("item_data")
	if data.sound: 		
		# Buscamos el nodo reproductor en la escena
		var sound_node = get_tree().root.find_child("ItemSound", true, false)
		
		if sound_node:
			sound_node.stream = data.sound
			sound_node.play()
		else:
			print("Error: No se encontró el nodo 'ItemSound' en la escena")
	
	# 2. Buscamos el contenedor del inventario
	# Nota: Es mejor usar un nombre de grupo o una señal, pero siguiendo tu lógica:
	var inventory_grid = get_tree().root.find_child("InventoryGridContainer", true, false)
	
	
	if inventory_grid:
		for slot in inventory_grid.get_children():
			# Verificamos si el slot está libre
			if slot.item == null:
				slot.item = data
				if slot.has_method("update_ui"):
					slot.update_ui()
				queue_free()
				return # Salimos para no llenar todos los slots con el mismo ítem
	else:
		print("No se encontró el InventoryGridContainer")

func interactCaldero():
	# 1. Buscamos el contenedor del inventario del Caldero en la escena
	var grid = get_tree().root.find_child("InventoryCalderoGridContainer", true, false)
	if grid:
		# 2. Recorremos todos los slots (hijos del GridContainer)
		for slot in grid.get_children():
			# 3. Si el slot está vacío (item es null)
			if slot.item == null:
				# 4. Le asignamos los datos de este objeto. 
				# Asegúrate de tener una variable 'item_data' o usa get_meta("item_data")
				slot.item = get_meta("item_data") 
				
				# 5. Llamamos a la función que actualiza la imagen (del video)
				slot.update_ui()
				
				# Almacenaos y contamos todos los objetos
				print(slot.item.resource_path)
				
				# 6. Eliminamos el objeto del mundo 3D
				queue_free()
				# 7. Salimos de la función para no llenar todos los slots a la vez
				return
			
			
		
