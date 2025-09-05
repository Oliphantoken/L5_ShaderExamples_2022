using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// Adding swipe function.
/// </summary>
public class Swiping : MonoBehaviour
{
    public Vector2 startPoint;
    public bool isHoldingDown = false;
    public bool isMoving = false;
    public float swipeDistance = 10f;
    public float touchTimer = 0f;
    public const float MAXTOUCHTIMER = 1f;
    public Renderer testObject;

    //Swipe motion
    public bool swipeLeft = false;
    public bool swipeUp = false;
    public Color testColor = Color.black;

    void Start()
    {
        
    }

    void Update()
    {
        if(Input.touchCount > 0)
        {
            Touch t = Input.GetTouch(0);
            //Begin touch
            if (!isHoldingDown && t.phase == TouchPhase.Began) 
            {
                startPoint = t.position;
                isHoldingDown = true;
            }
            else if (t.phase == TouchPhase.Ended)
            {
                isHoldingDown = false;
            }
            
            //Swipe
            else if(t.phase == TouchPhase.Moved)
            {
                isMoving = true;
                
                //swipe left or right?
                if(t.position.x < (startPoint.x + swipeDistance))
                {
                    swipeLeft = true;
                    testColor.r = 0.5f;
                }
                else
                {
                    swipeLeft = false;
                    testColor.b = 0.5f;
                }

                //swipe up or down?
                if (t.position.y < (startPoint.y + swipeDistance))
                {
                    swipeUp = true;
                    testColor = new Color(testColor.r + 0.8f, testColor.g + 0.8f, testColor.b + 0.8f, 1);
                }
                else
                {
                    swipeUp = false;
                }
            

            
            }
            else if(isMoving && t.phase == TouchPhase.Stationary)
            {
                t.phase = TouchPhase.Canceled;
                testColor = Color.black;
            }


        }

        //The speed at which to swipe
      /*  if (isHoldingDown)
        {
            if (touchTimer <= MAXTOUCHTIMER)
            {
                touchTimer += Time.deltaTime;
            }
            else
            {
                touchTimer = 0;
            }
        }*/

    }
}
