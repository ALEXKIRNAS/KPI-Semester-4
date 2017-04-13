package Zarichkovyi.labs;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        System.out.println("Enter sentence:");

        Scanner reader = new Scanner(System.in);
        Sentence obj = new Sentence(reader.nextLine());
        System.out.println("You entered: " + obj);

        printArrayOfStrings(obj.sortByVowels());
    }

    // Output array of strings
    private static void printArrayOfStrings(StringBuilder[] arr) {
        System.out.println("Result:");

        int n = arr.length;
        for(int i = 0; i < n; i++) {
            System.out.println(i + " : " + arr[i]);
        }
    }
}
