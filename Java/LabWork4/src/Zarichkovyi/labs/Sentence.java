package Zarichkovyi.labs;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;

/**
 * Created by user on 12.04.2017.
 */
class SentenceElem {
    private Word word;
    private Separator separator;
    private boolean type;

    public SentenceElem(String str) {
        if (Separator.isSeparator(str.charAt(0))) {
            type = false;
            separator = new Separator();
            separator.value = str.charAt(0);
        } else {
            type = true;
            word = new Word(str);
        }
    }

    public int countVowels() {
        return type ? word.countVowels() : -1;
    }

    public boolean isSeparator() {
        return !type;
    }

    @Override
    public String toString () {
        String res = "";
        if (!type) {
            res += separator.value;
        } else {
            res += word;
        }

        return res;
    }
}

class Tokenizer {

    private ArrayList<String> tokens;
    private int currentToken;

    public Tokenizer(String str) {
        tokens = new ArrayList<String>();
        currentToken = 0;
        int lastIndex = 0; // Index of last symbol don`t added to list

        for (int i = 0; i < str.length(); i++) {
            if (Separator.isSeparator(str.charAt(i))) {
                if (lastIndex != i) {
                    tokens.add(str.substring(lastIndex, i));
                }
                String sep = str.substring(i, i + 1);
                if (sep.charAt(0) == '\t') {
                    sep.replace('\t', ' ');
                }
                if (sep.charAt(0) != ' ' || tokens.get(tokens.size() - 1).charAt(0) != ' ') {
                    tokens.add(sep);
                }


                lastIndex = i + 1;
            }
        }

        if (lastIndex != str.length()) {
            tokens.add(str.substring(lastIndex));
        }
    }

    public int tokensSize() {
        return tokens.size();
    }

    public String next() {
        if (currentToken == tokens.size()) {
            return new String("");
        }

        return tokens.get(currentToken++);
    }

}

public class Sentence {

    private SentenceElem[] sentence;
    private int wordSize;

    public Sentence(String str) {
        wordSize = 0;
        Tokenizer tokenizer = new Tokenizer(str);

        int n = tokenizer.tokensSize();
        sentence = new SentenceElem[n];

        for (int i = 0; i < n; i++) {
            sentence[i] = new SentenceElem(tokenizer.next());
            if (!sentence[i].isSeparator()) wordSize++;
        }
    }

    public StringBuilder[] sortByVowels() {
        SentenceElem[] arr = new SentenceElem[wordSize];
        int currIndex = 0;

        for (int i = 0; i < sentence.length; i++) {
            if (!sentence[i].isSeparator()) {
                arr[currIndex++] = sentence[i];
            }
        }

        Arrays.sort(arr, new Comparator<SentenceElem>() {
            @Override
            public int compare(SentenceElem o1, SentenceElem o2) {
                int c1 = o1.countVowels();
                int c2 = o2.countVowels();

                if (c1 < c2) return -1;
                else if (c1 == c2) return 0;
                else return 1;
            }
        });

        StringBuilder[] result = new StringBuilder[arr.length];
        for (int i = 0; i < arr.length; i++) {
            result[i] = new StringBuilder("" + arr[i]);
        }

        return result;
    }

    @Override
    public String toString() {
        String result = "";
        for (int i = 0; i < sentence.length; i++) {
            result += sentence[i];
        }
        return result;
    }

}
