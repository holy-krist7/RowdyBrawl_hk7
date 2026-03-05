class_name PlayerItemNode
extends Node2D

func get_item_controller() -> ItemController:
    if get_parent() is ItemController:
        return get_parent()
    else:
        push_error("all PlayerItemNodes should be children of their ItemController")
        return null
