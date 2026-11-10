class_name GameSession
extends RefCounted
## Estado puro: nenhuma cena, áudio ou temporizador altera a pontuação.

enum State { IDLE, ANSWER, HINT, CORRECT, COMPLETE }

var state: State = State.IDLE
var items: Array = []
var index: int = 0
var stars: int = 0
var completed: Dictionary = {}

func start(challenges: Array) -> void:
	items = challenges.duplicate(true)
	index = 0
	stars = 0
	completed.clear()
	state = State.ANSWER if not items.is_empty() else State.IDLE

func current() -> Dictionary:
	if items.is_empty() or index >= items.size():
		return {}
	return items[index]

func answer(option_id: String) -> bool:
	if state != State.ANSWER:
		return false
	var item := current()
	var known := false
	for option in item["alternativas"]:
		if option["id"] == option_id:
			known = true
	if not known:
		return false
	if option_id != item["respostaCorreta"]:
		state = State.HINT
		return false
	if not completed.has(item["id"]):
		completed[item["id"]] = true
		stars += 1
	state = State.CORRECT
	return true

func retry() -> void:
	if state == State.HINT:
		state = State.ANSWER

func advance() -> void:
	if state != State.CORRECT:
		return
	index += 1
	state = State.COMPLETE if index >= items.size() else State.ANSWER
