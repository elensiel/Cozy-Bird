extends Node

const PILLAR_SPEED: float = 150 # needed for score line

var crow : Crow
var parallax_background : ParallaxManager
var spawn_machine : SpawnMachine
var spawn_timer : Timer
var death_timer : Timer
var walls : Node
var ui_elements : UiElements
