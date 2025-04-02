using Godot;

public partial class PillarSpawnMachine : Node
{
    private PackedScene _pillar = ResourceLoader.Load<PackedScene>(StringValues.pillar);
    private Area2D _pillarTemp;
    private Rect2 _viewport;

    public override void _Ready()
    {
        Area2D _despawn = GetNode<Area2D>("Despawn");
        _viewport = GetViewport().GetVisibleRect();

        Vector2 Position = _despawn.Position;
        Position.X -= _viewport.Size.X / 2;
        _despawn.Position = Position;

        GetNode<Timer>("Timer").Connect(Timer.SignalName.Timeout, Callable.From(OnTimerTimeout));
        _despawn.Connect(Area2D.SignalName.AreaEntered, Callable.From((Area2D area) => OnDespawnAreaEntered(area)));
        Connect(Node.SignalName.TreeExiting, Callable.From(OnTreeExiting));
    }

    private void SpawnPillar()
    {
        _pillarTemp = (Area2D)_pillar.Instantiate();
        float viewportWidth = _viewport.Size.Y;

        _pillarTemp.Position = _pillarTemp.Position with { X = _viewport.End.X + 200 };
        _pillarTemp.Position = _pillarTemp.Position with { Y = (float)GD.RandRange(_viewport.Position.Y + (viewportWidth / 3), viewportWidth - (viewportWidth / 4)) };

        AddChild(_pillarTemp);
    }

    private void OnTimerTimeout()
    {
        SpawnPillar();
    }

    private static void OnDespawnAreaEntered(Area2D area)
    {
        area.Owner = null;
        area.QueueFree();
    }

    private void OnTreeExiting()
    {
        GetNode<Timer>("Timer").Disconnect(Timer.SignalName.Timeout, Callable.From(OnTimerTimeout));
        Disconnect(Node.SignalName.TreeExiting, Callable.From(OnTreeExiting));
    }
}
