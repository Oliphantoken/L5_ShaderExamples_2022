using System.Collections.Generic;
using UnityEngine;

public class Game : MonoBehaviour
{
    public Elf elf;
    public RogerRabbit rabbit;
    public NPC agent;
    public List<ITalkative> talkableThings;

    void Start()
    {
        //Option 1: you can print out each object's Talk() function like this
        /* Debug.Log("It says: " + elf.Talk());
        /* Debug.Log("It says: " + rabbit.Talk());*/

        //Option 2a: OR you can add all talkative objects into a list of ITalkatives.
        talkableThings = new List<ITalkative>();
        elf = new Elf();
        rabbit = new RogerRabbit();

        talkableThings.Add(elf);
        talkableThings.Add(rabbit);
        //talkableThings.Add(agent); <-- Error: you won't be able to add this, even though elf inherits it. Not all NPCs are talkable!

        //Option 2b: You can now control a list of different objects that all have the interface in common
        foreach(ITalkative t in talkableThings)
        {
            Debug.Log("It says: " + t.Talk());
        }


    }

}
