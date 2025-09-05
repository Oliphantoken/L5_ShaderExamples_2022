using UnityEngine;

[ExecuteInEditMode]
public class ImageEffect01 : MonoBehaviour
{
    public Material effect;

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        print("Here");
        Graphics.Blit(source, destination, effect);
    }
}
