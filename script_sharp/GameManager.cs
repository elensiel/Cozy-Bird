using Godot;
using System.IO;

public partial class GameManager : Node
{
    private Label _label;
    private Node _try;
    private Timer _deathTimer;

    private string _savePath = OS.GetUserDataDir() + "/save/score.bin";
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

    private int LoadScore()
    {
        string _directory = OS.GetUserDataDir() + "/save/";

        if (!Directory.Exists(_directory))
        {
            Directory.CreateDirectory(_directory);

            if (Godot.FileAccess.FileExists(_savePath))
            {
                using var file = Godot.FileAccess.Open(_savePath, Godot.FileAccess.ModeFlags.Write);
                file.Store16(0);
                return 0;
            }
        }

        using (var file = Godot.FileAccess.Open(_savePath, Godot.FileAccess.ModeFlags.Read))
        {
            return file.Get16();
        }
    }

    public void SaveHighScore()
    {
        if (HighScore > Score)
        {
            return;
        }

        HighScore = Score;
        using var file = Godot.FileAccess.Open(_savePath, Godot.FileAccess.ModeFlags.Write);
        file.Store16((ushort)HighScore);
    }

    private void OnDeathTimerTimeout()
    {
        AddChild(_try);

        _label.Visible = false;
    }
}
