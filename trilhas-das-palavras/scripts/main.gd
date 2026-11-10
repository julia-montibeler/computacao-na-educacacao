extends Control

const Session = preload("res://scripts/game.gd")
const Catalog = preload("res://scripts/challenge_loader.gd")
const Audio = preload("res://scripts/audio_manager.gd")
const Trail = preload("res://scripts/trail_view.gd")

var session := Session.new()
var catalog := Catalog.new()
var audio = Audio.new()
var page: VBoxContainer
var track: String = ""
var screen: String = "menu"
var reduced_motion: bool = false
var exit_dialog: ConfirmationDialog

func _ready() -> void:
	get_tree().auto_accept_quit = false
	get_tree().quit_on_go_back = false
	var ui_theme := Theme.new()
	ui_theme.default_font_size = 28
	ui_theme.set_color("font_color", "Label", Color("203b32"))
	for kind in ["normal", "hover", "pressed", "disabled", "focus"]:
		var style := StyleBoxFlat.new()
		style.bg_color = Color("e1e5df") if kind == "disabled" else Color("315b4b")
		if kind == "hover" or kind == "pressed":
			style.bg_color = Color("436f58")
		style.set_corner_radius_all(18)
		style.content_margin_left = 22
		style.content_margin_right = 22
		style.content_margin_top = 16
		style.content_margin_bottom = 16
		if kind == "focus":
			style.bg_color = Color.TRANSPARENT
			style.border_color = Color("bf6b16")
			style.set_border_width_all(4)
		ui_theme.set_stylebox(kind, "Button", style)
	ui_theme.set_color("font_color", "Button", Color.WHITE)
	ui_theme.set_color("font_disabled_color", "Button", Color("49574e"))
	theme = ui_theme
	add_child(audio)
	exit_dialog = ConfirmationDialog.new()
	exit_dialog.title = "Voltar ao início?"
	exit_dialog.dialog_text = "Esta rodada será encerrada."
	exit_dialog.ok_button_text = "VOLTAR AO INÍCIO"
	exit_dialog.cancel_button_text = "CONTINUAR JOGANDO"
	exit_dialog.confirmed.connect(_menu)
	add_child(exit_dialog)
	if not catalog.load_catalog():
		for error in catalog.errors:
			push_error(error)
		_clear_page()
		_label("Precisamos de ajuda", 40)
		_label("Peça a um adulto para conferir os arquivos do jogo.")
		return
	_menu()

func _clear_page() -> void:
	audio.stop()
	if is_instance_valid(page):
		var previous := page.get_parent()
		remove_child(previous)
		previous.queue_free()
	var scroll := ScrollContainer.new()
	scroll.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	scroll.offset_left = 36
	scroll.offset_right = -36
	scroll.offset_top = 20
	scroll.offset_bottom = -20
	add_child(scroll)
	page = VBoxContainer.new()
	page.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	page.add_theme_constant_override("separation", 18)
	scroll.add_child(page)

func _label(value: String, font_size: int = 28) -> Label:
	var label := Label.new()
	label.text = value
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.add_theme_font_size_override("font_size", font_size)
	page.add_child(label)
	return label

func _button(value: String, callback: Callable, parent: Node = null) -> Button:
	var button := Button.new()
	button.text = value
	button.custom_minimum_size = Vector2(0, 76)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.pressed.connect(callback)
	if parent == null:
		page.add_child(button)
	else:
		parent.add_child(button)
	return button

func _settings() -> void:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 16)
	page.add_child(row)
	var sound := CheckButton.new()
	sound.text = "SOM"
	sound.button_pressed = audio.enabled
	sound.custom_minimum_size.y = 64
	sound.toggled.connect(func(value: bool) -> void: audio.set_enabled(value))
	row.add_child(sound)
	var motion := CheckButton.new()
	motion.text = "REDUZIR MOVIMENTO"
	motion.button_pressed = reduced_motion
	motion.custom_minimum_size.y = 64
	motion.toggled.connect(func(value: bool) -> void: reduced_motion = value)
	row.add_child(motion)

func _menu() -> void:
	screen = "menu"
	session.start([])
	_clear_page()
	_label("TRILHAS DAS PALAVRAS", 48)
	_label("Uma aventura para descobrir letras, palavras e pequenas frases.")
	var trail := Trail.new()
	trail.custom_minimum_size.y = 130
	page.add_child(trail)
	_button("JOGAR", _tracks)
	_label("Como jogar: observe a pista e toque em um dos três caminhos.\nSe precisar, tente outra vez. Depois, leia com alguém!", 26)
	_settings()
	_label("Protótipo • Conteúdo em revisão pela professora", 20)

func _tracks() -> void:
	screen = "tracks"
	_clear_page()
	_label("ESCOLHA SUA TRILHA", 42)
	_label("A professora pode ajudar a escolher.")
	for entry in [["sons_letras", "SONS E LETRAS"], ["palavras", "PALAVRAS"], ["frases", "FRASES"]]:
		var key: String = entry[0]
		var ready := catalog.track_ready(key)
		var button := _button(entry[1], _start.bind(key))
		button.disabled = not ready
		if not ready:
			_label("Esta trilha aguarda os áudios revisados pela professora.", 22)
	_button("INÍCIO", _menu)

func _start(value: String) -> void:
	if not catalog.track_ready(value):
		return
	track = value
	session.start(catalog.for_track(track))
	_challenge()

func _challenge() -> void:
	screen = "challenge"
	_clear_page()
	var item := session.current()
	_label("Desafio %d de %d   •   Estrelas: %d" % [session.index + 1, session.items.size(), session.stars], 24)
	var trail := Trail.new()
	trail.custom_minimum_size.y = 85
	trail.progress = float(session.stars) / session.items.size()
	page.add_child(trail)
	_label(item["enunciado"], 30)
	if not str(item.get("contexto", "")).is_empty():
		_label(item["contexto"], 26)
	var image_path: String = item.get("imagem", "")
	if not image_path.is_empty():
		var picture := TextureRect.new()
		picture.texture = load(image_path)
		picture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		picture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		picture.custom_minimum_size.y = 140
		page.add_child(picture)
	_label(item["texto"], 48)
	var feedback := _label("Toque em um caminho.", 26)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 20)
	page.add_child(row)
	var choices: Array[Button] = []
	var next := Button.new()
	for option in item["alternativas"]:
		var choice := _button(option["texto"], func() -> void:
			if session.state != Session.State.ANSWER:
				return
			var correct := session.answer(option["id"])
			for button in choices:
				button.disabled = true
			if correct:
				feedback.text = "Muito bem!  +1 estrela\n%s\nAgora leia em voz alta!" % item["textoCompleto"]
				audio.play_local(item.get("audioSolucao", ""))
				trail.move_to(float(session.stars) / session.items.size(), reduced_motion)
				next.text = "CONTINUAR"
			else:
				feedback.text = "Vamos tentar de novo?\n" + item["dica"]
				audio.play_local(item.get("audioDica", ""))
				next.text = "TENTAR NOVAMENTE"
			next.show()
		, row)
		choices.append(choice)
	var repeat := _button("OUVIR NOVAMENTE", func() -> void:
		var field := "audioSolucao" if session.state == Session.State.CORRECT else "audioEnunciado"
		audio.play_local(item.get(field, ""))
	)
	repeat.disabled = str(item.get("audioEnunciado", "")).is_empty() and str(item.get("audioSolucao", "")).is_empty()
	if repeat.disabled:
		repeat.text = "ÁUDIO EM PREPARAÇÃO"
	next.text = "CONTINUAR"
	next.custom_minimum_size.y = 76
	next.hide()
	next.pressed.connect(func() -> void:
		next.disabled = true
		if session.state == Session.State.HINT:
			session.retry()
			_challenge()
		elif session.state == Session.State.CORRECT:
			session.advance()
			if session.state == Session.State.COMPLETE:
				_finish()
			else:
				_challenge()
	)
	page.add_child(next)
	_button("VOLTAR AO INÍCIO", func() -> void: exit_dialog.popup_centered())

func _finish() -> void:
	screen = "finish"
	_clear_page()
	_label("TRILHA CONCLUÍDA!", 48)
	_label("Você conquistou %d estrelas.\nQue tal ler uma palavra ou frase para alguém?" % session.stars, 32)
	_button("JOGAR NOVAMENTE", _start.bind(track))
	_button("ESCOLHER OUTRA TRILHA", _tracks)
	_button("INÍCIO", _menu)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST or what == NOTIFICATION_WM_CLOSE_REQUEST:
		if screen == "challenge":
			exit_dialog.popup_centered()
		elif screen == "menu":
			get_tree().quit()
		else:
			_menu()
