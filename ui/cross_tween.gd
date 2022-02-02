extends Tween

onready var bottom = $"../Bottom"
onready var top = $"../Top"
onready var right = $"../Right"
onready var left = $"../Left"

onready var bottom_default
onready var top_default
onready var right_default
onready var left_default

var is_calming_down = false

#Todo: rename to  ..
func set_inaccuracity(value:int, time:float= 0.3):
#	__ = interpolate_property(bottom,	"rect_position", bottom.rect_position,	bottom_default+Vector2.DOWN*value,	time, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
#	__ = interpolate_property(top,		"rect_position", top.rect_position, 	top_default+Vector2.UP*value,		time, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
#	__ = interpolate_property(right,	"rect_position", right.rect_position,	right_default+Vector2.RIGHT*value,	time, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
#	__ = interpolate_property(left,		"rect_position", left.rect_position,	left_default+Vector2.LEFT*value,	time, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)

	interpolate_property(bottom,	"rect_position", bottom.rect_position,	bottom_default+Vector2.DOWN*value,	time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	interpolate_property(top,		"rect_position", top.rect_position, 	top_default+Vector2.UP*value,		time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	interpolate_property(right,	"rect_position", right.rect_position,	right_default+Vector2.RIGHT*value,	time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	interpolate_property(left,		"rect_position", left.rect_position,	left_default+Vector2.LEFT*value,	time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	start()

func set_inaccuracity_no_anim(value):
	bottom.rect_position =	bottom_default+Vector2.DOWN*value
	top.rect_position =		top_default+Vector2.UP*value
	right.rect_position =	right_default+Vector2.RIGHT*value
	left.rect_position =	left_default+Vector2.LEFT*value
	

func _ready():
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")

	bottom_default = bottom.rect_position
	top_default = top.rect_position
	right_default = right.rect_position
	left_default = left.rect_position
	


func animate_cross_recoil():
	stop_all()
	set_inaccuracity(10, 0.05)
	yield(self, "tween_completed")
	yield(get_tree(),"idle_frame")
	stop_all()
	set_inaccuracity(0, 0.2)


func animate_cross_reload(time:=0.3):
	get_owner()
	var __
	__ = interpolate_property(owner, "rect_rotation", owner.rect_rotation,	stepify(owner.rect_rotation+360, 360),	time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)


	start()


func _input(event):
	event = event as InputEventMouseButton
	if not event or not event.is_pressed(): return
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE: return
	match event.button_index:
		BUTTON_LEFT:
			animate_cross_recoil()
		BUTTON_RIGHT:
			$"../AnimationPlayer".play("cross reload")
