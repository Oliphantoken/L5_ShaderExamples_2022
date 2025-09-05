public class Elf : NPC, ITalkative
{
    protected override string Identity()
    {
        return "Hello! I'm an Elf!";
    }
    public string Talk()
    {
        return Identity() + " I talk too much!"; 
    }

    public string Ask()
    {
        return "Do I talk too much?";
    }

    public string Shout()
    {
        return "I TALK TOOOO MUCHHHHH!";
    }

    public string Comment()
    {
        return "I like cakes";
    }
}
