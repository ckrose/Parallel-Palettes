extends Node2D

@onready var dialogue_box: Sprite2D = $Player/Text_box
@onready var speech: Label = $Player/Text_box/speech
@onready var wizard_portrait: Sprite2D = $Player/Text_box/Wizard_dialogue

func _ready() -> void:
	show_dialogue("Move with WASD or arrow keys.\nPress Enter or Space to close.")

func show_dialogue(line: String, speaker_portrait: Texture2D = null) -> void:
	speech.text = line
	if speaker_portrait != null:
		wizard_portrait.texture = speaker_portrait
	wizard_portrait.visible = speaker_portrait != null
	dialogue_box.show()

func hide_dialogue() -> void:
	dialogue_box.hide()

func _unhandled_input(event: InputEvent) -> void:
	if not dialogue_box.visible or not event is InputEventKey:
		return
	var key_event := event as InputEventKey
	if key_event.pressed and not key_event.echo and (
		key_event.keycode == KEY_ENTER
		or key_event.keycode == KEY_KP_ENTER
		or key_event.keycode == KEY_SPACE
	):
		hide_dialogue()
		get_viewport().set_input_as_handled()
