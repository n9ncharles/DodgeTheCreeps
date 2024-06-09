extends CanvasLayer

signal debut_jeu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func afficher_message(texte):
	$Message.text = texte
	$Message.show()
	$TempsMessage.start()

func afficher_game_over():
	afficher_message("Game Over")
	
	# Attendez que le TempsMessage ait terminé le compte à rebours.
	await $TempsMessage.timeout
	
	$Message.text = "Dogde the Creeps!"
	$Message.show()
	
	# Créez un chronomètre unique et attendez qu'il se termine.
	await get_tree().create_timer(1.0).timeout
	$BoutonDebut.show()
	
func maj_score(score):
	$ScoreEtiquette.text = str(score)


func _on_bouton_debut_pressed():
	$BoutonDebut.hide()
	debut_jeu.emit()


func _on_temps_message_timeout():
	$Message.hide()
