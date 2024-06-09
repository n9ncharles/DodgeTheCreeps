extends Node

@export var scene_ennemi: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$TempsScore.stop()
	$TempsEnnemis.stop()
	
	$HUD.afficher_game_over()
	
	$Musique.stop()
	$Game_Over_Musique.play()

func nouvelle_partie():
	score = 0
	$Joueur.commencer($PositionDepart.position)
	$TempsDepart.start()
	
	$HUD.maj_score(score)
	$HUD.afficher_message("Preparer-vous")
	
	get_tree().call_group("mobs", "queue_free")
	
	$Musique.play()

func _on_temps_score_timeout():
	score += 1
	$HUD.maj_score(score)

func _on_temps_depart_timeout():
	$TempsEnnemis.start()
	$TempsScore.start()
	
func _on_temps_ennemis_timeout():
	# Créez une nouvelle instance de la scène ennemi.
	var enne = scene_ennemi.instantiate()
	
	# Choisir un emplacement aléatoire sur Path2D.
	var lieu_apparition_ennemi = $Path2D/LieuApparitionEnnemis
	lieu_apparition_ennemi.progress_ratio = randf()
	
	# Définir la direction perpendiculairement à la direction du chemin.
	var direction = lieu_apparition_ennemi.rotation + PI / 2
	
	# Définissez la position de la foule à un emplacement aléatoire.
	enne.position = lieu_apparition_ennemi.position
	
	# Ajoutez un peu de hasard à la direction.
	direction += randf_range(-PI / 4, PI /4)
	enne.rotation = direction
	
	# Choisir la vitesse de la foule.
	var rapidite = Vector2(randf_range(150.0, 250.0), 0.0)
	enne.linear_velocity = rapidite.rotated(direction)
	
	add_child(enne)
