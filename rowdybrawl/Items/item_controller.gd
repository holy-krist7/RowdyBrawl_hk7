class_name ItemController
extends Node2D


const UNARMED_ITEM: ItemInfo = preload("uid://cageqwiukpgo3")


@export var allItems: Array[ItemInfo]
var currentItem: Item: set = set_current_item


var allItemNodes: Dictionary[StringName, Item]


func _ready() -> void:
	if not UNARMED_ITEM in allItems:
		add_item(UNARMED_ITEM)

	currentItem = allItemNodes[UNARMED_ITEM.itemName]


func add_item(item: ItemInfo):
	if item in allItems:
		return

	allItemNodes[item.itemName] = item.itemScene.instantiate()


func set_current_item(item: Item):
	if currentItem:
		remove_child(currentItem)

	currentItem = item
	currentItem.player = get_parent()
	currentItem.itemController = self
	add_child(currentItem)
