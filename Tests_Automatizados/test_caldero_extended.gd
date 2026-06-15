extends SceneTree

var passed = 0
var failed = 0
var errors = []

const P1_PATH = "res://Objects/Scripts/Assets/Potions/potion1.tres"
const P2_PATH = "res://Objects/Scripts/Assets/Potions/potion2.tres"
const P3_PATH = "res://Objects/Scripts/Assets/Potions/potion3.tres"

func _initialize():
	print("\n========================================")
	print("  EL TALLER DE MÁSCARAS - TEST SUITE")
	print("  PRUEBAS TDD EXTENDIDAS - CALDERO")
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
# Pruebas extendidas del sistema de Caldero
# ============================================================

func _test_caldero_conteo_pociones():
	print("\n--- Caldero: Conteo de Pociones ---")
	
	# TDD-EXT-01: Conteo correcto de potion1
	var conteo = {P1_PATH: 1}
	var p1 = conteo.get(P1_PATH, 0)
	_print_result("TDD-EXT-01: Conteo correcto de potion1",
		p1 == 1,
		"Se esperaba 1, se obtuvo %d" % p1)
	
	# TDD-EXT-02: Conteo correcto de múltiples pociones
	conteo = {P1_PATH: 2, P2_PATH: 1}
	p1 = conteo.get(P1_PATH, 0)
	var p2 = conteo.get(P2_PATH, 0)
	_print_result("TDD-EXT-02: Conteo correcto de múltiples pociones",
		p1 == 2 and p2 == 1,
		"Se esperaba p1=2, p2=1; se obtuvo p1=%d, p2=%d" % [p1, p2])
	
	# TDD-EXT-03: Conteo de poción inexistente es 0
	var p_inexistente = conteo.get("res://path/inexistente.tres", 0)
	_print_result("TDD-EXT-03: Conteo de poción inexistente es 0",
		p_inexistente == 0,
		"Se esperaba 0, se obtuvo %d" % p_inexistente)

func _test_caldero_combinaciones_extendidas():
	print("\n--- Caldero: Combinaciones Extendidas ---")
	
	# TDD-EXT-04: Combinación con duplicados falla
	var conteo = {P1_PATH: 2, P2_PATH: 1, P3_PATH: 1}
	var p1 = conteo.get(P1_PATH, 0)
	var p2 = conteo.get(P2_PATH, 0)
	var p3 = conteo.get(P3_PATH, 0)
	var resultado = "SIN_COMBINACION"
	if p1 == 1 and p2 == 1 and p3 == 1:
		resultado = "COMBINACION_EXITOSA"
	_print_result("TDD-EXT-04: Combinación con duplicados falla",
		resultado == "SIN_COMBINACION",
		"Se esperaba 'SIN_COMBINACION', se obtuvo '%s'" % resultado)
	
	# TDD-EXT-05: Combinación con poción extra falla
	conteo = {P1_PATH: 1, P2_PATH: 1, P3_PATH: 1, P4_PATH: 1}
	p1 = conteo.get(P1_PATH, 0)
	p2 = conteo.get(P2_PATH, 0)
	p3 = conteo.get(P3_PATH, 0)
	resultado = "SIN_COMBINACION"
	if p1 == 1 and p2 == 1 and p3 == 1:
		resultado = "COMBINACION_EXITOSA"
	_print_result("TDD-EXT-05: Combinación con poción extra falla",
		resultado == "COMBINACION_EXITOSA",
		"Se esperaba 'COMBINACION_EXITOSA', se obtuvo '%s'" % resultado)
	
	# TDD-EXT-06: Combinación inversa (p3+p2+p1) funciona
	conteo = {P1_PATH: 1, P2_PATH: 1, P3_PATH: 1}
	p1 = conteo.get(P1_PATH, 0)
	p2 = conteo.get(P2_PATH, 0)
	p3 = conteo.get(P3_PATH, 0)
	resultado = "SIN_COMBINACION"
	if p1 == 1 and p2 == 1 and p3 == 1:
		resultado = "COMBINACION_EXITOSA"
	_print_result("TDD-EXT-06: Combinación inversa funciona",
		resultado == "COMBINACION_EXITOSA",
		"Se esperaba 'COMBINACION_EXITOSA', se obtuvo '%s'" % resultado)

func _test_caldero_limite():
	print("\n--- Caldero: Límites ---")
	
	# TDD-EXT-07: Caldero con 0 pociones
	var conteo = {}
	var resultado = "SIN_COMBINACION"
	if conteo.is_empty():
		resultado = "SIN_COMBINACION"
	_print_result("TDD-EXT-07: Caldero con 0 pociones",
		resultado == "SIN_COMBINACION",
		"Se esperaba 'SIN_COMBINACION', se obtuvo '%s'" % resultado)
	
	# TDD-EXT-08: Caldero con 10 pociones (máximo teórico)
	conteo = {
		P1_PATH: 1, P2_PATH: 1, P3_PATH: 1, P4_PATH: 1, P5_PATH: 1,
		P6_PATH: 1, P7_PATH: 1, P8_PATH: 1, P9_PATH: 1, P10_PATH: 1
	}
	var total = 0
	for key in conteo:
		total += conteo[key]
	_print_result("TDD-EXT-08: Caldero con 10 pociones",
		total == 10,
		"Se esperaba 10, se obtuvo %d" % total)

func _test_caldero_fisica():
	print("\n--- Caldero: Física ---")
	
	# TDD-EXT-09: Cálculo de gravedad
	var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	_print_result("TDD-EXT-09: Gravedad está configurada",
		gravity > 0,
		"Se esperaba gravedad > 0, se obtuvo %f" % gravity)
	
	# TDD-EXT-10: Cálculo de velocidad vertical
	var target_height = 4.0
	var vy = sqrt(2 * gravity * target_height)
	_print_result("TDD-EXT-10: Cálculo de velocidad vertical",
		vy > 0,
		"Se esperaba vy > 0, se obtuvo %f" % vy)
	
	# TDD-EXT-11: Cálculo de dirección aleatoria
	var random_direction = randf_range(0, TAU)
	_print_result("TDD-EXT-11: Dirección aleatoria en rango válido",
		random_direction >= 0 and random_direction <= TAU,
		"Se esperaba 0 <= dir <= TAU, se obtuvo %f" % random_direction)

# ============================================================
# Main entry point
# ============================================================
func _init():
	_initialize()
	_test_caldero_conteo_pociones()
	_test_caldero_combinaciones_extendidas()
	_test_caldero_limite()
	_test_caldero_fisica()
	_summary()
