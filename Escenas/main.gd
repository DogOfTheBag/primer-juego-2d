extends Node
#exportamos esto para poder pasarle la escena que hemos creado del mob al main y que spawnee esos mobs
@export var mob_scene: PackedScene
var score

func _ready() -> void:
	new_game()
#cuando perdemos para todos los timers se paran
func game_over():
	$scoreTimer.stop()
	$mobTimer.stop()
#funcion que reinicia temporizadores, inicia el jugador y reinicia puntuaciones
func new_game():
	score = 0
	$Player.start($startPosition.position)
	$startTimer.start()

"""
Esta funcion basicamente hace el ciclo de vida de un mob
Por orden:
	Primero instanciamos al mob, que y con el path que hemos creado antes podemos hacer que 
	de forma aleatoria un mob aparezca en cualquier punto de ahi
	Después le daremos una dirección al mob para que salga desde ahi hacia el jugador
	Podemos usar radianes por defecto o bien usar una funcion que pasa los radianes a grados.
	Le pondremos un randf con rango para que elija entre esas y salgan en diferentes angulos
	lo mismo con la velocidad
	por ultimo, añadimos al mob
"""
func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $mobPath/mobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI/2
	
	direction += randf_range(-PI /4, PI /4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

#vamos sumandole 1 a los puntos con el tiempo
func _on_score_timer_timeout():
	score += 1

#cuando empezamos el timer de comienzo empiezan el de mobs y el de puntos
func _on_start_timer_timeout():
	$mobTimer.start()
	$scoreTimer.start()
