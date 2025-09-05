using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Accelerometer : MonoBehaviour
{
    public float smooth = 0.4f;
    public float rotX;
    public float sensitivity = 6;
    private Vector3 acceleration, initialAcceleration;
    void Start()
    {
        
        initialAcceleration = Input.acceleration;
        acceleration = Vector3.zero;
    }

    void Update()
    {
        acceleration = Vector3.Lerp(acceleration,
                              Input.acceleration - initialAcceleration,
                              Time.deltaTime / smooth);

        rotX = Mathf.Clamp(acceleration.x * sensitivity, -1, 1);
        //transform.Rotate(0, 0, -rotX);
        if(rotX > 0.2 /*|| rotX < */)
        transform.Translate(transform.right * rotX);
    }
}

