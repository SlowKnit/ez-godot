class_name EZ

## EZ - Easy Utility Script
## Collection of helper functions to reduce code length and enhance readability

#region INPUT

## Returns input as Vector2 lol.
## "left", "right", "up", "down"
static func get_dir_input() -> Vector2:
	var direction:Vector2 = Input.get_vector("left","right","up","down").normalized()
	return direction
#endregion


#region VFX

## Sets the Node2Ds scale to the factor. Then over tween_time seconds,
## the target is scaled back to 1.
static func pop(target:CanvasItem ,factor:float = 1.06, tween_time:float = .1) -> PropertyTweener:
	var tween:Tween = target.create_tween()
	target.scale = Vector2.ONE*factor
	return tween.tween_property(target,"scale",Vector2.ONE,tween_time)


## Flash effect. Briefly turns the target white.
## use like:
## EZ.flash(enemy)
## or customize like:
## EZ.flash(enemy,3.2,Color.RED, Color.GREEN).set_trans(Tween.TRANS_ELASTIC)
static func flash(target:CanvasItem, tween_time:float = .1, modulate:Color = Color.WHITE,
			normal_modulate:Color = Color.WHITE) -> PropertyTweener:
	var tween:Tween = target.create_tween()
	target.modulate = modulate * 100
	return tween.tween_property(target,"modulate",normal_modulate,tween_time)


static func flash_not_children(target:CanvasItem, tween_time:float = .1, modulate:Color = Color.WHITE,
			normal_modulate:Color = Color.WHITE) -> PropertyTweener:
	var tween:Tween = target.create_tween()
	target.self_modulate = modulate
	return tween.tween_property(target,"self_modulate",normal_modulate,tween_time)


static func flicker(target:CanvasItem, flicker_time:float = .05) -> void:
	for i:int in 5:
		await EZ.time(flicker_time)
		target.hide()
		await EZ.time(flicker_time)
		target.show()
	return

#endregion


#region LOGIC

## Returns true if two have the same id and are not null.
static func are_same(obj1:Object, obj2:Object) -> bool:
	if not is_instance_valid(obj1) or not is_instance_valid(obj2):
		return false
	return obj1.get_instance_id() == obj2.get_instance_id()

#endregion


#region TOOLS

##returns the closest Node2D from an array to the position
static func get_closest(global_position:Vector2, node_array:Array) -> Node2D:
	var closest:Node2D = null
	var min_dist:float = INF
	node_array = clear_nulls(node_array)
	for node:Node2D in node_array:
		if node == null or not is_instance_valid(node):
			continue
		var dist:float
		dist = global_position.distance_to(node.global_position)
		
		if dist < min_dist:
			closest = node
			min_dist = dist
	
	return closest

## Shorter Syntax for Simple SceneTreeTimer.
## instead of await get_tree().create_timer(.1).timeout just use:
## await EZ.time(.1)
static func time(float_time:float) -> void:
	await Events.get_tree().create_timer(float_time).timeout
	return


## Yeah it just clears nulls
static func clear_nulls(arr:Array) -> Array:
	return arr.filter(func(object:Variant) -> bool:
			return is_instance_valid(object))


## Quick instantiation of a PackedScene
static func inst_below(packed:PackedScene, parent:Node) -> Node:
	var instance:Node = packed.instantiate()
	parent.call_deferred("add_child", instance)
	return instance


## Instantiates a Node2D below , then sets the global position.
static func inst_below_at(packed:PackedScene, parent:Node, global_pos:Vector2) -> Node2D:
	var instance:Node2D = inst_below(packed, parent)
	instance.global_position = global_pos
	return instance

#endregion
