package Zarichkovyi.labs.ammunition;

/**
 * Created by user on 12.04.2017.
 */
public class ammunition {
    private int cost; // Ціна амуніції
    private int weight; // Вага амуніції
    private String name; // Особлива назва амуніції

    // Змінити імя амуніції
    public void setName(String name)
    {
        this.name = name;
    }

    // Змінити ціну амуніції
    public void setCost (int cost)
    {
        this.cost = cost;
    }

    // Змінити вагу амуніції
    public void setWeight (int weight)
    {
        this.weight = weight;
    }

    // Поточне значення ціни
    public int getCost ()
    {
        return cost;
    }

    // Поточне значення ваги
    public int getWeight ()
    {
        return weight;
    }

    // Поточне ім'я
    public String getName ()
    {
        return name;
    }

    // Конструктор
    ammunition(String name, int cost, int weight)
    {
        this.name = name;
        this.cost = cost;
        this.weight = weight;
    }

    @Override
    public String toString ()
    {
        String end = "Ціна: " + cost + "\n" + "Вага: " + weight + "\n";
        if(name == "NoName")
            return end;
        else return "Назва: " + name + end;
    }
}
