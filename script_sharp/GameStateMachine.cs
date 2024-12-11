using Godot;

public partial class GameStateMachine : Node
{
    private Timer _deathTimer;
    private GameManager _gameManager;
    private ParallaxBackground _parallaxBackground;
    private PackedScene _pausePanel;
    private Player _player;
    private Timer _pillarSpawnTimer;

    public enum GameState
    {
        PAUSED,
        RUNNING,
        DEAD
    }

    public GameState CurrentState;
    private Node _pausePanelTemp;
    private bool _start = false;
    private bool _jumped = false;

    public override void _Ready()
    {
        // get node references
        _deathTimer = GetNode<Timer>("DeathTimer");
        _gameManager = GetNode<GameManager>("GameManager");
        _parallaxBackground = GetNode<ParallaxBackground>("ParallaxBackground");
        _pausePanel = ResourceLoader.Load<PackedScene>("res://scene/pause_panel.tscn");
        _player = GetNode<Player>("Player");
        _pillarSpawnTimer = GetNode<Timer>("PillarSpawnMachine/Timer");

        // set initial state into paused
        SetState(GameState.PAUSED);

        // some tweaks when the game starts
        _parallaxBackground.SetProcess(false);
        _pillarSpawnTimer.SetPaused(true);
        _start = true;
    }

    public void SetState(GameState newState)
    {
        ExitState(CurrentState);
        CurrentState = newState;
        EnterState(CurrentState);
    }

    private void EnterState(GameState state)
    {
        switch (state)
        {
            case GameState.PAUSED:
                _player.SetPhysicsProcess(false);

                if (_start)
                {
                    _pausePanelTemp = _pausePanel.Instantiate();
                    AddChild(_pausePanelTemp);
                }
                break;
            case GameState.RUNNING:
                _player.SetPhysicsProcess(true);
                _parallaxBackground.SetProcess(true);
                _pillarSpawnTimer.SetPaused(false);
                break;
            case GameState.DEAD:
                _player.SetProcessInput(false);
                if (!_jumped)
                {
                    _jumped = true;
                    _player.Jump();
                }

                _deathTimer.Start();
                break;
        }
    }

    private void ExitState(GameState state)
    {
        switch (state)
        {
            case GameState.PAUSED:
                _player.SetPhysicsProcess(true);

                if (GetNodeOrNull<Node>("PausePanel") != null)
                {
                    GetNode<Node>("PausePanel").QueueFree();
                }
                break;
            case GameState.RUNNING:
                _player.SetProcessInput(false);
                _parallaxBackground.SetProcess(false);
                _pillarSpawnTimer.SetPaused(true);
                break;
            case GameState.DEAD:
                GetTree().Paused = false;
                _player.SetProcessInput(true);
                break;
        }
    }
}
