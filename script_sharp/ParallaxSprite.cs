using Godot;

[GlobalClass]
public partial class ParallaxSprite : Sprite2D
{
	public override void _Ready()
	{
		Rect2 viewport = GetViewport().GetVisibleRect();

		Scale = new Vector2(viewport.Size.X * 4 / Texture.GetWidth(), viewport.Size.Y / Texture.GetHeight());
		Position = viewport.Position;
	}
}
