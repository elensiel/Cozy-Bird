using Godot;

public partial class PauseButton : Button
{
	private AudioStreamPlayer2D _audio;

	public override void _Ready()
	{
		_audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");

		Connect(BaseButton.SignalName.Pressed, Callable.From(OnPressed));
		Connect(Node.SignalName.TreeExiting, Callable.From(OnTreeExiting));

		Vector2 viewportSize = GetViewport().GetVisibleRect().Size;
		Size = new Vector2(viewportSize.X / 8, viewportSize.Y / 16);
		Position = new Vector2(15, 15);
	}

	private void OnPressed()
	{
		_audio.Play();
		GetOwner<GameStateMachine>().SetState(GameStateMachine.GameState.PAUSED);
	}

	private void OnTreeExiting()
	{
		Disconnect(BaseButton.SignalName.Pressed, Callable.From(OnPressed));
		Disconnect(Node.SignalName.TreeExiting, Callable.From(OnTreeExiting));
	}
}
