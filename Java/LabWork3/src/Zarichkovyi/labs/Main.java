package Zarichkovyi.labs;
import java.util.Scanner;
import java.util.StringTokenizer;
import java.util.Arrays;
import java.util.Comparator;

public class Main {
    private static StringBuilder SEPARATORS = new StringBuilder(",. \t!\";:'-");
    private static StringBuilder VOWELS = new StringBuilder("aeiouyAEIOUY");

    public static void main(String[] args) {
        Scanner reader = new Scanner(System.in);
        StringBuilder input = new StringBuilder(reader.nextLine());

        printArrayOfStrings(SortByVowels(ParseBySeparators(input)));
    }

    // Separate string to array of string
    private static StringBuilder[] ParseBySeparators(StringBuilder str) {
        StringTokenizer token = new StringTokenizer(new String(str), new String(SEPARATORS));

        int n = token.countTokens();
        StringBuilder[] result = new StringBuilder[n];

        for (int i = 0; i < n; i++) {
            result[i] = new StringBuilder(token.nextToken());
        }

        return  result;
    }

    // Sorting array of string by asc vowels number
    private static StringBuilder[] SortByVowels(StringBuilder[]  arr) {
        Arrays.sort(arr, new Comparator<StringBuilder>() {
            @Override
            public int compare(StringBuilder o1, StringBuilder o2) {
                int c1 = Main.countVowels(o1);
                int c2 = Main.countVowels(o2);

                if (c1 < c2) return -1;
                else if (c1 == c2) return 0;
                else return 1;
            }
        });

        return arr;
    }

    // Counting vowels number at string
    private static int countVowels(StringBuilder str) {
        int len = str.length();
        int result = 0;

        for (int i = 0; i < len; i++) {
            for (int j = 0; j < VOWELS.length(); j++) {
                if (str.charAt(i) == VOWELS.charAt(j)) result++;
            }
        }

        return result;
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
