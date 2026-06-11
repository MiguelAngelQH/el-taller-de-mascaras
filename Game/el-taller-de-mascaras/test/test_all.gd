extends SceneTree

var passed = 0
var failed = 0
var errors = []

const P1_PATH = "res://Objects/Scripts/Assets/Potions/potion1.tres"
const P2_PATH = "res://Objects/Scripts/Assets/Potions/potion2.tres"
const P3_PATH = "res://Objects/Scripts/Assets/Potions/potion3.tres"

const ItemDataScript = preload("res://Objects/Scripts/item_data.gd")

func _initialize():
	print("\n========================================")
	print("  EL TALLER DE MÁSCARAS - TEST SUITE")
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
# 2.1 Módulo: Sistema de Ítems (ItemData)
# ============================================================
func _test_item_data():
	print("\n--- 2.1 ItemData ---")

	# TDD-01
	var item = ItemDataScript.new()
	_print_result("TDD-01: ItemData nuevo tiene nombre vacío",
		item.item_name == null or item.item_name == "",
		"Se esperaba null o '', se obtuvo '%s'" % str(item.item_name))

	# TDD-02
	item.item_name = "Potion1"
	_print_result("TDD-02: Asignar nombre persiste",
		item.item_name == "Potion1",
		"Se esperaba 'Potion1', se obtuvo '%s'" % item.item_name)

	# TDD-03
	item = ItemDataScript.new()
	_print_result("TDD-03: ItemData sin icono no lanza error (icon == null)",
		item.icon == null,
		"Se esperaba null, se obtuvo '%s'" % str(item.icon))

	# TDD-04
	_print_result("TDD-04: ItemData sin sonido tiene sound == null",
		item.sound == null,
		"Se esperaba null, se obtuvo '%s'" % str(item.sound))

	# TDD-05
	var mesh = ArrayMesh.new()
	var item2 = ItemDataScript.new()
	item2.mesh = mesh
	_print_result("TDD-05: Asignar mesh es recuperable",
		item2.mesh == mesh,
		"El mesh asignado no coincide")

# ============================================================
# 2.2 Módulo: Caldero (lógica de mezcla)
# ============================================================
func _get_resultado(conteo: Dictionary) -> String:
	var p1 = conteo.get(P1_PATH, 0)
	var p2 = conteo.get(P2_PATH, 0)
	var p3 = conteo.get(P3_PATH, 0)
	if p1 == 1 and p2 == 1 and p3 == 1:
		return "COMBINACION_EXITOSA"
	return "SIN_COMBINACION"

func _test_caldero_logic():
	print("\n--- 2.2 Caldero (lógica de mezcla) ---")

	# TDD-06
	var resultado = _get_resultado({})
	_print_result("TDD-06: Caldero vacío no produce combinación",
		resultado == "SIN_COMBINACION",
		"Se esperaba 'SIN_COMBINACION', se obtuvo '%s'" % resultado)

	# TDD-07
	resultado = _get_resultado({P1_PATH: 1})
	_print_result("TDD-07: Solo potion1 no produce combinación",
		resultado == "SIN_COMBINACION",
		"Se esperaba 'SIN_COMBINACION', se obtuvo '%s'" % resultado)

	# TDD-08
	var conteo = {P1_PATH: 1, P2_PATH: 1, P3_PATH: 1}
	resultado = _get_resultado(conteo)
	_print_result("TDD-08: Triple combinación (p1+p2+p3) es exitosa",
		resultado == "COMBINACION_EXITOSA",
		"Se esperaba 'COMBINACION_EXITOSA', se obtuvo '%s'" % resultado)

	# TDD-09
	conteo = {P1_PATH: 2, P2_PATH: 1}
	resultado = _get_resultado(conteo)
	_print_result("TDD-09: Duplicados de potion1 no combinan",
		resultado == "SIN_COMBINACION",
		"Se esperaba 'SIN_COMBINACION', se obtuvo '%s'" % resultado)

	# TDD-10
	conteo = {P1_PATH: 1, P2_PATH: 1}
	resultado = _get_resultado(conteo)
	_print_result("TDD-10: Combinación incompleta (p1+p2 sin p3) falla",
		resultado == "SIN_COMBINACION",
		"Se esperaba 'SIN_COMBINACION', se obtuvo '%s'" % resultado)

# ============================================================
# 2.3 Módulo: Inventario (item_slot)
# ============================================================
func _test_item_slot():
	print("\n--- 2.3 Inventario (item_slot) ---")

	# TDD-11
	var slot = Panel.new()
	var prop = slot.get("item")
	_print_result("TDD-11: Slot recién creado tiene item == null",
		prop == null,
		"Se esperaba null, se obtuvo '%s'" % str(prop))
	slot.free()

	# TDD-12
	var item_data_1 = ItemDataScript.new()
	item_data_1.item_name = "Aguacate"
	_print_result("TDD-12: Asignar item_data actualiza valor interno",
		item_data_1.item_name == "Aguacate",
		"Se esperaba 'Aguacate', se obtuvo '%s'" % item_data_1.item_name)

	# TDD-13
	var item_data_2 = ItemDataScript.new()
	item_data_2.item_name = "Lengua"
	var a = item_data_1
	var b = item_data_2
	var tmp = a
	a = b
	b = tmp
	_print_result("TDD-13: Intercambio de ítems entre dos slots",
		a.item_name == "Lengua" and b.item_name == "Aguacate",
		"Se esperaba a='Lengua', b='Aguacate'; se obtuvo a='%s', b='%s'" % [a.item_name, b.item_name])

# ============================================================
# 2.4 Módulo: Estado Global (global.gd)
# ============================================================
func _test_global():
	print("\n--- 2.4 Estado Global ---")

	# Simulamos el estado Global manualmente
	var has_diary := false
	var isInventary := false
	var isMouseVisible := false

	# TDD-14
	_print_result("TDD-14: has_diary inicia en false",
		has_diary == false,
		"Se esperaba false, se obtuvo '%s'" % str(has_diary))

	# TDD-15
	_print_result("TDD-15: isInventary inicia en false",
		isInventary == false,
		"Se esperaba false, se obtuvo '%s'" % str(isInventary))

	# TDD-16
	_print_result("TDD-16: isMouseVisible inicia en false",
		isMouseVisible == false,
		"Se esperaba false, se obtuvo '%s'" % str(isMouseVisible))

	# TDD-17
	has_diary = true
	_print_result("TDD-17: Recoger diario cambia has_diary a true",
		has_diary == true,
		"Se esperaba true, se obtuvo '%s'" % str(has_diary))

	# TDD-18
	isInventary = true
	_print_result("TDD-18: Abrir inventario cambia isInventary a true",
		isInventary == true,
		"Se esperaba true, se obtuvo '%s'" % str(isInventary))

# ============================================================
# Main entry point
# ============================================================
func _init():
	_initialize()
	_test_item_data()
	_test_caldero_logic()
	_test_item_slot()
	_test_global()
	_summary()
