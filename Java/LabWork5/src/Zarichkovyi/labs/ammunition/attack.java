package Zarichkovyi.labs.ammunition;

/**
 * Created by user on 12.04.2017.
 * Амуніція для атаки
 */
public class attack extends ammunition {
    private int damage; // кількість пошкоджень
    private int dmgRange; // діапазон пошкоджень

    // Конструктор
    attack (String name, int damage, int dmgRange, int cost, int weight) {
        super(name, cost, weight);
        this.damage = damage;
        this.dmgRange = dmgRange;
    }

    // Почна кількість пошкоджень
    public int getDamage () {
        return damage;
    }

    // Почний діапазон пошкоджень
    public int getDmgRange () {
        return dmgRange;
    }

    // Змінити кількість пошкоджень
    public void setDamage (int damage) {
        this.damage = damage;
    }

    // Змінити діапазон пошкоджень
    public void setDmgRange (int dmgRange) {
        this.dmgRange = dmgRange;
    }
}
