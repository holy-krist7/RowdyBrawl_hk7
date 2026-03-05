extends PlayerItemNode

const SHOOT_ANIMATION := "gun_shoot"

@onready var shoot_cast: RayCast2D = %ShootCast
@export var animation_player: AnimationPlayer

@export_category("Gun Stats")
@export var shot_damage: float

var _is_shooting: bool


func _process(delta: float) -> void:
	z_index = get_item_controller().player_node.z_index

	if _is_shooting:
		handle_shot()


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action("shoot_gun"):
		_is_shooting = event.is_pressed()


func handle_shot():
	if animation_player.current_animation == SHOOT_ANIMATION\
	and animation_player.is_playing():
		return
	
	animation_player.play(SHOOT_ANIMATION)
	
	var collider: Node = shoot_cast.get_collider()
	if not collider or not collider.get_parent() is Enemy: return

	var enemy: Enemy = collider.get_parent()
	enemy.take_hit(shot_damage, Vector2.RIGHT * scale.x, 1, .2, get_item_controller().player_node)
	
