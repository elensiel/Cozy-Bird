using Godot;

public partial class RetryPanel : IngamePanel
{
    private AudioStreamPlayer2D Audio;
    private GameStateMachine _gameStateMachine;

    public override void _Ready()
    {
        GetTree().Paused = true;
        base._Ready();

        Audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");
        _gameStateMachine = GetParent().GetParent<GameStateMachine>();

        // connecting buttons
        GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Retry").Connect(Button.SignalName.Pressed, Callable.From(OnButtonPressedRetry));
        GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Back").Connect(Button.SignalName.Pressed, Callable.From(OnButtonPressedBack));

        // UI adjustments
        Vector2 viewportSize = GetViewport().GetVisibleRect().Size;
        Label label = GetNode<Label>("Label");
        Label Label2 = GetNode<Label>("Label2");

        Label2.Size = Label2.Size with { X = viewportSize.X };
        Label2.Position = Label2.Position with { Y = GetNode<PanelContainer>("PanelContainer").Position.Y - Label2.Size.Y };

        label.Text = GameManager.Score.ToString();
        label.Size = label.Size with { X = viewportSize.X };
        label.Position = new Vector2(0, Label2.Position.Y - label.Size.Y);

        if (GameManager.Score > GameManager.HighScore)
        {
            GameManager.HighScore = GameManager.Score;
            Label2.Visible = true;
        }
        else
        {
            Label2.Visible = false;
        }
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
        GetTree().ChangeSceneToFile("res://scene/main_menu.tscn");
    }
}
