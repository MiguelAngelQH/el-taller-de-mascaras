extends WorldEnvironment

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Global.DialogicStart("res://Objects/Escenes/escene1timeline.dtl")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float)-> void:
	pass
