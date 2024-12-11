using Godot;

public partial class PausePanel : Node
{
    private AudioStreamPlayer2D _audio;
    private Button _continue;
    private Button _quit;

    public override void _Ready()
    {
        _audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");
        _continue = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Continue");
        _quit = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Quit");

        _continue.Connect(Button.SignalName.Pressed, Callable.From(OnContinuePressed));
        _quit.Connect(Button.SignalName.Pressed, Callable.From(OnQuitPressed));
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
