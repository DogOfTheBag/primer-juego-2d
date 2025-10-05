extends Area2D
signal hit

#export hace que podamos modificar la variable desde el editor de la derecha
@export var speed = 400
var screen_size

"""
Detalle importante, las funciones que empiezan con una barrabaja son funciones del sistema ya creadas
por defecto en godot. _ready es una función ya hecha que se ejecuta al iniciar el juego
start por ejemplo, es una funcion que hemos hecho nosotros que se ejecuta cuando la llamamos después en el main
por eso no tiene barrabaja
"""
#le asignamos la posicion que nos pase el juego, enseñamos al jugador y le activamos la colision
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# con esto cojemos las medidas de la pantalla
func _ready():
	screen_size = get_viewport_rect().size
	
	"""
	la funcion process se ejecuta cada frame (maracado por el delta)
	de forma que siempre esta comprobando si las cosas están pasando
	aquí comprobamos el input del jugador, y dependiendo de eso lo movemos con el 
	velocity y le asignamos una animacion, rotacion del sprite...
	"""
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -=1
	if Input.is_action_pressed("move_down"):
		velocity.y +=1
	if Input.is_action_pressed("move_left"):
		velocity.x -=1
	if Input.is_action_pressed("move_right"):
		velocity.x +=1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite2D.stop()
		
	if velocity.x != 0:
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
		$AnimatedSprite2D.flip_v = false
	
	elif velocity.y != 0:
		$AnimatedSprite2D.play("up")
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
		
	#La primera linea cambia la position con la velocidad * delta
	#la segunda basicamente marca los limites de la pantalla y no te deja pasar de ahi
	position += velocity * delta
	position = position.clamp(Vector2.ZERO,screen_size)
	

"""
Basicamente esto se ejecuta cuando algo entra en la colision del jugador.
Esconde el sprite de la pantalla (se podria usar un queue_free para borrarlo directamente
emite una señal del golpe,y le quita la colision para que no haya mas golpes.)
"""
func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)
