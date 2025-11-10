using Godot;
using System;

public partial class SpawnHelper : Node
{
	private const float HEIGHT_RANGE = 100f;

	private static float midpoint = (float)ViewportHelper.GetCurrentViewport().Size.Y / 2.0f;

	public static float GetRandomHeight() { return midpoint + (float)GD.RandRange(-HEIGHT_RANGE, HEIGHT_RANGE); }
}
