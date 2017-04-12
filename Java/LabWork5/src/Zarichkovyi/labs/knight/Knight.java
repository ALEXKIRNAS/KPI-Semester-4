package Zarichkovyi.labs.knight;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import Zarichkovyi.labs.ammunition.*;

/**
 * Created by user on 12.04.2017.
 */
public class Knight extends Human {

    private String title; // Титул
    private ArrayList <ammunition> inventory; // Амуніція лицаря
    private int healthPoints; // Здоровя лицаря

    // Конструктор
    public Knight(String name, String title, int age, int healthPoints, ArrayList <ammunition> inventory) {
        super(name, age);
        this.title = title;
        this.healthPoints = healthPoints;
        this.inventory = inventory;
    }

    // Поточний титул
    public String getTitle () {
        return title;
    }

    // Поточне здоровя лицаря
    public int getHealthPoints () {
        return this.healthPoints;
    }

    // Поточна амуніція лицаря
    public ArrayList <ammunition> getInventory () {
        return inventory;
    }

    // Змінити титул
    public void setTitle (String title) {
        this.title = title;
    }

    // Змінити запас здоровя лицаря
    public void setHealthpoints (int healthPoints) {
        this.healthPoints = healthPoints;
    }

    // Змінити амуніцію лицаря
    public void setInventory (ArrayList <ammunition> inventory) {
        this.inventory = inventory;
    }

    // Вісортувати амуніцію за ціною
    public void sortAmmunitionByCost () {
        Collections.sort(inventory, new Comparator() {
            public int compare(Object o1, Object o2)
            {
                ammunition a1 = (ammunition) o1;
                ammunition a2 = (ammunition) o2;

                if(a1.getCost() > a2.getCost()) return 1;
                else if(a1.getCost() < a2.getCost()) return -1;
                else return 0;
            }
        });
    }

    // Вісортувати амуніцію за вагою
    public void sortAmmunitionByWeight () {
        Collections.sort(inventory, new Comparator() {
            public int compare(Object o1, Object o2)
            {
                ammunition a1 = (ammunition) o1;
                ammunition a2 = (ammunition) o2;

                if(a1.getWeight()> a2.getWeight()) return 1;
                else if(a1.getWeight() < a2.getWeight()) return -1;
                else return 0;
            }
        });
    }

    // Двійковий пошук за ціною
    public int binarySearch (int value) {
        int left = 0;
        int right = inventory.size();

        while(left + 1 < right) {
            int mid = (left + right) >> 1;
            if(inventory.get(mid).getCost() >= value) right = mid;
            else left = mid;
        }

        if(inventory.get(left).getCost() >= value) return left;
        else return right;
    }

    // Знайти амуніцію в заданому ціновому діапазоні
    public ArrayList <ammunition> findByCost (int left, int right) {
        sortAmmunitionByCost ();

        int from = binarySearch(left - 1);
        int to = binarySearch(right + 1);
        ArrayList <ammunition> result = new ArrayList <ammunition> ();

        while(from < to) {
            result.add(inventory.get(from));
            from++;
        }

        return result;
    }

    // Підрахувати ціну амуніції
    public int countCost () {
        int cost = 0;
        for(int i = 0; i < inventory.size(); i++) {
            cost += inventory.get(i).getCost();
        }
        return cost;
    }

    @Override
    public String toString () {
        String result = "Лицар:\n";
        result += "Ім'я:" + getName() + " \n";
        result += "Вік:" + getAge() + " \n";
        result += "Титул:" + title + " \n";
        result += "Амуніція:\n";
        for(int i = 0; i < inventory.size(); i++) {
            result += inventory.get(i);
        }
        return result;
    }
}
