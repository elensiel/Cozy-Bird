using System;
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
        ButtonPlay.Connect("pressed", Callable.From(OnButtonPressedPlay), (uint)GodotObject.ConnectFlags.Deferred);
        ButtonQuit.Connect("pressed", Callable.From(OnButtonPressedQuit), (uint)GodotObject.ConnectFlags.Deferred);

        Label.Text = "HIGH SCORE: " + LoadScore().ToString();
    }

    private static int LoadScore()
    {
        string Directory = OS.GetUserDataDir() + "/save/";

        // check if folder exists
        if (!DirAccess.DirExistsAbsolute(Directory))
        {
            DirAccess.MakeDirAbsolute(Directory); // creates the folder

            FileAccess.Open(Directory + "score.bin", FileAccess.ModeFlags.Write).Store16(0);
            return 0;
        }

        return FileAccess.Open(Directory + "score.bin", FileAccess.ModeFlags.Read).Get16();
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
