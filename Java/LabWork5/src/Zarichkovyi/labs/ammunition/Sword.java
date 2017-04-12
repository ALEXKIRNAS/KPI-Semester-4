package Zarichkovyi.labs.ammunition;

/**
 * Created by user on 12.04.2017.
 * Меч
 */
public class Sword extends attack {

    private boolean twoHands; // Меч дворучний

    // Конструктор
    public Sword(String name, boolean twoHands, int damage, int dmgRange, int cost, int weight) {
        super(name, damage, dmgRange, cost, weight);
        this.twoHands = twoHands;
    }

    @Override
    public String toString () {
        String ends = (twoHands ? "Дворучний" : "Одноручний") +". Здатна нанести " + this.getDamage()
                + " пошкоджень. " + "З діапазоном " + this.getDmgRange() + ". Коштує: "
                + getCost() + ". Важить: " + getWeight ()+ ".\n";
        if(this.getName().equals("NoName")) {
            return "# Ще один безіменний меч. " + ends;
        }
        else {
            return "# Меч: Назва: " + getName() + ". " + ends;
        }
    }
}
