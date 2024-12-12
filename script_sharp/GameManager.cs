using Godot;
using System;
using System.IO;

public partial class GameManager : Node
{
    private Label _label;
    private Node _try;
    private Timer _deathTimer;

    public int Score = 0;
    public int HighScore;

    public override void _Ready()
    {
        _label = GetNode<Label>("Label");
        _deathTimer = GetParent().GetNode<Timer>("DeathTimer");
        _try = ResourceLoader.Load<PackedScene>("res://scene/retry_panel.tscn").Instantiate();

        _deathTimer.Connect(Timer.SignalName.Timeout, Callable.From(OnDeathTimerTimeout));

        HighScore = LoadScore();
    }

    public void IncScore()
    {
        Score += 1;
        _label.Text = Score.ToString();
    }

    // SAVING AND LOADING 
    private static string EnsureDirectoryExists()
    {
        string directory = OS.GetUserDataDir() + "/save/";
        if (!Directory.Exists(directory))
        {
            Directory.CreateDirectory(directory);
        }
        return directory;
    }

    private static Godot.FileAccess OpenFile(Godot.FileAccess.ModeFlags ModeFlags)
    {
        string savePath = EnsureDirectoryExists() + "save.bin";
        return Godot.FileAccess.Open(savePath, ModeFlags);
    }

    public static int LoadScore()
    {
        try
        {
            using var file = OpenFile(Godot.FileAccess.ModeFlags.Read);
            return file.Get16();
        }
        catch (Exception e)
        {
            GD.Print("Error loading score: " + e.Message);
            return 0;
        }
    }

    public void SaveHighScore()
    {
        if (Score > HighScore)
        {
            HighScore = Score;
            try
            {
                using var file = OpenFile(Godot.FileAccess.ModeFlags.Write);
                file.Store16((ushort)HighScore);
            }
            catch (Exception e)
            {
                GD.Print("Error loading score: " + e.Message);
            }
        }
    }

    private void OnDeathTimerTimeout()
    {
        AddChild(_try);

        _label.Visible = false;
    }
}
