package Zarichkovyi.labs;

import Zarichkovyi.labs.knight.*;
import Zarichkovyi.labs.shop.*;
import Zarichkovyi.labs.ammunition.*;
import java.util.ArrayList;

public class Main {

    public static void main(String[] args) {
        shop newShop = new shop(); // Створюємо магазин

        // Створюємо нового лицаря і екіпіруємо його
        Knight knight =  new Knight ("Roland", "Lord", 31, 2000, newShop.buy());

        // Вивести інформацію про лицаря
        System.out.println();
        System.out.println(knight);

        // Загальна ватість амуніції лицаря
        System.out.println("Загальна вартість амуніції: " + knight.countCost() );
        System.out.println();

        // Відсортувати амуніцію за вагою
        System.out.println("Амуніція лицаря за вагою:");
        knight.sortAmmunitionByWeight();
        ArrayList <ammunition> result = knight.getInventory();
        for(int i = 0; i < result.size(); i++) {
            System.out.print(result.get(i));
        }
        System.out.println();

        // Пошук за ціною в заданому діапазоні
        result = knight.findByCost(100, 500);
        System.out.println("Пошук за ціною в діапазоні [100; 500] :");
        for(int i = 0; i < result.size(); i++) {
            System.out.print(result.get(i));
        }
    }
}
