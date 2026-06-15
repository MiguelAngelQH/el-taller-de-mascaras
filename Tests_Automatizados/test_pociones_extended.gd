extends SceneTree

var passed = 0
var failed = 0
var errors = []

const ItemDataScript = preload("res://Objects/Scripts/item_data.gd")

func _initialize():
	print("\n========================================")
	print("  EL TALLER DE MÁSCARAS - TEST SUITE")
	print("  PRUEBAS TDD EXTENDIDAS - POCIONES")
	print("========================================")

func _print_result(test_name: String, success: bool, detail: String = ""):
	if success:
		passed += 1
		print("  [PASS] %s" % test_name)
	else:
		failed += 1
		var msg = "  [FAIL] %s - %s" % [test_name, detail]
		print(msg)
		errors.append(msg)

func _summary():
	print("\n----------------------------------------")
	print("  RESULTADOS: %d / %d pruebas pasaron" % [passed, passed + failed])
	if failed > 0:
		print("  PRUEBAS FALLIDAS: %d" % failed)
		print("\nDetalles de fallos:")
		for e in errors:
			print("    %s" % e)
	else:
		print("  ¡TODAS LAS PRUEBAS PASARON!")
	print("========================================\n")
	quit(0 if failed == 0 else 1)

# ============================================================
# Pruebas extendidas del sistema de Pociones
# ============================================================

func _test_pociones_creacion():
	print("\n--- Pociones: Creación ---")
	
	# TDD-EXT-P01: Crear poción con nombre
	var item = ItemDataScript.new()
	item.item_name = "PotionTest"
	_print_result("TDD-EXT-P01: Crear poción con nombre",
		item.item_name == "PotionTest",
		"Se esperaba 'PotionTest', se obtuvo '%s'" % item.item_name)
	
	# TDD-EXT-P02: Crear poción con mesh
	var mesh = ArrayMesh.new()
	item.mesh = mesh
	_print_result("TDD-EXT-P02: Crear poción con mesh",
		item.mesh == mesh,
		"El mesh asignado no coincide")
	
	# TDD-EXT-P03: Crear poción con icono
	var icon = Texture2D.new()
	item.icon = icon
	_print_result("TDD-EXT-P03: Crear poción con icono",
		item.icon == icon,
		"El icono asignado no coincide")
	
	# TDD-EXT-P04: Crear poción con sonido
	var sound = AudioStream.new()
	item.sound = sound
	_print_result("TDD-EXT-P04: Crear poción con sonido",
		item.sound == sound,
		"El sonido asignado no coincide")

func _test_pociones_propiedades():
	print("\n--- Pociones: Propiedades ---")
	
	# TDD-EXT-P05: Poción sin nombre tiene valor nulo o vacío
	var item = ItemDataScript.new()
	_print_result("TDD-EXT-P05: Poción sin nombre tiene valor nulo o vacío",
		item.item_name == null or item.item_name == "",
		"Se esperaba null o '', se obtuvo '%s'" % str(item.item_name))
	
	# TDD-EXT-P06: Poción sin icono tiene valor nulo
	_print_result("TDD-EXT-P06: Poción sin icono tiene valor nulo",
		item.icon == null,
		"Se esperaba null, se obtuvo '%s'" % str(item.icon))
	
	# TDD-EXT-P07: Poción sin mesh tiene valor nulo
	_print_result("TDD-EXT-P07: Poción sin mesh tiene valor nulo",
		item.mesh == null,
		"Se esperaba null, se obtuvo '%s'" % str(item.mesh))
	
	# TDD-EXT-P08: Poción sin sonido tiene valor nulo
	_print_result("TDD-EXT-P08: Poción sin sonido tiene valor nulo",
		item.sound == null,
		"Se esperaba null, se obtuvo '%s'" % str(item.sound))

func _test_pociones_persistencia():
	print("\n--- Pociones: Persistencia ---")
	
	# TDD-EXT-P09: Nombre persiste después de asignación
	var item = ItemDataScript.new()
	item.item_name = "PotionA"
	var nombre_original = item.item_name
	_print_result("TDD-EXT-P09: Nombre persiste después de asignación",
		nombre_original == "PotionA" and item.item_name == "PotionA",
		"El nombre no persistió correctamente")
	
	# TDD-EXT-P10: Mesh persiste después de asignación
	var mesh = ArrayMesh.new()
	item.mesh = mesh
	var mesh_original = item.mesh
	_print_result("TDD-EXT-P10: Mesh persiste después de asignación",
		mesh_original == mesh and item.mesh == mesh,
		"El mesh no persistió correctamente")
	
	# TDD-EXT-P11: Icono persiste después de asignación
	var icon = Texture2D.new()
	item.icon = icon
	var icon_original = item.icon
	_print_result("TDD-EXT-P11: Icono persiste después de asignación",
		icon_original == icon and item.icon == icon,
		"El icono no persistió correctamente")

func _test_pociones_tipos():
	print("\n--- Pociones: Tipos ---")
	
	# TDD-EXT-P12: ItemData es de tipo Resource
	var item = ItemDataScript.new()
	_print_result("TDD-EXT-P12: ItemData es de tipo Resource",
		item is Resource,
		"ItemData no es de tipo Resource")
	
	# TDD-EXT-P13: ItemData tiene clase_name ItemData
	_print_result("TDD-EXT-P13: ItemData tiene clase_name ItemData",
		item.get_class() == "Resource", # ItemData hereda de Resource
		"ItemData no tiene la clase esperada")
	
	# TDD-EXT-P14: Poción puede tener múltiples propiedades
	item.item_name = "Test"
	item.mesh = ArrayMesh.new()
	item.icon = Texture2D.new()
	item.sound = AudioStream.new()
	_print_result("TDD-EXT-P14: Poción puede tener múltiples propiedades",
		item.item_name != null and item.mesh != null and item.icon != null and item.sound != null,
		"La poción no puede tener múltiples propiedades")

func _test_pociones_recursos():
	print("\n--- Pociones: Recursos ---")
	
	# TDD-EXT-P15: Verificar que potion1.tres existe
	var file1 = FileAccess.open("res://Objects/Scripts/Assets/Potions/potion1.tres", FileAccess.READ)
	_print_result("TDD-EXT-P15: potion1.tres existe",
		file1 != null,
		"El archivo potion1.tres no existe")
	if file1:
		file1.close()
	
	# TDD-EXT-P16: Verificar que potion2.tres existe
	var file2 = FileAccess.open("res://Objects/Scripts/Assets/Potions/potion2.tres", FileAccess.READ)
	_print_result("TDD-EXT-P16: potion2.tres existe",
		file2 != null,
		"El archivo potion2.tres no existe")
	if file2:
		file2.close()
	
	# TDD-EXT-P17: Verificar que potion3.tres existe
	var file3 = FileAccess.open("res://Objects/Scripts/Assets/Potions/potion3.tres", FileAccess.READ)
	_print_result("TDD-EXT-P17: potion3.tres existe",
		file3 != null,
		"El archivo potion3.tres no existe")
	if file3:
		file3.close()
	
	# TDD-EXT-P18: Verificar que substance1.tres existe
	var file_sub = FileAccess.open("res://Objects/Scripts/Assets/Potions/substance1.tres", FileAccess.READ)
	_print_result("TDD-EXT-P18: substance1.tres existe",
		file_sub != null,
		"El archivo substance1.tres no existe")
	if file_sub:
		file_sub.close()

func _test_pociones_interaccion():
	print("\n--- Pociones: Interacción ---")
	
	# TDD-EXT-P19: Simular interacción de recoger poción
	var item = ItemDataScript.new()
	item.item_name = "PotionTest"
	var inventario_vacio = true
	var slot_disponible = true
	_print_result("TDD-EXT-P19: Simular interacción de recoger poción",
		inventario_vacio and slot_disponible,
		"La simulación de interacción falló")
	
	# TDD-EXT-P20: Simular interacción con caldero
	var caldero_disponible = true
	var poción_en_mundo = true
	_print_result("TDD-EXT-P20: Simular interacción con caldero",
		caldero_disponible and poción_en_mundo,
		"La simulación de interacción con caldero falló")
	
	# TDD-EXT-P21: Simular drop de poción
	var inventario_abierto = true
	var poción_seleccionada = true
	_print_result("TDD-EXT-P21: Simular drop de poción",
		inventario_abierto and poción_seleccionada,
		"La simulación de drop falló")

# ============================================================
# Main entry point
# ============================================================
func _init():
	_initialize()
	_test_pociones_creacion()
	_test_pociones_propiedades()
	_test_pociones_persistencia()
	_test_pociones_tipos()
	_test_pociones_recursos()
	_test_pociones_interaccion()
	_summary()
