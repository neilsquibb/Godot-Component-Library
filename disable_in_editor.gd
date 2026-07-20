# DisableInEditor Component
# Author: Neil J. Squibb
# Created: 20 July 2026
# Last Updated: 20 July 2026

@tool 
class_name DisableInEditor
extends Node
## This component takes in a list of nodes that you want to disable the 
## movement of in the editor. This is useful to limit distracting movements in the
## editor, whilst having them still active in-game.
##
## This component toggles .emitting (for GPUParticles2D, CPUParticles2D,
## and Particles3D nodes), and .stop() (for AnimationPlayer, AnimatedSprite2D,
## AudioStreamPlayer, AudioStreamPlayer2D, AudioStreamPlayer3D, Timer, Tween,
## VideoPlayer, and AnimationTree nodes).

## The nodes you wish the disabler to apply to.
@export var selected_nodes: Array[Node]
## Toggle the disable on or off.
@export var apply: bool


func _ready() -> void:
	# ignores if no selected nodes
	if selected_nodes.is_empty():
		return
	
	# only run in the editor
	if Engine.is_editor_hint():
		toggle_disabled()

## Toggles the disabler on or off, depending on the current status of the apply bool.
func toggle_disabled() -> void:
	# Loops over the selected nodes and toggles .emiting and .stop() for nodes
	# with those methods
	for node in selected_nodes:
		if apply:
			if node.has_method("set_emitting"):
				node.emitting = false
			
			if node.has_method("stop"):
				node.stop()
		else:
			if node.has_method("set_emitting"):
				node.emitting = true
