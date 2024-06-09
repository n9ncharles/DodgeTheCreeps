extends Area2D

signal hit

@export var vitesse = 400 # La vitesse de déplacement du joueur (pixels/sec).
var taille_ecran

func _ready():
	taille_ecran = get_viewport_rect().size
	hide()

func _process(delta):
	var rapidite = Vector2.ZERO # Le vecteur de mouvement du joueur.
	
	if Input.is_action_pressed("bouger_a_droite"):
		rapidite.x += 1
	if Input.is_action_pressed("bouger_a_gauche"):
		rapidite.x -= 1
	if Input.is_action_pressed("bouger_en_haut"):
		rapidite.y -= 1
	if Input.is_action_pressed("bouger_en_bas"):
		rapidite.y += 1
	
	if rapidite.length() > 0:
		rapidite = rapidite.normalized() * vitesse
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += rapidite * delta
	position = position.clamp(Vector2.ZERO, taille_ecran)
	
	if rapidite.x != 0:
		$AnimatedSprite2D.animation = "Marcher"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = rapidite.x < 0
	elif rapidite.y != 0:
		$AnimatedSprite2D.animation = "en_Haut"
		$AnimatedSprite2D.flip_v = rapidite.y > 0

	if rapidite.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false


func _on_body_entered(body):
	hide() # Le joueur disparaît après avoir été touché.
	hit.emit()

	$CollisionShape2D.set_deferred("disabled", true)

func commencer(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
