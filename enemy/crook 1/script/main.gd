extends KinematicBody2D

const SPEED = 100

enum Dir {
	LEFT = -SPEED,
	RIGHT = SPEED
}

enum Temper {
	AGRRO,
	CHILL,
	FEAR,
}

enum Action {
	RUN,
	PURSUE,
	SHOOTING,
	IDLE,
}

const Action_Pack = {
	Action.IDLE: {
		"Frame": 1,
		Temper.CHILL: Action.IDLE,
		Temper.AGRRO: Action.PURSUE,
		Temper.FEAR: Action.RUN,
	},
	Action.RUN: {
		"Frame": 1,
		Temper.CHILL: Action.IDLE,
		Temper.AGRRO: Action.PURSUE,
		Temper.FEAR: Action.RUN,
	},
	Action.PURSUE: {
		"Frame": 1,
		Temper.CHILL: Action.IDLE,
		Temper.AGRRO: Action.PURSUE,
		Temper.FEAR: Action.RUN,
	},
	Action.SHOOTING: {
		"Frame": 10,
		Temper.CHILL: Action.IDLE,
		Temper.AGRRO: Action.PURSUE,
		Temper.FEAR: Action.RUN,
	}
}

onready var CROOK = $AnimatedSprite
onready var VELOCITY = Vector2()
onready var TEMPER = Temper.AGRRO
onready var ACTION = Action.IDLE
onready var ACTION_PACK = Action_Pack[ACTION]
onready var FRAME = ACTION_PACK.Frame
onready var DIR = Dir.RIGHT

func _reassign_frame():
	ACTION_PACK = Action_Pack[ACTION]
	FRAME = ACTION_PACK.Frame

func _change_action(action):
	ACTION = action
	_reassign_frame()


func _ready():
	CROOK.play("CHILL")
	# Player.connect("SIG_PLAYER", self , "_connet")
	# PLAYER = Player.PLAYER
	# print(PLAYER.position);
	pass

func _connet():
	print("connect")
	pass

func _change_dir():
	if Player.PLAYER.position.x > self.position.x:
		DIR = Dir.RIGHT
		CROOK.flip_h = true
		pass
	else:
		DIR = Dir.LEFT
		CROOK.flip_h = false
	pass

func _physics_process(delta):
	_change_dir()
	VELOCITY.y += Physics.GRAVITY * delta
	if FRAME != 0:
		FRAME -= 1
	else:
		_change_action(ACTION_PACK[TEMPER])
	_process_action()

	VELOCITY = move_and_slide(VELOCITY, Vector2.UP)

func _process_action():
	match ACTION:
		Action.IDLE:
			CROOK.play("CHILL")
		Action.PURSUE:
			VELOCITY.x = DIR
