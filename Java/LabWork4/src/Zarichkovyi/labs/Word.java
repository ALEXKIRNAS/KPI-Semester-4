package Zarichkovyi.labs;

/**
 * Created by user on 12.04.2017.
 */
public class Word {

    final static StringBuilder VOWELS = new StringBuilder("aeiouyAEIOUY");
    private Letter[] word;

    public Word(String str) {
        word = new Letter[str.length()];
        for (int i = 0; i < word.length; i++) {
            word[i] = new Letter();
            word[i].value = str.charAt(i);
        }
    }

    public char charAt(int index) {
        return word[index].value;
    }

    public int countVowels() {
        int result = 0;

        for (int i = 0; i < word.length; i++) {
            for (int j = 0; j < VOWELS.length(); j++) {
                if (word[i].value == VOWELS.charAt(j)) {
                    result++;
                }
            }
        }

        return result;
    }

    @Override
    public String toString () {
        String res = "";
        for (int i = 0; i < word.length; i++) {
            res += word[i].value;
        }
        return res;
    }
}
