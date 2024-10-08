extends Control

func _ready() -> void:
	# UI setup
	pass

func _process(delta: float) -> void:
	# Frame update if needed
	pass

func update_health(current: float, max: float) -> void:
	# Update the health bar UI based on current and maximum health
	$HealthBar.max_value = max
	$HealthBar.value = current

func update_point(points: int) -> void:
	# Update the points label with the current points
	$PointsLabel.text = str(points)

func show_player_died() -> void:
	# Display the player died UI element
	$PlayerDied.show()
