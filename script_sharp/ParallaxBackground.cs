using Godot;

public partial class ParallaxBackground : Godot.ParallaxBackground
{
	public override void _Ready()
	{
		for (int i = 0; i < GetChildCount() - 1; i++)
		{
			ParallaxLayer layer = GetChild<ParallaxLayer>(i);
			ParallaxSprite sprite = layer.GetNode<ParallaxSprite>("Buildings");

			layer.MotionMirroring = new Vector2(sprite.Texture.GetWidth() * sprite.Scale.X, 0);
		}
		ScrollBaseOffset = ScrollBaseOffset with { X = GD.RandRange(0, 2000) };
	}

	public override void _Process(double delta)
	{
		Vector2 scrollOffset = ScrollOffset;
		scrollOffset.X -= 30.0f * (float)delta;
		ScrollOffset = scrollOffset;
	}
}
