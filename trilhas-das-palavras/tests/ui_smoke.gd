extends SceneTree

var failures: int = 0

func _initialize() -> void:
	_run.call_deferred()

func press(page: Node, text: String) -> void:
	for button in page.find_children("*", "Button", true, false):
		if button.text == text and not button.disabled:
			button.pressed.emit()
			return
	failures += 1
	push_error("Botão ativo não encontrado: " + text)

func _run() -> void:
	var ui = load("res://scenes/main.tscn").instantiate()
	root.add_child(ui)
	await process_frame
	press(ui.page, "JOGAR")
	await process_frame
	press(ui.page, "PALAVRAS")
	await process_frame
	# Exercita closures dos botões, dica, reconstrução de tela e avanço.
	press(ui.page, "MA")
	await process_frame
	press(ui.page, "TENTAR NOVAMENTE")
	await process_frame
	for index in range(5):
		var item: Dictionary = ui.session.current()
		for option in item["alternativas"]:
			if option["id"] == item["respostaCorreta"]:
				press(ui.page, option["texto"])
		await process_frame
		press(ui.page, "CONTINUAR")
		await process_frame
	if ui.screen != "finish" or ui.session.stars != 5:
		failures += 1
	press(ui.page, "JOGAR NOVAMENTE")
	await process_frame
	if ui.session.index != 0 or ui.session.stars != 0:
		failures += 1
	print("Teste da interface concluído. Falhas: ", failures)
	ui.queue_free()
	await process_frame
	quit(1 if failures else 0)
