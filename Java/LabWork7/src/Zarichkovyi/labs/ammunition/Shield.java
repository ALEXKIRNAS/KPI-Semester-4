package Zarichkovyi.labs.ammunition;

import Zarichkovyi.labs.ammunition.defense;

/**
 * Created by user on 12.04.2017.
 * Щит
 */
public class Shield extends defense {

    // Конструктор
    public Shield (String name, int canTakeDamage, Size size, int cost, int weight) {
        super(name, canTakeDamage, size, cost, weight);
    }

    @Override
    public String toString () {
        String ends = "Здатна поглинути " + getCanTakeDamage() + " пошкоджень. " + "Розміри: "
                + getSize() +  ". Коштує: " + getCost() + ". Важить: " + getWeight ()+ ".\n";
        if(this.getName() == "NoName") return "# Ще один безіменний щит. " + ends;
        else return "# Щит: Назва: " + getName() + ". " + ends;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || !(o instanceof Shield)) return false;

        Shield tmp = (Shield) o;
        if (super.equals(tmp)) {
            return true;
        } else {
            return  false;
        }
    }
}
