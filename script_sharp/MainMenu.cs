using Godot;

public partial class MainMenu : Node
{
    // FOR NODE REFERENCES
    private AudioStreamPlayer2D Audio;
    private Button ButtonPlay;
    private Button ButtonQuit;
    private Label Label;

    private PackedScene Main; // for preloading

    public override void _Ready()
    {
        Main = ResourceLoader.Load<PackedScene>("res://scene/game_loop.tscn");  // preloading

        // GETS REFERENCE
        Audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");
        ButtonPlay = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Play");
        ButtonQuit = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Quit");
        Label = GetNode<Label>("Label");

        // connecting buttons
        ButtonPlay.Connect(Button.SignalName.Pressed, Callable.From(OnButtonPressedPlay));
        ButtonQuit.Connect(Button.SignalName.Pressed, Callable.From(OnButtonPressedQuit));

        Label.Text = "HIGH SCORE: " + GameManager.LoadScore().ToString();
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
}
