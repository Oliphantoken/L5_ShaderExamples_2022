using System;
using UnityEngine;

namespace Week2_CohortTask
{
    public class Game : MonoBehaviour
    {
        public static Action<Player> OnPlayerCreated;

        private void Start()
        {
            OnPlayerCreated += ShowGreeting;
        }

        private void Update()
        {
            if (Input.GetKeyDown(KeyCode.Space))
            {
                CreatePlayer();
            }

            
        }

        public void CreatePlayer()
        {
            Player plr = new Player("Huda");

            OnPlayerCreated(plr);
        }

        public void ShowGreeting(Player p)
        {
            Debug.Log("Hello " + p.GetName());
        }


    }


    public class Player
    {
        private string name;
        

        public Player(string name)
        {
            this.name = name;
        }

        public void UpdatePlayerInfo(string name)
        {
            this.name = name;
        }

        public string GetName()
        {
            return name;
        }

    }

}
