package Zarichkovyi.labs;

import Zarichkovyi.labs.ammunition.*;

/**
 * Created by user on 14.04.2017.
 */
public class VectorTest {
    @org.junit.Test
    public void lastIndexOf() throws Exception {
        Vector inventory = new Vector();
        inventory.add(new Sword("Ескалібур", false, 80, 20, 500, 4));
        inventory.add(new Armor("NoName", true, 500, defense.Size.Large, 700, 25));
        inventory.add(new Helm("NoName", true, 100, defense.Size.Medium, 100, 2));
        inventory.add(new Lance("NoName", 2, 100, 25, 100, 3));
        inventory.add(new Shield("NoName", 200, defense.Size.Medium, 120, 5));
        inventory.add(new Sword("Ескалібур", false, 80, 20, 500, 4));

        int x = inventory.lastIndexOf(new Sword("Ескалібур", false, 80, 20, 500, 4));
        org.junit.Assert.assertEquals("lastIndexOf", 5, x);

        x = inventory.lastIndexOf(new Helm("NoName", true, 100, defense.Size.Medium, 100, 2));
        org.junit.Assert.assertEquals("lastIndexOf", 2, x);

        x = inventory.lastIndexOf(new Helm("NoName", false, 100, defense.Size.Medium, 100, 2));
        org.junit.Assert.assertEquals("lastIndexOf", -1, x);
    }

    @org.junit.Test
    public void indexOf() throws Exception {
        Vector inventory = new Vector();
        inventory.add(new Sword("Ескалібур", false, 80, 20, 500, 4));
        inventory.add(new Armor("NoName", true, 500, defense.Size.Large, 700, 25));
        inventory.add(new Helm("NoName", true, 100, defense.Size.Medium, 100, 2));
        inventory.add(new Lance("NoName", 2, 100, 25, 100, 3));
        inventory.add(new Shield("NoName", 200, defense.Size.Medium, 120, 5));
        inventory.add(new Sword("Ескалібур", false, 80, 20, 500, 4));

        int x = inventory.indexOf(new Sword("Ескалібур", false, 80, 20, 500, 4));
        org.junit.Assert.assertEquals("IndexOf", 0, x);

        x = inventory.indexOf(new Helm("NoName", true, 100, defense.Size.Medium, 100, 2));
        org.junit.Assert.assertEquals("IndexOf", 2, x);
    }

    @org.junit.Test
    public void get() throws Exception {
        Vector inventory = new Vector();
        inventory.add(new Sword("Ескалібур", false, 80, 20, 500, 4));
        inventory.add(new Armor("NoName", true, 500, defense.Size.Large, 700, 25));
        inventory.add(new Helm("NoName", true, 100, defense.Size.Medium, 100, 2));
        inventory.add(new Lance("NoName", 2, 100, 25, 100, 3));
        inventory.add(new Shield("NoName", 200, defense.Size.Medium, 120, 5));
        inventory.add(new Sword("Ескалібур", false, 80, 20, 500, 4));

        ammunition x = inventory.get(0);
        org.junit.Assert.assertEquals("Get", new Sword("Ескалібур", false, 80, 20, 500, 4), x);

        x = inventory.get(4);
        org.junit.Assert.assertEquals("Get", new Shield("NoName", 200, defense.Size.Medium, 120, 5), x);

        try {
            x = inventory.get(-10);
            org.junit.Assert.fail("Get Exception");
        } catch (Exception e) {}

        try {
            x = inventory.get(10);
            org.junit.Assert.fail("Get Exception");
        } catch (Exception e) {}

    }

    @org.junit.Test
    public void contains() throws Exception {
        Vector inventory = new Vector();
        inventory.add(new Sword("Ескалібур", false, 80, 20, 500, 4));
        inventory.add(new Armor("NoName", true, 500, defense.Size.Large, 700, 25));
        inventory.add(new Helm("NoName", true, 100, defense.Size.Medium, 100, 2));
        inventory.add(new Lance("NoName", 2, 100, 25, 100, 3));
        inventory.add(new Shield("NoName", 200, defense.Size.Medium, 120, 5));
        inventory.add(new Sword("Ескалібур", false, 80, 20, 500, 4));

        boolean x = inventory.contains(new Helm("NoName", true, 100, defense.Size.Medium, 100, 2));
        org.junit.Assert.assertEquals("Get", true, x);

        x = inventory.contains(10);
        org.junit.Assert.assertEquals("Get", false, x);

        x = inventory.contains(new Shield("NoName", 100, defense.Size.Medium, 120, 5));
        org.junit.Assert.assertEquals("Get", false, x);
    }

}