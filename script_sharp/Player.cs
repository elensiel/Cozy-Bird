using Godot;
using System;

public partial class Player : CharacterBody2D
{
    private AudioStreamPlayer2D _caw;
    private AudioStreamPlayer2D _flap;
    private GameStateMachine _main;
    private Sprite2D _sprite;

    private double _gravityDouble = ProjectSettings.GetSetting("physics/2d/default_gravity").AsDouble();
    private float _gravity;
    private const float _jumpVelocity = -350.0f;
    private const int _fallSpeed = 1000;
    private const float _rotationSpeed = 0.04f;

    public override void _Ready()
    {
        _caw = GetNode<AudioStreamPlayer2D>("Caw");
        _flap = GetNode<AudioStreamPlayer2D>("Flap");
        _main = GetOwner<GameStateMachine>();
        _sprite = GetNode<Sprite2D>("Sprite2D");
        _gravity = (float)_gravityDouble;
    }

    public override void _Input(InputEvent @event)
    {
        if (@event.IsActionPressed("jump"))
        {
            if (_main.CurrentState == GameStateMachine.GameState.PAUSED)
            {
                _main.SetState(GameStateMachine.GameState.RUNNING);
            }
            Jump();
            _flap.Play();
            if (GD.RandRange(0, 10) <= 3)
            {
                _caw.Play();
            }
        }
        else if (@event.IsActionPressed("pause"))
            switch (_main.CurrentState)
            {
                case GameStateMachine.GameState.RUNNING:
                    _main.SetState(GameStateMachine.GameState.PAUSED);
                    break;
                case GameStateMachine.GameState.PAUSED:
                    _main.SetState(GameStateMachine.GameState.RUNNING);
                    break;
            }
    }

    public override void _PhysicsProcess(double delta)
    {
        Vector2 VelocityTemp = Velocity;
        VelocityTemp.Y += _gravity * (float)delta;
        VelocityTemp.Y = MathF.Min(VelocityTemp.Y, _fallSpeed);
        Velocity = VelocityTemp;

        if (Velocity.Y > 0 && Mathf.RadToDeg(Rotation) < 90)
        {
            Rotation += _rotationSpeed * Mathf.RadToDeg(1) * (float)delta;
            _sprite.Frame = 0;
        }
        else if (Velocity.Y < 0 && Mathf.RadToDeg(Rotation) > 0)
        {
            Rotation -= _rotationSpeed * Mathf.RadToDeg(1) * (float)delta;
        }

        MoveAndCollide(Velocity * (float)delta);
    }

    public void Jump()
    {
        Velocity = Velocity with { Y = _jumpVelocity };
        Rotation = Mathf.DegToRad(-30);
        _sprite.Frame = 1;
    }
}
