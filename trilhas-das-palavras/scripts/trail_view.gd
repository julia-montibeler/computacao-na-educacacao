extends Control
## Cenário vetorial simples; sem texturas externas ou física.

var progress: float = 0.0
var tween: Tween

func move_to(value: float, reduced: bool) -> void:
	if tween:
		tween.kill()
	if reduced:
		progress = value
		queue_redraw()
	else:
		tween = create_tween()
		tween.tween_method(_set_progress, progress, value, 0.35)

func _set_progress(value: float) -> void:
	progress = value
	queue_redraw()

func _draw() -> void:
	var left := Vector2(50, size.y * 0.58)
	var right := Vector2(size.x - 50, size.y * 0.58)
	draw_line(left, right, Color("d5bd8d"), 18.0, true)
	for step in range(6):
		var point := left.lerp(right, float(step) / 5.0)
		draw_circle(point, 11, Color("698b63"))
	var actor := left.lerp(right, clampf(progress, 0, 1))
	draw_circle(actor + Vector2(0, -19), 22, Color("315b4b"))
	draw_circle(actor + Vector2(-7, -23), 3, Color.WHITE)
	draw_circle(actor + Vector2(7, -23), 3, Color.WHITE)
	draw_arc(actor + Vector2(0, -20), 9, 0.2, PI - 0.2, 12, Color.WHITE, 2, true)
