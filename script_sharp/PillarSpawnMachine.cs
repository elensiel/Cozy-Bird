using Godot;

public partial class PillarSpawnMachine : Node
{
    private PackedScene _pillar = ResourceLoader.Load<PackedScene>("res://scene/pillar.tscn");
    private Area2D _pillarTemp;
    private Timer _timer;
    private Area2D _despawn;

    public override void _Ready()
    {
        _timer = GetNode<Timer>("Timer");
        _despawn = GetNode<Area2D>("Despawn");

        Vector2 Position = _despawn.Position;
        Position.X -= GetViewport().GetVisibleRect().Size.X / 2;
        _despawn.Position = Position;

        _timer.Connect(Timer.SignalName.Timeout, Callable.From(OnTimerTimeout));
        _despawn.Connect(Area2D.SignalName.AreaEntered, Callable.From((Area2D area) => OnDespawnAreaEntered(area)));
    }

    private void SpawnPillar()
    {
        _pillarTemp = (Area2D)_pillar.Instantiate();
        _pillarTemp.Position = new Vector2(GetViewport().GetVisibleRect().End.X + 200, GD.RandRange(240, 480 - 40));
        AddChild(_pillarTemp);
    }

    private void OnTimerTimeout()
    {
        SpawnPillar();
    }

    private static void OnDespawnAreaEntered(Area2D area)
    {
        area.QueueFree();
    }
}
