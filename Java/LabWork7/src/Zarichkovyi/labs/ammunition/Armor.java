package Zarichkovyi.labs.ammunition;

/**
 * Created by user on 12.04.2017.
 */
public class Armor extends defense {
    private boolean isCeremonial;

    // Конструктор
    public Armor (String name, boolean isCeremonial, int canTakeDamage, Size size, int cost, int weight) {
        super(name, canTakeDamage, size, cost, weight);
        this.isCeremonial = isCeremonial;
    }

    @Override
    public String toString () {
        String ends = (isCeremonial ? "Є" : "Не є") + " церемоніальною. " + "Здатна поглинути " +
                getCanTakeDamage() + " пошкоджень. " + "Розміри: " + getSize() +  ". Коштує: " +
                getCost() + ". Важить: " + getWeight () + ".\n";
        if(this.getName().equals("NoName")) {
            return "# Ще одна безіменна броня. " + ends;
        }
        else {
            return "# Броня: Назва: " + getName() + ". " + ends;
        }
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || !(o instanceof Armor)) return false;

        Armor tmp = (Armor) o;
        if (tmp.isCeremonial == isCeremonial && super.equals(tmp)) {
            return true;
        } else {
            return  false;
        }
    }
}
