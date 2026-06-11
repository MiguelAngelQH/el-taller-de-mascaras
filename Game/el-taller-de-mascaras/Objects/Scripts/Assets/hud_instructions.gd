extends CanvasLayer

# Esta variable controla si está abierto o cerrado
var isShowInstructions : bool = true

func _ready() -> void:
	$Hud.hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Instructions") || Input.is_action_just_pressed("ui_cancel"):
		# 1. Si NO tengo el diario en el Global, corto aquí.
		if !Global.has_diary:
			return
		
		# 2. Invierto el valor: Si era false ahora es true, y viceversa.
		isShowInstructions = !isShowInstructions
		
		# 3. Llamo a la función visual
		cambiar_visibilidad()

func cambiar_visibilidad() -> void:
	if isShowInstructions:
		$Hud.show()
		# Hardcodeamos el mouse aquí mismo
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 
		# Avisamos al global SOLO para que el personaje se detenga
	else:
		$Hud.hide()
		# Hardcodeamos el mouse aquí mismo
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
