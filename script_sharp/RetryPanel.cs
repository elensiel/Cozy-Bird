using Godot;
using System;

public partial class RetryPanel : Node
{
    private AudioStreamPlayer2D Audio;
    private Button ButtonRetry;
    private Button ButtonBack;
    private GameManager GameManager;
    private Label Label;
    private Label Label2;

    public override void _Ready()
    {
        GetTree().Paused = true;
        Audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");
        ButtonRetry = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Retry");
        ButtonBack = GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Back");
        Label = GetNode<Label>("Label");
        Label2 = GetNode<Label>("Label2");

        Label.Text = GameManager.Score.ToString();

        if (GameManager.Score > GameManager.HighScore)
        {
            Label2.Visible = true;
        }
    }

    private async void OnButtonPressedRetry()
    {
        Audio.Play();
        await ToSignal(Audio, "finished");
        // TODO -- uncomment after gm is done OR test if this line is needed for the reload
        // GetParent().GetParent().SetState(GameStateMachine.GameState.PAUSED);
        GetTree().ReloadCurrentScene();
    }

    private async void OnButtonPressedBack()
    {
        Audio.Play();
        await ToSignal(Audio, "finished");
        // TODO -- test this if it works even when the scene tree is paused
        // GetTree().Paused = false;
        GetTree().ChangeSceneToFile("res://scene/main_menu.tscn");
    }
}
