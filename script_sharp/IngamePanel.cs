using Godot;

public partial class IngamePanel : Node
{
    public override void _Ready()
    {
        PanelContainer panelContainer = GetNode<PanelContainer>("PanelContainer");
        Rect2 viewport = GetViewport().GetVisibleRect();

        GetNode<Panel>("Panel").Size = viewport.Size;
        panelContainer.Position = (viewport.Size / 2) - (panelContainer.Size / 2);
    }
}