using Godot;

public partial class Walls : Area2D
{
    public override void _Ready()
    {
        Connect(SignalName.BodyEntered, Callable.From((CharacterBody2D body) => OnBodyEntered(body)));
    }

    public void OnBodyEntered(CharacterBody2D _body)
    {
        if (GetOwner<GameStateMachine>().CurrentState == GameStateMachine.GameState.RUNNING)
        {
            GetOwner<GameStateMachine>().SetState(GameStateMachine.GameState.DEAD);
        }
    }
}
