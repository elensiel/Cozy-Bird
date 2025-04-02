using Godot;

public partial class PausePanel : IngamePanel
{
    private AudioStreamPlayer2D _audio;
    private Button _continue;
    private Button _quit;

    public override void _Ready()
    {
        base._Ready();
        _audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");
        _continue = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Continue");
        _quit = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Quit");

        _continue.Connect(BaseButton.SignalName.Pressed, Callable.From(OnContinuePressed));
        _quit.Connect(BaseButton.SignalName.Pressed, Callable.From(OnQuitPressed));
        Connect(Node.SignalName.TreeExiting, Callable.From(OnTreeExiting));

        Label label = GetNode<Label>("Label");
        label.Size = label.Size with { X = GetViewport().GetVisibleRect().Size.X };
        label.Position = new Vector2(0, GetNode<PanelContainer>("PanelContainer").Position.Y - label.Size.Y);
    }

    private async void OnContinuePressed()
    {
        _audio.Play();
        await ToSignal(_audio, "finished");
        GetParent<GameStateMachine>().SetState(GameStateMachine.GameState.RUNNING);
    }
    private async void OnQuitPressed()
    {
        _audio.Play();
        await ToSignal(_audio, "finished");
        GetTree().ChangeSceneToFile("res://scene/main_menu.tscn");
    }

    private void OnTreeExiting()
    {
        _continue.Disconnect(BaseButton.SignalName.Pressed, Callable.From(OnContinuePressed));
        _quit.Disconnect(BaseButton.SignalName.Pressed, Callable.From(OnQuitPressed));
        Disconnect(Node.SignalName.TreeExiting, Callable.From(OnTreeExiting));
    }
}
