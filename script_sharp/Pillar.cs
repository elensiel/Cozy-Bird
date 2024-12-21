using Godot;

public partial class Pillar : Area2D
{
    private GameStateMachine _main;
    private GameManager _gameManager;
    private AudioStreamPlayer2D _audio;

    private bool _scored = false;

    public override void _Ready()
    {
        _main = GetParent().GetParent<GameStateMachine>();
        _gameManager = GetParent().GetParent<GameStateMachine>().GetNode<GameManager>("GameManager");
        _audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");

        GetNode<Area2D>("Kill").Connect(Area2D.SignalName.BodyEntered, Callable.From((CharacterBody2D body) => OnKillBodyEntered(body)));
        Connect(Area2D.SignalName.BodyEntered, Callable.From((CharacterBody2D body) => OnBodyEntered(body)));

        Vector2 viewport_size = GetViewport().GetVisibleRect().Size;
        Scale = new Vector2(viewport_size.X / 480, viewport_size.Y / 1080);
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
        if (_main.CurrentState == GameStateMachine.GameState.RUNNING && !_scored)
        {
            _scored = true;
            _gameManager.IncScore();
            _audio.Play();
        }
    }
}
