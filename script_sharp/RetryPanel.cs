using Godot;

public partial class RetryPanel : Node
{
    private AudioStreamPlayer2D Audio;
    private Button ButtonRetry;
    private Button ButtonBack;
    private GameManager _gameManager;
    private GameStateMachine _gameStateMachine;
    private Label Label;
    private Label Label2;

    public override void _Ready()
    {
        GetTree().Paused = true;

        Audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");
        ButtonRetry = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Retry");
        ButtonBack = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Back");
        _gameManager = GetParent<GameManager>();
        _gameStateMachine = GetParent().GetParent<GameStateMachine>();
        Label = GetNode<Label>("Label");
        Label2 = GetNode<Label>("Label2");

        Label.Text = _gameManager.Score.ToString();
        Label2.Visible = _gameManager.Score > _gameManager.HighScore;

        _gameManager.SaveHighScore();

        ButtonRetry.Connect(Button.SignalName.Pressed, Callable.From(OnButtonPressedRetry));
        ButtonBack.Connect(Button.SignalName.Pressed, Callable.From(OnButtonPressedBack));
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
