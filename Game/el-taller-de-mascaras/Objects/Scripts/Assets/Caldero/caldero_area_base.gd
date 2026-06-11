extends Area3D

@export var target_height: float = 2.0 # Altura deseada en metros

func _on_body_entered(body: Node3D) -> void:
	print("entro algo")
	if body is RigidBody3D:
		print("entro u rigid3d")
		launch_object(body)

func launch_object(body: RigidBody3D):
	var target_height: float = 4.0
	var max_angle_degrees: float = 20.0 # El ángulo máximo de inclinación
	
	# 1. Gravedad
	var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	
	# 2. Velocidad vertical (Y) fija para alcanzar 4 metros
	var vy = sqrt(2 * gravity * target_height)
	
	# 3. Calcular un desplazamiento horizontal aleatorio
	# Generamos un ángulo aleatorio de 0 a 360 grados para la dirección
	var random_direction = randf_range(0, TAU) # TAU es 2*PI (un círculo completo)
	
	# Calculamos cuánta fuerza horizontal aplicar basada en el ángulo de 3°
	var angle_rad = deg_to_rad(max_angle_degrees)
	var horizontal_speed = vy * tan(angle_rad)
	
	# Convertimos la dirección aleatoria en ejes X y Z
	var vx = cos(random_direction) * horizontal_speed
	var vz = sin(random_direction) * horizontal_speed
	
	# 4. Limpiar velocidades previas
	body.linear_velocity = Vector3.ZERO
	
	# 5. Aplicar el impulso final (X aleatorio, Y fijo, Z aleatorio)
	var final_velocity = Vector3(vx, vy, vz)
	body.apply_central_impulse(final_velocity * body.mass)
	
