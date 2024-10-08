extends CharacterBody2D

@export var speed: float= 100
@export var direction: Vector2 = Vector2.DOWN

@export var max_hp : float = 2
var current_hp : float

@export var collision_damage = 5
signal health_changed(current, max)
signal enemy_died

func _ready():
	current_hp = max_hp
	health_changed.emit(current_hp,max_hp)
	
func _process(delta):
	pass

func _physics_process(delta):
	velocity = direction.normalized() * speed
	
	look_at(position + velocity)
	rotation += PI/2
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var body = collision.get_collider()
		print("Enemy smashed into",body.name)
		if body.has_method("take_damage"):
			body.take_damage(collision_damage) 
			


func take_damage(damage):
	current_hp -= damage
	current_hp = clamp(current_hp,0,max_hp)
	health_changed.emit(current_hp, max_hp)
	if current_hp <= 0 :
		die()

func die():
	#explosion
	enemy_died.emit()
	queue_free()
