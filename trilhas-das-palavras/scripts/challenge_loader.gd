class_name ChallengeLoader
extends RefCounted

const TRACKS := ["sons_letras", "palavras", "frases"]
var errors: Array[String] = []
var items: Array = []

func load_catalog(path: String = "res://data/desafios.json") -> bool:
	errors.clear()
	items.clear()
	if not FileAccess.file_exists(path):
		errors.append("Catálogo ausente: " + path)
		return false
	var parser := JSON.new()
	if parser.parse(FileAccess.get_file_as_string(path)) != OK:
		errors.append("JSON inválido: " + parser.get_error_message())
		return false
	var root: Variant = parser.data
	if not root is Dictionary:
		errors.append("A raiz deve ser um objeto.")
		return false
	if root.get("versaoSchema") != 1 or not root.get("desafios") is Array:
		errors.append("Versão ou lista de desafios inválida.")
		return false
	var ids := {}
	for raw in root["desafios"]:
		if not raw is Dictionary:
			errors.append("Registro não é objeto.")
			continue
		var item: Dictionary = raw
		var key := str(item.get("id", ""))
		for field in ["id", "trilha", "habilidade", "enunciado", "textoCompleto", "dica"]:
			if not item.get(field) is String or str(item.get(field, "")).strip_edges().is_empty():
				errors.append(key + ": campo inválido: " + field)
		if ids.has(key):
			errors.append("ID duplicado: " + key)
		ids[key] = true
		if not item.get("trilha") in TRACKS:
			errors.append(key + ": trilha inválida")
		if not item.get("texto") is String:
			errors.append(key + ": texto deve ser string")
		var options: Variant = item.get("alternativas")
		if not options is Array or options.size() != 3:
			errors.append(key + ": são necessárias três alternativas")
			continue
		var option_ids := {}
		for option in options:
			if not option is Dictionary:
				errors.append(key + ": alternativa inválida")
				continue
			var option_id := str(option.get("id", ""))
			if option_id.is_empty() or option_ids.has(option_id):
				errors.append(key + ": ID de alternativa vazio ou duplicado")
			option_ids[option_id] = true
			if not option.get("texto") is String or str(option.get("texto", "")).strip_edges().is_empty():
				errors.append(key + ": alternativa sem texto")
		if not option_ids.has(item.get("respostaCorreta")):
			errors.append(key + ": resposta não corresponde às alternativas")
		for field in ["imagem", "audioEnunciado", "audioSolucao", "audioDica"]:
			var media: Variant = item.get(field, "")
			if not media is String:
				errors.append(key + ": mídia deve ser caminho textual")
			elif not media.is_empty() and (not media.begins_with("res://assets/") or not ResourceLoader.exists(media)):
				errors.append(key + ": recurso ausente ou externo: " + media)
		items.append(item)
	if items.is_empty():
		errors.append("Catálogo vazio.")
	if not errors.is_empty():
		items.clear()
	return errors.is_empty()

func for_track(track: String) -> Array:
	return items.filter(func(item: Dictionary) -> bool: return item["trilha"] == track)

func track_ready(track: String) -> bool:
	var challenges := for_track(track)
	if challenges.is_empty():
		return false
	# Não apresentar tarefa fonêmica sem a referência sonora revisada.
	if track == "sons_letras":
		for item in challenges:
			if str(item.get("audioEnunciado", "")).is_empty():
				return false
	return true
