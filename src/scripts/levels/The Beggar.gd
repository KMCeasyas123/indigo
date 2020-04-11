extends Node2D

func _ready():
    get_node('/root/GameState').unlock_exit()
