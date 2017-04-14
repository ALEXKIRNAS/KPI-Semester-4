package Zarichkovyi.labs.ammunition;

/**
 * Created by user on 12.04.2017.
 * Спис
 */
public class Lance extends attack {

    private int length; // Довжина списа

    // Конструктор
    public Lance (String name, int lenth, int damage, int dmgRange, int cost, int weight) {
        super(name, damage, dmgRange, cost, weight);
        this.length = lenth;
    }

    @Override
    public String toString () {
        String ends = "Має довжину: " + length +". Здатна нанести " + this.getDamage()
                + " пошкоджень. " + "З діапазоном " + this.getDmgRange() + ". Коштує: "
                + getCost() + ". Важить: " + getWeight ()+ ".\n";
        if(this.getName().equals("NoName")) {
            return "# Ще один безіменний спис. " + ends;
        }
        else {
            return "# Спис: Назва: " + getName() + ". " + ends;
        }
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || !(o instanceof Lance)) return false;

        Lance tmp = (Lance) o;
        if (tmp.length == length && super.equals(tmp)) {
            return true;
        } else {
            return  false;
        }
    }
}
