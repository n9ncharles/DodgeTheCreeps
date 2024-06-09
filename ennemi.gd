extends RigidBody2D


func _ready():
	var type_ennemi = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(type_ennemi[randi() % type_ennemi.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
