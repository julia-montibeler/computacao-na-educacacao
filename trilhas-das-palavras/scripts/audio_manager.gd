extends AudioStreamPlayer

var enabled: bool = true

func play_local(path: String) -> void:
	stop()
	if not enabled or path.is_empty():
		return
	var resource := load(path)
	if resource is AudioStream:
		stream = resource
		play()

func set_enabled(value: bool) -> void:
	enabled = value
	if not enabled:
		stop()

func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_PAUSED:
		stop()
