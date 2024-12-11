using Godot;

public partial class Pillar : Area2D
{
    private GameStateMachine _main;
    private GameManager _gameManager;
    private AudioStreamPlayer2D _audio;
    private Area2D _killArea;

    public override void _Ready()
    {
        _main = GetParent().GetParent<GameStateMachine>();
        _gameManager = GetParent().GetParent<GameStateMachine>().GetNode<GameManager>("GameManager");
        _audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");
        _killArea = GetNode<Area2D>("Kill");

        _killArea.Connect(Area2D.SignalName.BodyEntered, Callable.From((CharacterBody2D body) => OnKillBodyEntered(body)));
        Connect(Area2D.SignalName.BodyEntered, Callable.From((CharacterBody2D body) => OnBodyEntered(body)));
    }

    public override void _PhysicsProcess(double delta)
    {
        if (_main.CurrentState == GameStateMachine.GameState.RUNNING)
        {
            Vector2 PositionTemp = Position;
            PositionTemp.X -= 125 * (float)delta;
            Position = PositionTemp;
        }
    }

    private void OnKillBodyEntered(CharacterBody2D _body)
    {
        _main.SetState(GameStateMachine.GameState.DEAD);
    }

    private void OnBodyEntered(CharacterBody2D _body)
    {
        if (_main.CurrentState == GameStateMachine.GameState.RUNNING)
        {
            _gameManager.IncScore();
            _audio.Play();
        }
    }
}
