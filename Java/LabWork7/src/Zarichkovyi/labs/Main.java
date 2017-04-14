package Zarichkovyi.labs;

import Zarichkovyi.labs.ammunition.*;

public class Main {

    public static void main(String[] args) throws RException{
        Vector inventory = new Vector();
        inventory.add(new Armor("NoName", true, 500, defense.Size.Large, 700, 25));
        inventory.add(new Helm("NoName", true, 100, defense.Size.Medium, 100, 2));
        inventory.add(new Lance("NoName", 2, 100, 25, 100, 3));
        inventory.add(new Shield("NoName", 200, defense.Size.Medium, 120, 5));
        inventory.add(new Sword("Ескалібур", false, 80, 20, 500, 4));

        for (ammunition x : inventory) {
            if (x == null) throw new RException("My exception");
            System.out.print(x);
        }
    }
}
