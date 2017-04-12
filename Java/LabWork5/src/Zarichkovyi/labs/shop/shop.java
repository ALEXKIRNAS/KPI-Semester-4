package Zarichkovyi.labs.shop;

import Zarichkovyi.labs.ammunition.*;
import java.util.ArrayList;

import java.util.Scanner;

/**
 * Created by user on 12.04.2017.
 */
public class shop {
    ArrayList <ammunition> inventory; // Інвентар

    // Ініціалізація інвентаря
    public shop ()
    {
        inventory = new ArrayList <ammunition> ();
        inventory.add(new Armor("NoName", true, 500, defense.Size.Large, 700, 25));
        inventory.add(new Helm("NoName", true, 100, defense.Size.Medium, 100, 2));
        inventory.add(new Lance("NoName", 2, 100, 25, 100, 3));
        inventory.add(new Shield("NoName", 200, defense.Size.Medium, 120, 5));
        inventory.add(new Sword("Ескалібур", false, 80, 20, 500, 4));
    }

    // Покупка амуніції
    public ArrayList <ammunition> buy ()
    {
        Scanner in = new Scanner (System.in);
        ArrayList <ammunition> result = new ArrayList <ammunition>();

        System.out.printf("Асортимент магазину:\n");
        int n = 1;
        for(ammunition item : inventory) System.out.print("" + n++ +": " + item);
        System.out.printf("0: Закінчити покупку.\n");

        int choice;
        while(true)
        {
            System.out.printf("Зробіть свій вибір: ");
            choice = in.nextInt();
            if (choice == 0) {
                if (result.size() == 0) {
                    System.out.print("Сір, Ви нічого не купили.\n");
                    continue;
                } else {
                    break;
                }
            }
            if (inventory.size() < choice || choice < 0) {
                System.out.print("Сір, така амуніція відсутня.\n");
                continue;
            }
            result.add(inventory.get(choice - 1));
        }

        in.close();
        return result;
    }
}
