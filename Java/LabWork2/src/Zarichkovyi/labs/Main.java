package Zarichkovyi.labs;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        int n, m; // Matrix dimensions

        Scanner reader = new Scanner(System.in);
        System.out.println("Enter a number n, m (dimensions of matrix): ");
        n = reader.nextInt();
        m = reader.nextInt();

        int[][] B = new int [n][m]; // Matrix
        generator(B);
        show(B, "Matrix B:");

        int[][] C = transponation(B);
        show(C, "Matrix C:");

        System.out.println("Action result: " + calc(C));
    }

    // Action with matrix
    public static int calc(int[][] Matrix) {
        int m = Matrix[0].length;
        int result = 0;

        for (int i = 0; i < m; i++) {
            result += (i % 2 == 1) ? Matrix[columnMax(Matrix, i)][i] :
                                     Matrix[columnMin(Matrix, i)][i] ;
        }

        return result;
    }

    // Returns index of minimum element in column
    public  static int columnMin(int[][] Matrix, int column) {
        int ans = 0;

        for (int i = 1; i < Matrix.length; i++) {
            if (Matrix[i][column] < Matrix[ans][column]) ans = i;
        }

        return ans;
    }

    // Returns index of maximum element in column
    public  static int columnMax(int[][] Matrix, int column) {
        int ans = 0;

        for (int i = 1; i < Matrix.length; i++) {
            if (Matrix[i][column] > Matrix[ans][column]) ans = i;
        }

        return ans;
    }

    // Generate matrix that containe random values
    public static void generator(int[][] Matrix) {
        int n = Matrix.length;
        int m = Matrix[0].length;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                Matrix[i][j] = (int) (Math.random() * 256);
            }
        }
    }

    // Matrix transponation
    public static int[][] transponation(int[][] Matrix) {
        int n = Matrix.length;
        int m = Matrix[0].length;
        int[][] result = new int [m][n];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                result[j][i] = Matrix[i][j];
            }
        }

        return result;
    }

    public static void show(int[][] Matrix, String lable) {
        int n = Matrix.length;
        int m = Matrix[0].length;

        System.out.println(lable);
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                System.out.format("%-4d", Matrix[i][j]);
            }
            System.out.println();
        }
    }
}
