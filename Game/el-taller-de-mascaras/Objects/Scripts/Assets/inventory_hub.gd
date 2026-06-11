extends CanvasLayer

var isShowInventory : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Inventory.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Inventory"):
		isShowInventory = !isShowInventory
		cambiar_visibilidad()

func cambiar_visibilidad() -> void:
	if isShowInventory :
		$Inventory.show()
		Global.isInventary = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 
		# Avisamos al global SOLO para que el personaje se detenga
	else:
		$Inventory.hide()
		Global.isInventary = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
