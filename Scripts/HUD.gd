extends CanvasLayer

signal start_game

func show_message(text):
	$message.text = text
	$message.show()
	$messageTimer.start()


func show_game_over():
	show_message("Game Over")
	await $messageTimer.timeout
	
	$message.text = "Dodge the creeps!"
	$message.show()
	
	await get_tree().create_timer(1.0).timeout
	$startButton.show
	
func update_score(score):
	$scoreLabel.text = str(score)


func _on_start_button_pressed() -> void:
	$startButton.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$message.hide()
