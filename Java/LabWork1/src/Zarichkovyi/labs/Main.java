package Zarichkovyi.labs;
import java.util.Scanner;

public class Main {

    static long C = 0; // Constant

    public static void main(String[] args) {
        int n, m; // Input variables

        Scanner reader = new Scanner(System.in);
        System.out.println("Enter a number n, m: ");
        n = reader.nextInt();
        m = reader.nextInt();

	    double result = 0.0;

	    for (long i = 0; i < n; i++)
	        for (long j = 0; j < m; j++) {
                if (j == 0 || (i + C) == 0) {
                    System.out.println("Prevent division by zero");
                } else {
                    result += ((double) (i) / j) / (i + C);
                }
            }

        System.out.println("Result: " + result);
    }
}
