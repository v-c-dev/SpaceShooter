extends CharacterBody2D

@export var speed: float = 400 # Movement speed of the player
@onready var current_weapon = $Weapon # Reference to the player's weapon

@export var max_hp: float = 10 # Maximum health points
var current_hp: float # Current health points

@export var collision_damage = 5 # Damage dealt when colliding with enemies

signal health_change(current, max) # Signal for health change
signal player_died # Signal emitted when the player dies

func _ready() -> void:
	# Initialize player's health and emit the initial health state
	current_hp = max_hp
	health_change.emit(current_hp, max_hp)

func _process(delta: float) -> void:
	# Handle shooting input
	if Input.is_action_pressed("shoot"):
		current_weapon.shoot()

func _physics_process(delta: float) -> void:
	# Handle movement input and update player position
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	move_and_slide()

func take_damage(damage: float) -> void:
	# Decrease the player's health and check if the player dies
	current_hp -= damage
	current_hp = clamp(current_hp, 0, max_hp) # Ensure health stays between 0 and max
	health_change.emit(current_hp, max_hp) # Emit signal for UI update
	if current_hp <= 0:
		die()

func die() -> void:
	# Called when the player's health reaches 0, triggering the death event
	explosion() # Placeholder function for an explosion action (to be defined)
	player_died.emit() # Emit signal that the player died
	queue_free() # Remove the player from the scene

func explosion():
	# Define the explosion or death animation (this is just a placeholder)
	print("Player explosion triggered")
