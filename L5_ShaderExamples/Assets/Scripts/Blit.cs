using UnityEngine;

[ExecuteInEditMode]
public class Blit : MonoBehaviour
{
    public Material effect;

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, effect);
    }
}
