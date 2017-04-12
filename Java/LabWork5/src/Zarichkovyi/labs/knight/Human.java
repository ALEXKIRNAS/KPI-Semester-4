package Zarichkovyi.labs.knight;

/**
 * Created by user on 12.04.2017.
 * Людина
 */
public class Human {

    private String name; // Імя
    private int age; // Вік

    // Конструктор
    public Human (String name, int age) {
        this.name = name;
        this.age = age;
    }

    // Поточне імя
    public String getName () {
        return name;
    }

    // Поточний вік
    public int getAge () {
        return age;
    }

    // Змінити імя
    public void setName (String name) {
        this.name = name;
    }

    // Змінити вік
    public void setAge (int age) {
        this.age = age;
    }
}
