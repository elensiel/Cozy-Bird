using Godot;

public partial class CrowPhysics : Node
{
	private const float JUMP_VELOCITY = -350.0f;
	private const float JUMP_ROTATION = -30.0f;
	private const float MAXIMUM_FALLING_SPEED = 1000.0f;
	private const float ROTATION_SPEED = 125.0f;

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
		velocity.Y = Mathf.Min(velocity.Y, MAXIMUM_FALLING_SPEED);

		// upward
		if (velocity.Y > 0 && Mathf.RadToDeg(_crow.Rotation) < 90)
		{
			_crow.Rotation += ROTATION_SPEED * Mathf.DegToRad(1) * tempDelta;
			if (_sprite.Frame != 0) _sprite.Frame = 0;
		}

		// downward
		else if (velocity.Y < 0 && Mathf.RadToDeg(_crow.Rotation) > 90)
		{
			_crow.Rotation -= ROTATION_SPEED * Mathf.DegToRad(1) * tempDelta;
		}

		_crow.Velocity = velocity;
		_crow.MoveAndCollide(_crow.Velocity * tempDelta);
	}

	public void Flap()
	{
		_crow.Velocity = _crow.Velocity with { Y = JUMP_VELOCITY };
		_crow.Rotation = Mathf.DegToRad(JUMP_ROTATION);
		_sprite.Frame = 1;
	}
}
