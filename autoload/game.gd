extends Node

signal crosshair_entered_enemy
signal crosshair_exited_enemy

enum GunTypes {
	PISTOL,
	AUTO,
	GRENADE,
	#..
}

# сейчас очень упрощенно
# walk - мирно гуляет, патрулирует (можно назвать patrol)
# run - гонится за игроком (можно назвать chase)
# attack - атакует.
enum NpcStates {
	IDLE,
	WALK,
	RUN,
	ATTACK,
}

# gun_type = см. GunTypes
signal shoot_gun(gun_type)

# npc - нода зомби (Kinematic)
# state - int состояние (идет, бежит, атакует..)
signal npc_state_changed(npc, state)


signal ladder_entered
signal ladder_exited

func reload_game():
	get_tree().reload_current_scene()


func _input(event):
	event = event as InputEventKey
	if not event or not event.pressed or not event.scancode == KEY_F5:
		return
	get_tree().set_input_as_handled()

	reload_game()
