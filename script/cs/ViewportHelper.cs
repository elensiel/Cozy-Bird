using Godot;

public partial class ViewportHelper : Node
{
	private static readonly Vector2 _targetResolution = new Vector2(480, 1080);
	private static Rect2 viewport;

	// just read.
	public override void _EnterTree() { viewport = GetViewport().GetVisibleRect(); }

	// for scale adjustments on different devices
	public static Vector2 GetScaleModifier() { return viewport.Size / _targetResolution; }
	
	// returns just the viewport. just the viewport. viewport.
	public static Rect2 GetCurrentViewport() { return viewport; }
}
