extends Label

func _enter_tree() -> void:
	text = "HIGH SCORE: " + str(ScoreManager.high_score)
