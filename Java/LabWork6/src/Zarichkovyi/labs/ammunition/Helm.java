package Zarichkovyi.labs.ammunition;

/**
 * Created by user on 12.04.2017.
 * Шлем
 */
public class Helm extends defense {

    private boolean isCloseHelm; // Чи є шлем закритим

    // Конструктор
    public Helm (String name, boolean isCloseHelm, int canTakeDamage, Size size, int cost, int weight) {
        super(name, canTakeDamage, size, cost, weight);
        this.isCloseHelm = isCloseHelm;
    }

    @Override
    public String toString () {
        String ends = (isCloseHelm ? "Є" : "Не є") + " закритим. " + "Здатна поглинути " +
                getCanTakeDamage() + " пошкоджень. " + "Розміри: " + getSize() +  ". Коштує: " +
                getCost() + ". Важить: " + getWeight() +  ".\n";
        if(this.getName() == "NoName") {
            return "# Ще один безіменний шлем. " + ends;
        }
        else {
            return "# Шлем: Назва: " + getName() + ". " + ends;
        }
    }
}
