using Godot;

public partial class ViewportHelper : Node
{
    private static readonly Vector2 _targetResolution = new Vector2(480, 1080);
    public static Rect2 viewport;

    public override void _EnterTree() { viewport = GetViewport().GetVisibleRect(); }
    public static Vector2 GetCalculatedScale() { return viewport.Size / _targetResolution; }
    public static Rect2 GetCurrentViewport() { return viewport; }
    public static void SetViewport(Rect2 currentViewport) { viewport = currentViewport; }
}
