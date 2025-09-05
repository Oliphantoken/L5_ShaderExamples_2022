using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// This class implements tap and double tap mobile input.
/// </summary>
public class Tapping : MonoBehaviour
{
    private Renderer rend;
    public float speed = 1;

    public int tapCount = 0;
    public float tapTimer = 0f;
    public bool isClicked = false;

    void Start()
    {
        rend = GetComponent<Renderer>();
    }

    void Update()
    {
        transform.Rotate(Vector3.up * speed * 100 * Time.deltaTime, Space.World);
       
        if (isClicked)
            StartTapTimer();

        if (Input.touchCount > 0)
            RegisterTap();

        if (tapTimer > 1f)
            ResetTapTimer();
    }

    public void RegisterTap()
    {
        isClicked = true;
        tapCount++;

        if (tapTimer < 1f && tapCount == 2) //double tap
        {
            GameObject.CreatePrimitive(PrimitiveType.Cube);
            rend.material.color = new Color(0, 0, 1, 1);
        }
        else if (tapCount == 1) // one tap
        {
            GameObject.CreatePrimitive(PrimitiveType.Sphere);
            rend.material.color = new Color(1, 0, 0, 1);
        }
    }

    public void StartTapTimer()
    {
        tapTimer += Time.deltaTime;
    }
    public void ResetTapTimer()
    {
        tapTimer = 0;
        tapCount = 0;
        isClicked = false;
    }
}
