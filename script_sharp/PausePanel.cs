using Godot;

public partial class PausePanel : IngamePanel
{
    private AudioStreamPlayer2D _audio;

    public override void _Ready()
    {
        base._Ready();
        _audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");

        Button _continue = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Continue");
        Button _quit = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Quit");
        _continue.Connect(Button.SignalName.Pressed, Callable.From(OnContinuePressed));
        _quit.Connect(Button.SignalName.Pressed, Callable.From(OnQuitPressed));

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
}
