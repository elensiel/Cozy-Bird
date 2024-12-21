using Godot;

public partial class ParallaxBackground : Godot.ParallaxBackground
{
    public override void _Ready()
    {
        for (int i = 0; i < GetChildCount() - 1; i++)
        {
            GetChild<ParallaxLayer>(i).MotionMirroring = new Vector2(GetViewport().GetVisibleRect().Size.X * 4, 0);
        }

        ScrollBaseOffset = ScrollBaseOffset with { X = (int)GD.RandRange(0, 2000) };
    }

    public override void _Process(double delta)
    {
        Vector2 scrollOffset = ScrollOffset;
        scrollOffset.X -= 20.0f * (float)delta;
        ScrollOffset = scrollOffset;
    }
}
