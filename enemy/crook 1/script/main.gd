enum Dir {
    LEFT,
    RIGHT
}

enum Temper {
    AGRRO,
    CHILL,
    FEAR,
}

enum Action {
    PURSUE,
    JUMPING,
    SHOOTING,
    IDLE,
}

func _ready():
    Player.connect("SIG_PLAYER", self , "_connet")
    # Player.PLAYER.position;
    pass

func _connet():
    print("connect")
    pass

func _physics_process(delta):
    pass