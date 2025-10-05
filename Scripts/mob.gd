extends RigidBody2D

func _ready():
	#creamos una variable que almacenará en un array los nombres de las diferentes animaciones
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	#cogemos aleatoriamente una de estas y le damos al play
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()
	
	#esta funcion hace que cuando deje de ser visible en pantalla borre la instancia
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
