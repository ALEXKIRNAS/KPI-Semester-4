package Zarichkovyi.labs.ammunition;

/**
 * Created by user on 12.04.2017.
 * Частина амуніції, яка призначена для захисту
 */
public class defense extends ammunition {

    private int canTakeDamage; // Кількість пошкоджень, які здатна "поглинути" амуніція

    public enum Size {
        Large,
        Medium,
        Small
    };

    private Size size; // Розмір амуніції

    //Конструктор
    defense(String Name, int canTakeDamage, Size size, int cost, int weight) {
        super(Name, cost, weight);
        this.canTakeDamage = canTakeDamage;
        this.size = size;
    }

    // Поточне значення пошкоджень
    int getCanTakeDamage () {
        return canTakeDamage;
    }

    // Поточне значення розміру
    Size getSize () {
        return size;
    }

    // Змінити поточне значення пошкоджень
    void setCanTakeDamage (int canTakeDamage) {
        this.canTakeDamage = canTakeDamage;
    }

    // Змінити поточне значення розміру
    void setSize (Size size) {
        this.size = size;
    }
}
