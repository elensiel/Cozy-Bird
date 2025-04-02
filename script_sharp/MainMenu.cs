using Godot;

public partial class MainMenu : Node
{
	// FOR NODE REFERENCES
	private AudioStreamPlayer2D Audio;
	private PackedScene Main; // for preloading
	private Button _play;
	private Button _quit;

	public override void _Ready()
	{
		Main = ResourceLoader.Load<PackedScene>(StringValues.gameLoop);  // preloading
		Audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");
		_play = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Play");
		_quit = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Quit");

		// connecting buttons
		_play.Connect(BaseButton.SignalName.Pressed, Callable.From(OnButtonPressedPlay));
		_quit.Connect(BaseButton.SignalName.Pressed, Callable.From(OnButtonPressedQuit));
		Connect(Node.SignalName.TreeExiting, Callable.From(OnTreeExiting));

		// UI adjustments
		Vector2 viewportSize = GetViewport().GetVisibleRect().Size;
		PanelContainer panelContainer = GetNode<PanelContainer>("PanelContainer");
		Label label = GetNode<Label>("Label");
		Sprite2D sprite = GetNode<Sprite2D>("Sprite2D");

		panelContainer.Position = (viewportSize / 2) - (panelContainer.Size / 2);

		label.Text = "HIGH SCORE: " + GameManager.LoadScore().ToString();
		label.Position = label.Position with { X = (viewportSize.X / 2) - (label.Size.X / 2) };
		label.Position = label.Position with { Y = panelContainer.Position.Y - label.Size.Y };

		sprite.Scale = sprite.Scale with { X = viewportSize.X * 2 / sprite.Texture.GetWidth() };
		sprite.Scale = sprite.Scale with { Y = viewportSize.Y / sprite.Texture.GetHeight() };
		sprite.Position = sprite.Position with { X = viewportSize.X };
		sprite.Position = sprite.Position with { Y = viewportSize.Y / 2 };
	}

	private async void OnButtonPressedPlay()
	{
		Audio.Play();
		await ToSignal(Audio, "finished");
		GetTree().ChangeSceneToPacked(Main);
	}

	private void OnButtonPressedQuit()
	{
		Audio.Play();
		GetTree().Quit();
	}

	private void OnTreeExiting()
	{
		_play.Disconnect(BaseButton.SignalName.Pressed, Callable.From(OnButtonPressedPlay));
		_quit.Disconnect(BaseButton.SignalName.Pressed, Callable.From(OnButtonPressedQuit));
		Disconnect(Node.SignalName.TreeExiting, Callable.From(OnTreeExiting));
	}
}
