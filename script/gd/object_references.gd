extends Node

# most of the ff references are used
# in the StateMachine managing their 
# process, collision, and/or visibility

var crow : Crow
var parallax_background : ParallaxManager
var spawn_machine : SpawnMachine
var spawn_timer : Timer
var death_timer : Timer
var walls : Node
var ui_elements : UiElements
