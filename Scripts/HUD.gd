extends CanvasLayer
#esta señal la usaremos para que a la hora de pulsar el boton de inicio se mande una señal que inicie el juego
signal start_game
#funcion estandar para enseñar un mensaje con un timer que lo quita al poco tiempo
func show_message(text):
	$message.text = text
	$message.show()
	$messageTimer.start()

#funcion que se ejecuta cada vez que pierdes y que te deja reiniciar el juego
func show_game_over():
	show_message("Game Over")
	await $messageTimer.timeout
	
	$message.text = "Dodge the creeps!"
	$message.show()
	
	await get_tree().create_timer(1.0).timeout
	$startButton.show()
	#te va cambiando los puntos, se referencia en main, le pasa los puntos y los pone por pantalla
func update_score(score):
	$scoreLabel.text = "Puntos: " + str(score)

#cuando le das al boton para empezar lo esconde y emite una señal de inicio de juego para comenzar
func _on_start_button_pressed() -> void:
	$startButton.hide()
	start_game.emit()

#cuando se acaba el timer de un mensaje lo esconde.
func _on_message_timer_timeout() -> void:
	$message.hide()
