extends SceneTree

const Session = preload("res://scripts/game.gd")
const Catalog = preload("res://scripts/challenge_loader.gd")
var failures: int = 0

func check(condition: bool, message: String) -> void:
	if not condition:
		failures += 1
		push_error(message)

func _initialize() -> void:
	var catalog := Catalog.new()
	check(catalog.load_catalog(), "Catálogo deve carregar: " + str(catalog.errors))
	for track in Catalog.TRACKS:
		check(catalog.for_track(track).size() == 5, "Cinco itens por trilha")
	check(not catalog.track_ready("sons_letras"), "Fonemas sem áudio devem bloquear a trilha")
	var session := Session.new()
	session.start(catalog.for_track("palavras"))
	check(not session.answer("inexistente"), "ID desconhecido deve ser rejeitado")
	check(session.state == Session.State.ANSWER, "ID desconhecido preserva estado")
	check(not session.answer("b"), "Erro não deve ser aceito")
	check(session.stars == 0 and session.index == 0, "Erro preserva progresso")
	check(not session.answer("a"), "Resposta bloqueada durante dica")
	session.retry()
	check(session.answer("a"), "Acerto após tentativa deve ser aceito")
	check(not session.answer("a") and session.stars == 1, "Acerto repetido não duplica estrela")
	session.advance()
	session.advance()
	check(session.index == 1, "Continuar repetido não pula item")
	while session.state == Session.State.ANSWER:
		session.answer(session.current()["respostaCorreta"])
		session.advance()
	check(session.state == Session.State.COMPLETE and session.stars == 5, "Conclusão com cinco estrelas")
	session.start(catalog.for_track("frases"))
	check(session.stars == 0 and session.index == 0 and session.completed.is_empty(), "Nova sessão limpa progresso")
	check(session.current()["trilha"] == "frases", "Troca seleciona conteúdo correto")
	# Exercita o loader real contra dados corrompidos, sem alterar o catálogo fonte.
	var original: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/desafios.json"))
	for corruption in ["duplicate", "answer", "options", "media"]:
		var broken: Dictionary = original.duplicate(true)
		match corruption:
			"duplicate": broken["desafios"][1]["id"] = broken["desafios"][0]["id"]
			"answer": broken["desafios"][0]["respostaCorreta"] = "z"
			"options": broken["desafios"][0]["alternativas"].pop_back()
			"media": broken["desafios"][0]["imagem"] = "res://assets/ausente.svg"
		var file := FileAccess.open("user://catalog-test.json", FileAccess.WRITE)
		file.store_string(JSON.stringify(broken))
		file.close()
		check(not catalog.load_catalog("user://catalog-test.json"), "Rejeitar catálogo: " + corruption)
		check(catalog.items.is_empty(), "Não usar catálogo parcialmente inválido")
	DirAccess.remove_absolute("user://catalog-test.json")
	print("Testes concluídos. Falhas: ", failures)
	quit(1 if failures else 0)
