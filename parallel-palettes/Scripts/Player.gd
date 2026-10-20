extends CharacterBody2D

@export var speed: float = 300.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var current_animation := ""

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	if direction.is_zero_approx():
		animated_sprite.stop()
		animated_sprite.frame = 0
		current_animation = ""
	else:
		var desired_animation := "walk"
		if absf(direction.x) > absf(direction.y):
			if direction.x < 0.0:
				desired_animation = _find_animation(["walk_left", "left", "Walk Left", "Left"], "walk")
			else:
				desired_animation = _find_animation(["walk_right", "right", "Walk Right", "Right"], "walk")
		elif direction.y < 0.0:
			desired_animation = "walk_up"
		if current_animation != desired_animation or not animated_sprite.is_playing():
			animated_sprite.play(desired_animation)
			current_animation = desired_animation
	move_and_slide()

func _find_animation(candidates: Array[String], fallback: String) -> String:
	for candidate in candidates:
		if animated_sprite.sprite_frames.has_animation(candidate):
			return candidate
	return fallback
