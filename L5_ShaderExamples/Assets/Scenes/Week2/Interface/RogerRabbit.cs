using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RogerRabbit : MonoBehaviour, ITalkative
{
    void Start()
    {
        Debug.Log("We can still inherit from MonoBehaviour while also implementing the ITalkative interface");
    }

    public string Talk()
    {
        return "I talk talk talk talk!";
    }

    public string Ask()
    {
        return "What is a question?";
    }

    public string Shout()
    {
        return "WHAT IS WRONG WITH YOU?!";
    }


}
