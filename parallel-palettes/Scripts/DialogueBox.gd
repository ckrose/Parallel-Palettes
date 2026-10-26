extends CanvasLayer

@export var starting_text: String = ""
@export var starting_portrait: Texture2D

@onready var portrait: Sprite2D = $WizardPortrait
@onready var text_box: Sprite2D = $TextBox
@onready var dialogue_text: Label = $TextBox/DialogueText

func _ready() -> void:
	get_viewport().size_changed.connect(_layout)
	_layout()
	if starting_text.is_empty():
		hide_dialogue()
	else:
		show_dialogue(starting_text, starting_portrait)

func _layout() -> void:
	var view_size := get_viewport().get_visible_rect().size
	var box_size := text_box.texture.get_size()
	var fit_scale := minf(view_size.x * 0.92 / box_size.x, view_size.y * 0.50 / box_size.y)
	text_box.scale = Vector2.ONE * fit_scale
	text_box.position = Vector2(view_size.x * 0.5, view_size.y - box_size.y * fit_scale * 0.5 - 12.0)

	var box_top := view_size.y - box_size.y * fit_scale - 12.0
	portrait.scale = Vector2.ONE * clampf(fit_scale * 2.2, 0.7, 1.5)
	portrait.position = Vector2(view_size.x * 0.13, box_top + 24.0)
	dialogue_text.add_theme_font_size_override("font_size", maxi(18, roundi(32.0 / fit_scale)))

func show_dialogue(line: String, speaker_portrait: Texture2D = null) -> void:
	dialogue_text.text = line
	dialogue_text.add_theme_color_override("font_color", Color.BLACK)
	portrait.texture = speaker_portrait
	portrait.visible = speaker_portrait != null
	visible = true

func hide_dialogue() -> void:
	visible = false
