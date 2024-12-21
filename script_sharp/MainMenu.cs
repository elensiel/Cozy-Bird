using Godot;

public partial class MainMenu : Node
{
    // FOR NODE REFERENCES
    private AudioStreamPlayer2D Audio;
    private PackedScene Main; // for preloading

    public override void _Ready()
    {
        Main = ResourceLoader.Load<PackedScene>("res://scene/game_loop.tscn");  // preloading
        Audio = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");

        // connecting buttons
        GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Play").Connect(Button.SignalName.Pressed, Callable.From(OnButtonPressedPlay));
        GetNode<Button>("PanelContainer/MarginContainer/VBoxContainer/Quit").Connect(Button.SignalName.Pressed, Callable.From(OnButtonPressedQuit));

        // UI adjustments
        Vector2 viewportSize = GetViewport().GetVisibleRect().Size;
        PanelContainer panelContainer = GetNode<PanelContainer>("PanelContainer");
        Label label = GetNode<Label>("Label");
        Sprite2D sprite = GetNode<Sprite2D>("Sprite2D");

        panelContainer.Position = (viewportSize / 2) - (panelContainer.Size / 2);

        label.Text = "HIGH SCORE: " + GameManager.LoadScore().ToString();
        label.Position = label.Position with { X = (viewportSize.X / 2) - (label.Size.X / 2) };
        label.Position = label.Position with { Y = panelContainer.Position.Y - label.Size.Y };

        sprite.Scale = sprite.Scale with { X = viewportSize.X * 2 / sprite.Texture.GetWidth() };
        sprite.Scale = sprite.Scale with { Y = viewportSize.Y / sprite.Texture.GetHeight() };
        sprite.Position = sprite.Position with { X = viewportSize.X };
        sprite.Position = sprite.Position with { Y = viewportSize.Y / 2 };
    }

    private async void OnButtonPressedPlay()
    {
        Audio.Play();
        await ToSignal(Audio, "finished");
        GetTree().ChangeSceneToPacked(Main);
    }

    private void OnButtonPressedQuit()
    {
        Audio.Play();
        GetTree().Quit();
    }
}
