using Godot;

public partial class Walls : Area2D
{
    public override void _Ready()
    {
        Connect(SignalName.BodyEntered, Callable.From((CharacterBody2D body) => OnBodyEntered(body)));

        GetNode<CollisionShape2D>("CollisionShape2D2").Position = new Vector2(0, GetViewport().GetVisibleRect().Size.Y);
    }

    public void OnBodyEntered(CharacterBody2D _body)
    {
        if (GetOwner<GameStateMachine>().CurrentState == GameStateMachine.GameState.RUNNING)
        {
            GetOwner<GameStateMachine>().SetState(GameStateMachine.GameState.DEAD);
        }
    }
}
