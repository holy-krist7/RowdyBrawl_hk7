class_name ItemController
extends Node2D


@export var player_node: player

@export var starting_items: Array[PlayerItem]
var all_items: Array[PlayerItem]
var current_item: PlayerItem


func _ready() -> void:
    for starting_item in starting_items:
        add_item(starting_item.duplicate())

    
func _exit_tree() -> void:
    # deletes all stored item nodes
    if is_queued_for_deletion():
        for item in all_items:
            item.active_node.queue_free()
    

func equip_item(index: int):
    if current_item:
        unequip_current_item()

    current_item = all_items[index]
    add_child(current_item.active_node)


    
func unequip_current_item():
    if current_item:
        remove_item_node(current_item)
    
    current_item = null
    


func add_item(item: PlayerItem):
    all_items.append(item)
    item.active_node = item.item_scene.instantiate()


func remove_item(index: int):
    all_items.pop_at(index).active_node.queue_free()


func remove_item_node(item: PlayerItem):
    if not item.active_node:
        push_warning("item does not have an active node")
        return
    
    # removes the item node from tree
    var active_item_node_index := get_children().find(item.active_node)
    if active_item_node_index != -1:
        remove_child(get_child(active_item_node_index))
    else: 
        push_warning("item._active_node was not found in children")
    

