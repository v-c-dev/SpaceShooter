extends Node2D

@export var enemy_to_spawn: PackedScene # Scene of the enemy to be spawned

@onready var shapeSize = $SpawnArea/CollisionShape2D.shape.extents # Size of the area where enemies can spawn
@onready var origin = $SpawnArea/CollisionShape2D.global_position # Origin point for enemy spawn area
@onready var spawnStart = origin - shapeSize # Start position of spawn range
@onready var spawnEnd = origin + shapeSize # End position of spawn range

signal enemy_spawned(enemy) # Signal emitted when an enemy is spawned

func _ready() -> void:
	# Called when the node is added to the scene, initializing any setup
	pass

func _process(delta: float) -> void:
	# Called every frame, but not used currently
	pass

func _on_spawn_timer_timeout() -> void:
	# Randomly choose an X and Y position within the spawn area to place an enemy
	var x = randf_range(spawnStart.x, spawnEnd.x)
	var y = randf_range(spawnStart.y, spawnEnd.y)

	var enemy = enemy_to_spawn.instantiate() # Instantiate enemy scene
	enemy.position = Vector2(x, y) # Set its position to the calculated values
	call_deferred("add_child", enemy) # Add enemy to the scene later to avoid conflicts
	enemy_spawned.emit(enemy) # Emit signal to notify that an enemy was spawned

func _on_remove_area_body_entered(body: Node2D) -> void:
	# Remove the enemy when it enters the removal area (off-screen or destroyed)
	body.queue_free()
