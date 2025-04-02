using Godot;

public partial class RetryPanel : IngamePanel
{
    private AudioStreamPlayer2D Audio;
    private GameStateMachine _gameStateMachine;
    private Button _retry;
    private Button _back;

    public override void _Ready()
    {
        GetTree().Paused = true;
        base._Ready();

        Audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");
        _gameStateMachine = GetParent().GetParent<GameStateMachine>();
        _retry = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Retry");
        _back = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Back");

        // connecting buttons
        _retry.Connect(BaseButton.SignalName.Pressed, Callable.From(OnButtonPressedRetry));
        _back.Connect(BaseButton.SignalName.Pressed, Callable.From(OnButtonPressedBack));
        Connect(Node.SignalName.TreeExiting, Callable.From(OnTreeExiting));

        // UI adjustments
        Vector2 viewportSize = GetViewport().GetVisibleRect().Size;
        Label label = GetNode<Label>("Label");
        Label Label2 = GetNode<Label>("Label2");

        Label2.Size = Label2.Size with { X = viewportSize.X };
        Label2.Position = Label2.Position with { Y = GetNode<PanelContainer>("PanelContainer").Position.Y - Label2.Size.Y };

        label.Text = GameManager.Score.ToString();
        label.Size = label.Size with { X = viewportSize.X };
        label.Position = new Vector2(0, Label2.Position.Y - label.Size.Y);

        bool newHighScore = GameManager.Score > GameManager.HighScore;
        if (newHighScore)
        {
            GameManager.Score = GameManager.HighScore;
        }
        Label2.Visible = newHighScore;
    }

    private async void OnButtonPressedRetry()
    {
        Audio.Play();
        await ToSignal(Audio, "finished");
        _gameStateMachine.SetState(GameStateMachine.GameState.PAUSED);
        GetTree().ReloadCurrentScene();
    }

    private async void OnButtonPressedBack()
    {
        Audio.Play();
        await ToSignal(Audio, "finished");
        GetTree().Paused = false;
        GetTree().ChangeSceneToFile(StringValues.mainMenu);
    }

    private void OnTreeExiting()
    {
        _retry.Disconnect(BaseButton.SignalName.Pressed, Callable.From(OnButtonPressedRetry));
        _back.Disconnect(BaseButton.SignalName.Pressed, Callable.From(OnButtonPressedBack));
        Disconnect(Node.SignalName.TreeExiting, Callable.From(OnTreeExiting));
    }
}
