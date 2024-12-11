using Godot;

public partial class PauseButton : Button
{
	private AudioStreamPlayer2D _audio;

	public override void _Ready()
	{
		_audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");

		_ = Connect(SignalName.Pressed, Callable.From(OnPressed));
	}

	private void OnPressed()
	{
		_audio.Play();
		GetOwner<GameStateMachine>().SetState(GameStateMachine.GameState.PAUSED);
	}
}
