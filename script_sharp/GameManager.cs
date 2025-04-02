using Godot;
using System;
using System.IO;

public partial class GameManager : Node
{
    private Label _label;
    private Node _try;

    static public int Score = 0;
    static public int HighScore;

    public override void _Ready()
    {
        _label = GetNode<Label>("Label");
        _try = ResourceLoader.Load<PackedScene>(StringValues.retryPanel).Instantiate();

        GetParent().GetNode<Timer>("DeathTimer").Connect(Timer.SignalName.Timeout, Callable.From(OnDeathTimerTimeout));
        Connect(Node.SignalName.TreeExiting, Callable.From(OnTreeExiting));

        Score = 0; // reset  cuz its fxxking static u idiot
        HighScore = LoadScore();

        Vector2 viewportSize = GetViewport().GetVisibleRect().Size;
        _label.Position = new Vector2((viewportSize.X / 2) - (_label.Size.X / 2), viewportSize.Y / 5);
    }

    public void IncScore()
    {
        Score += 1;
        _label.Text = Score.ToString();
    }

    // SAVING AND LOADING 
    public static string EnsureDirectoryExists()
    {
        string directory = OS.GetUserDataDir() + "/resource/";
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
            try
            {
                using var file = OpenFile(Godot.FileAccess.ModeFlags.Write);
                file.Store16((ushort)Score);
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

    private void OnTreeExiting()
    {
        GetParent().GetNode<Timer>("DeathTimer").Disconnect(Timer.SignalName.Timeout, Callable.From(OnDeathTimerTimeout));
        Disconnect(Node.SignalName.TreeExiting, Callable.From(OnTreeExiting));
    }
}