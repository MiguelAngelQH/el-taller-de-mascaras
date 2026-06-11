extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
var displayName = "Diary"
func interact():
	queue_free()
	Global.has_diary = true
	var hud = get_tree().root.find_child("Hud", true, false)
	hud.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
