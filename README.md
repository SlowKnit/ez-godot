# EZ-Godot for 2D
Utility Script for Godot 4.x 2D

# Setup
1. Make sure your Godot Project has an autoload called "Events". (required for the time function)
2. Have "left","right","up" and "down" in your input map. (required for the input function)
3. Drop the ez.gd file into the project. It does not matter where you put it, as long as it's inside res://

# Why use EZ-Godot?
This script is meant to enhance code readability, provide quick solutions to common 2D tasks and reduce coding time.

# Examples
Plain GDScript
```
await get_tree().create_timer(1.5).timeout
```
with ez.gd
```
await EŹ.time(1.5)
```

Want to turn a CanvasItem white for a split second?
```
EZ.flash(enemy)
```
or customize like:
```
EZ.flash(enemy,3.2,Color.RED, Color.GREEN).set_trans(Tween.TRANS_ELASTIC)
```
Also utilities like quicker instantiation syntax

Plain GDSCript:
```
var instance:Node = packed_scene.instantiate()
add_child(instance)
instance.global_position = target_position
```
With EZ:
```
EZ.inst_below_at(packed_scene,self,target_position)
```

There are many more QOL functions!
I suggest you read the script as its roughly 100 lines.

