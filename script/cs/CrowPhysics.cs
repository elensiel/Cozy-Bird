using Godot;
using System;

public partial class CrowPhysics : Node
{
	[Export] public float JumpVelocity = -350.0f;
	[Export] public float JumpRotation = -30.0f;
	[Export] public float MaximumFallingSpeed = 1000.0f;
	[Export] public float RotationSpeed = 0.04f;

	private CharacterBody2D _crow;
	private Sprite2D _sprite;
	private float _gravity;

	public override void _Ready() 
	{
		_crow = GetParent<CharacterBody2D>();
		_sprite = GetNode<Sprite2D>("../Sprite2D");
		_gravity = (float)ProjectSettings.GetSetting("physics/2d/default_gravity");
	}

	public override void _PhysicsProcess(double delta)
	{
		float tempDelta = (float)delta;

		Vector2 velocity = _crow.Velocity;
		velocity.Y += _gravity * tempDelta;
		velocity.Y = Mathf.Min(velocity.Y, MaximumFallingSpeed);

		// upward
		if (velocity.Y > 0 && Mathf.RadToDeg(_crow.Rotation) < 90)
		{
			_crow.Rotation += RotationSpeed * Mathf.DegToRad(1) * tempDelta;
			if (_sprite.Frame != 0) _sprite.Frame = 0;
		}

		// downward
		else if (velocity.Y < 0 && Mathf.RadToDeg(_crow.Rotation) > 90)
		{
			_crow.Rotation -= RotationSpeed * Mathf.DegToRad(1) * tempDelta;
		}

		_crow.Velocity = velocity;
		_crow.MoveAndCollide(_crow.Velocity * tempDelta);
	}

	public void Flap()
	{
		_crow.Velocity = new Vector2(_crow.Velocity.X, JumpVelocity);
		_crow.Rotation = Mathf.DegToRad(JumpRotation);
		_sprite.Frame = 1;
	}
}
