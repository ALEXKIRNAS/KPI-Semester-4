package Zarichkovyi.labs;

/**
 * Created by user on 12.04.2017.
 */
public class Separator {
    public final static StringBuilder SEPATORS = new StringBuilder(",. \\t!\\\";:'-");
    public char value;

    static boolean isSeparator (char ch) {
        for (int i = 0; i < SEPATORS.length(); i++) {
            if (SEPATORS.charAt(i) == ch) {
                return true;
            }
        }

        return false;
    }
}
