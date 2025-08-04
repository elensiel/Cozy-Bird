using Godot;
using System;

public partial class SpawnHelper : Node
{
	private const float HEIGHT_RANGE = 100f;

	public static float GetRandomHeight(Vector2 viewportSize)
	{
		float midpoint = (float)viewportSize.Y / 2.0f;
		return midpoint + (float)GD.RandRange(-HEIGHT_RANGE, HEIGHT_RANGE);
	}
}
