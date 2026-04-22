extends Node

signal SIG_PLAYER(num)

var PLAYER = null

func emit():
	emit_signal("SIG_PLAYER", 69)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
