package Zarichkovyi.labs;

import Zarichkovyi.labs.ammunition.*;
import java.io.*;
import com.google.gson.*;

public class Main {

    public static void main(String[] args) throws RException{
        Vector inventory = new Vector();
        inventory.add(new Armor("NoName", true, 500, defense.Size.Large, 700, 25));
        inventory.add(new Helm("NoName", true, 100, defense.Size.Medium, 100, 2));
        inventory.add(new Lance("NoName", 2, 100, 25, 100, 3));
        inventory.add(new Shield("NoName", 200, defense.Size.Medium, 120, 5));
        inventory.add(new Sword("Ескалібур", false, 80, 20, 500, 4));

        System.out.println("To File Object....");
        serializeObj(inventory);

        System.out.println("From File Object....");
        Vector des = deserializeObj();
        for (ammunition x : des) {
            if (x == null) continue;
            System.out.print(x);
        }

        System.out.println("\nTo File Array of ammunition....");
        serializeArr(inventory);

        System.out.println("From File Array of ammunition....");
        des = deserializeArr();
        for (ammunition x : des) {
            if (x == null) continue;
            System.out.print(x);
        }

        System.out.println("\nTo JSON File....");
        serializeJSON(inventory);

        System.out.println("From JSON File....");
        des = deserializeJSON();
        for (ammunition x : des) {
            if (x == null) continue;
            System.out.print(x);
        }

    }

    // Writing Vector to file
    public static void serializeObj(Vector obj) {

        FileOutputStream fout = null;
        ObjectOutputStream oos = null;

        try {
            String path = "C:\\\\temp\\\\obj.ser";
            fout = new FileOutputStream(path);
            oos = new ObjectOutputStream(fout);
            oos.writeObject(obj);

        } catch (Exception ex) {

            ex.printStackTrace();

        } finally {

            if (fout != null) {
                try {
                    fout.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            if (oos != null) {
                try {
                    oos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
    }

    // Reading VEctor from file
    public static Vector deserializeObj() {

        FileInputStream fin = null;
        ObjectInputStream ois = null;
        Vector obj = null;

        try {
            String path = "C:\\\\temp\\\\obj.ser";
            fin = new FileInputStream(path);
            ois = new ObjectInputStream(fin);
            obj = (Vector) ois.readObject();

        } catch (Exception ex) {

            ex.printStackTrace();

        } finally {

            if (fin != null) {
                try {
                    fin.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            if (ois != null) {
                try {
                    ois.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }

        return obj;
    }

    // Writing array of ammuntion to file
    public static void serializeArr(Vector obj) {

        FileOutputStream fout = null;
        ObjectOutputStream oos = null;

        try {
            String path = "C:\\\\temp\\\\arr.ser";
            fout = new FileOutputStream(path);
            oos = new ObjectOutputStream(fout);
            oos.writeInt(obj.size());

            for (ammunition x : obj) {
                oos.writeObject(x);
            }

        } catch (Exception ex) {

            ex.printStackTrace();

        } finally {

            if (fout != null) {
                try {
                    fout.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            if (oos != null) {
                try {
                    oos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
    }

    // Reading array of ammunition from file
    public static Vector deserializeArr() {

        FileInputStream fin = null;
        ObjectInputStream ois = null;
        Vector obj = new Vector();

        try {
            String path = "C:\\\\temp\\\\arr.ser";
            fin = new FileInputStream(path);
            ois = new ObjectInputStream(fin);
            int size = ois.readInt();

            for (int i = 0; i < size; i++) {
                ammunition x = (ammunition) ois.readObject();
                obj.add(x);
            }
        } catch (Exception ex) {

            ex.printStackTrace();

        } finally {

            if (fin != null) {
                try {
                    fin.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            if (ois != null) {
                try {
                    ois.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }

        return obj;
    }

    // Writing Vector to JSON
    public static void serializeJSON(Vector obj) {
        Gson gson = new Gson();
        PrintWriter out = null;
        try {
            String path = "C:\\\\temp\\\\arr.json";
            out = new PrintWriter(path);
            String json = gson.toJson(obj);
            out.write(json);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

    }

    // Reading array of ammunition from file
    public static Vector deserializeJSON() {
        BufferedReader in = null;
        Vector obj = null;
        Gson gson = new Gson();

        try {
            String path = "C:\\\\temp\\\\arr.json";
            in = new BufferedReader(new FileReader(path));
            String json = in.readLine();
            obj = gson.fromJson(json, Vector.class);
        } catch (Exception ex) {

            ex.printStackTrace();

        } finally {
            if (in != null) {
                try {
                    in.close();
                    obj = deserializeArr();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return obj;
    }
}
