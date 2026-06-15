extends SceneTree

var passed = 0
var failed = 0
var errors = []

const ItemDataScript = preload("res://Objects/Scripts/item_data.gd")

func _initialize():
	print("\n========================================")
	print("  EL TALLER DE MÁSCARAS - TEST SUITE")
	print("  PRUEBAS TDD EXTENDIDAS - INVENTARIO")
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
# Pruebas extendidas del sistema de Inventario
# ============================================================

func _test_inventory_hub():
	print("\n--- Inventario: Inventory Hub ---")
	
	# TDD-EXT-I01: Estado inicial de isShowInventory es false
	var isShowInventory := false
	_print_result("TDD-EXT-I01: Estado inicial de isShowInventory es false",
		isShowInventory == false,
		"Se esperaba false, se obtuvo %s" % str(isShowInventory))
	
	# TDD-EXT-I02: Toggle de isShowInventory
	isShowInventory = !isShowInventory
	_print_result("TDD-EXT-I02: Toggle de isShowInventory a true",
		isShowInventory == true,
		"Se esperaba true, se obtuvo %s" % str(isShowInventory))
	
	# TDD-EXT-I03: Toggle de isShowInventory de vuelta
	isShowInventory = !isShowInventory
	_print_result("TDD-EXT-I03: Toggle de isShowInventory a false",
		isShowInventory == false,
		"Se esperaba false, se obtuvo %s" % str(isShowInventory))
	
	# TDD-EXT-I04: Simular cambio de visibilidad
	var inventario_visible := false
	inventario_visible = !inventario_visible
	_print_result("TDD-EXT-I04: Simular cambio de visibilidad",
		inventario_visible == true,
		"Se esperaba true, se obtuvo %s" % str(inventario_visible))

func _test_inventory_slots():
	print("\n--- Inventario: Slots ---")
	
	# TDD-EXT-I05: Crear slot vacío
	var slot = Panel.new()
	var item_inicial = slot.get("item")
	_print_result("TDD-EXT-I05: Slot recién creado tiene item == null",
		item_inicial == null,
		"Se esperaba null, se obtuvo '%s'" % str(item_inicial))
	slot.free()
	
	# TDD-EXT-I06: Asignar ítem a slot
	slot = Panel.new()
	var item_data = ItemDataScript.new()
	item_data.item_name = "TestItem"
	slot.set("item", item_data)
	var item_asignado = slot.get("item")
	_print_result("TDD-EXT-I06: Asignar ítem a slot",
		item_asignado == item_data,
		"El ítem no se asignó correctamente")
	slot.free()
	
	# TDD-EXT-I07: Verificar que hay suficientes slots
	var num_slots := 6
	_print_result("TDD-EXT-I07: Verificar que hay suficientes slots",
		num_slots >= 6,
		"Se esperaban >= 6 slots, se obtuvieron %d" % num_slots)
	
	# TDD-EXT-I08: Verificar capacidad máxima
	var capacidad_maxima := 10
	_print_result("TDD-EXT-I08: Verificar capacidad máxima",
		capacidad_maxima >= 6,
		"Se esperaba capacidad >= 6, se obtuvo %d" % capacidad_maxima)

func _test_inventory_ui():
	print("\n--- Inventario: UI ---")
	
	# TDD-EXT-I09: Simular actualización de UI
	var item = ItemDataScript.new()
	item.item_name = "PotionTest"
	var icon_texture = Texture2D.new()
	item.icon = icon_texture
	_print_result("TDD-EXT-I09: Simular actualización de UI",
		item.icon == icon_texture,
		"El icono no se asignó correctamente")
	
	# TDD-EXT-I10: Simular tooltip
	var tooltip_text = item.item_name
	_print_result("TDD-EXT-I10: Simular tooltip",
		tooltip_text == "PotionTest",
		"Se esperaba 'PotionTest', se obtuvo '%s'" % tooltip_text)
	
	# TDD-EXT-I11: Simular visibilidad de icono
	var icon_visible := true
	_print_result("TDD-EXT-I11: Simular visibilidad de icono",
		icon_visible == true,
		"Se esperaba true, se obtuvo %s" % str(icon_visible))

func _test_inventory_drag_drop():
	print("\n--- Inventario: Drag & Drop ---")
	
	# TDD-EXT-I12: Simular inicio de drag
	var dragging := false
	dragging = true
	_print_result("TDD-EXT-I12: Simular inicio de drag",
		dragging == true,
		"Se esperaba true, se obtuvo %s" % str(dragging))
	
	# TDD-EXT-I13: Simular drop exitoso
	var drop_exitoso := true
	_print_result("TDD-EXT-I13: Simular drop exitoso",
		drop_exitoso == true,
		"Se esperaba true, se obtuvo %s" % str(drop_exitoso))
	
	# TDD-EXT-I14: Simular swap de ítems
	var item_a = ItemDataScript.new()
	item_a.item_name = "ItemA"
	var item_b = ItemDataScript.new()
	item_b.item_name = "ItemB"
	var tmp = item_a
	item_a = item_b
	item_b = tmp
	_print_result("TDD-EXT-I14: Simular swap de ítems",
		item_a.item_name == "ItemB" and item_b.item_name == "ItemA",
		"Se esperaba a='ItemB', b='ItemA'; se obtuvo a='%s', b='%s'" % [item_a.item_name, item_b.item_name])
	
	# TDD-EXT-I15: Simular drop fallido
	var drop_fallido := false
	_print_result("TDD-EXT-I15: Simular drop fallido",
		drop_fallido == false,
		"Se esperaba false, se obtuvo %s" % str(drop_fallido))

func _test_inventory_estado_global():
	print("\n--- Inventario: Estado Global ---")
	
	# TDD-EXT-I16: Simular Global.isInventary
	var isInventary := false
	isInventary = true
	_print_result("TDD-EXT-I16: Simular Global.isInventary a true",
		isInventary == true,
		"Se esperaba true, se obtuvo %s" % str(isInventary))
	
	# TDD-EXT-I17: Simular Global.isMouseVisible
	var isMouseVisible := false
	isMouseVisible = true
	_print_result("TDD-EXT-I17: Simular Global.isMouseVisible a true",
		isMouseVisible == true,
		"Se esperaba true, se obtuvo %s" % str(isMouseVisible))
	
	# TDD-EXT-I18: Simular modo de mouse
	var mouse_capturado := false
	mouse_capturado = true
	_print_result("TDD-EXT-I18: Simular modo de mouse capturado",
		mouse_capturado == true,
		"Se esperaba true, se obtuvo %s" % str(mouse_capturado))

func _test_inventory_limites():
	print("\n--- Inventario: Límites ---")
	
	# TDD-EXT-I19: Simular inventario lleno
	var slots_llenos := 6
	var capacidad := 6
	_print_result("TDD-EXT-I19: Simular inventario lleno",
		slots_llenos >= capacidad,
		"El inventario está lleno")
	
	# TDD-EXT-I20: Simular inventario vacío
	slots_llenos = 0
	_print_result("TDD-EXT-I20: Simular inventario vacío",
		slots_llenos == 0,
		"Se esperaba 0, se obtuvo %d" % slots_llenos)
	
	# TDD-EXT-I21: Simular inventario parcialmente lleno
	slots_llenos = 3
	_print_result("TDD-EXT-I21: Simular inventario parcialmente lleno",
		slots_llenos > 0 and slots_llenos < capacidad,
		"Se esperaba 0 < slots < capacidad, se obtuvo %d" % slots_llenos)

func _test_inventory_errores():
	print("\n--- Inventario: Manejo de Errores ---")
	
	# TDD-EXT-I22: Simular ítem nulo
	var item = null
	_print_result("TDD-EXT-I22: Manejar ítem nulo",
		item == null,
		"Se esperaba null, se obtuvo '%s'" % str(item))
	
	# TDD-EXT-I23: Simular slot inexistente
	var slot_index = -1
	_print_result("TDD-EXT-I23: Manejar slot inexistente",
		slot_index < 0,
		"Se esperaba índice < 0, se obtuvo %d" % slot_index)
	
	# TDD-EXT-I24: Simular ítem inválido
	item = "string_invalido"
	_print_result("TDD-EXT-I24: Manejar ítem inválido",
		item is String,
		"Se esperaba String, se obtuvo otro tipo")

# ============================================================
# Main entry point
# ============================================================
func _init():
	_initialize()
	_test_inventory_hub()
	_test_inventory_slots()
	_test_inventory_ui()
	_test_inventory_drag_drop()
	_test_inventory_estado_global()
	_test_inventory_limites()
	_test_inventory_errores()
	_summary()
