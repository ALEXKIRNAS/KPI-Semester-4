package Zarichkovyi.labs;

import Zarichkovyi.labs.ammunition.ammunition;
import java.util.*;
import java.io.Serializable;

/**
 * Created by user on 13.04.2017.
 */
public class Vector implements List<ammunition>, Serializable {
    private static final long serialVersionUID = 1L;
    final static int BASE_SIZE = 10;
    final static int STEP_COEF = 2;
    private int length;
    private int size;
    private ammunition[] container;

    public Vector() {
        length = BASE_SIZE;
        size = 0;
        container = new ammunition[length];
    }

    public Vector(ammunition obj) {
        length = BASE_SIZE;
        container = new ammunition[length];
        size = 1;
        container[0] = obj;
    }

    public Vector(ArrayList<? extends ammunition> arr) {
        length = BASE_SIZE;
        while (length < arr.size()) {
            length *= 2;
        }

        size = 0;
        container = new ammunition[length];

        for(ammunition x : arr) {
            container[size++] = x;
        }
    }

    private void resize() {
        length *= STEP_COEF;
        ammunition[] containerTmp = container;
        container = new ammunition[length];
        size = 0;

        for (ammunition x : containerTmp) {
            container[size] = containerTmp[size++];
        }
    }

    public int size() {
        return size;
    }

    @Override
    public Object[] toArray() {
        return container;
    }

    @Override
    public <T> T[] toArray(T[] a) {
        return null;
    }

    @Override
    public ammunition get(int index) throws IndexOutOfBoundsException {
        if (index < 0 || index >= size ) {
            throw new IndexOutOfBoundsException("Out of range exception");
        }
        return container[index];
    }

    @Override
    public boolean add(ammunition e) {
        if (size == length) {
            resize();
        }
        container[size++] = e;
        return true;
    }

    @Override
    public boolean equals(Object o) {
        if (o.getClass().getName().equals("Vector")) {
            Vector x = (Vector)(o);
            if (x.size == size) {
                for (int i = 0; i < size; i++) {
                    if (container[i] != x.container[i]) {
                        return false;
                    }
                }
                return true;
            } else {
                return false;
            }
        }
        else return false;
    }

    @Override
    public boolean addAll(int index, Collection<? extends ammunition> c) {
        ammunition[] ends = container;

        size = index;
        for (ammunition x : c) {
           add(x);
        }

        for (int i = index; i < ends.length; i++) {
            add(ends[i]);
        }

        return true;
    }

    @Override
    public int lastIndexOf(Object o) {
        for (int i = size - 1; i >= 0; i--) {
            if(o.equals(container[i])) {
                return i;
            }
        }

        return -1;
    }

    @Override
    public ammunition set (int index, ammunition e) throws IndexOutOfBoundsException {
        if (index < 0 || index >= size){
            throw new IndexOutOfBoundsException("Out of range exception");
        }

        ammunition tmp = container[index];
        container[index] = e;
        return tmp;
    }

    @Override
    public Vector subList(int fromIndex, int toIndex) {
        Vector result = new Vector();
        for (int i = fromIndex; i < size && i < toIndex; i++) {
            result.add(container[i]);
        }
        return result;
    }

    @Override
    public ListIterator<ammunition> listIterator() {
        return Arrays.asList(container).listIterator();
    }

    @Override
    public ListIterator<ammunition> listIterator(int index) throws IndexOutOfBoundsException {
        if (index >= 0  && index < size) {
            return Arrays.asList(container).listIterator(index);
        } else {
            throw new IndexOutOfBoundsException("Out of range exception");
        }
    }

    @Override
    public int indexOf(Object o) {
        for (int i = 0; i < size; i++) {
            if (o.equals(container[i])) {
                return i;
            }
        }

        return -1;
    }

    @Override
    public ammunition remove(int index) throws IndexOutOfBoundsException {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException("Out of range exception");
        }

        ammunition tmp = container[index];
        size--;
        for (int i = index; i < size; i++) {
            container[i] = container[i + 1];
        }

        return tmp;
    }


    @Override
    public void add(int index, ammunition e) throws IndexOutOfBoundsException {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException("Out of range exception");
        }

        size++;
        for (int i = size - 1; i > index; i--) {
            container[i] = container[i-1];
        }
        container[index] = e;
    }

    @Override
    public void clear() {
        size = 0;
        length = BASE_SIZE;
        container = new ammunition[BASE_SIZE];
    }

    @Override
    public boolean remove(Object o) {
        for (int i = 0; i < size; i++) {
            if (o.equals(container[i])) {
                remove(i);
                return true;
            }
        }

        return false;
    }

    @Override
    public boolean isEmpty() {
        return size == 0;
    }

    @Override
    public boolean contains(Object o) {
        for (int i = 0; i < size; i++) {
            if (o.equals(container[i])) {
                return true;
            }
        }

        return false;
    }

    @Override
    public boolean addAll(Collection<? extends ammunition> c) {
        for (ammunition x : c) {
            add(x);
        }
        return true;
    }

    @Override
    public boolean containsAll(Collection<?> c) {
        for (Object x: c) {
            if (!contains(x)) return false;
        }

        return true;
    }

    @Override
    public Iterator<ammunition> iterator() {
        return Arrays.stream(container).iterator();
    }

    @Override
    public boolean retainAll(Collection<?> c) {
        for (Object x: c) {
            for (int i = 0; i < size; i++) {
                if (!x.equals(container[i])) {
                    remove(i);
                }
            }
        }

        return true;
    }


    @Override
    public boolean removeAll(Collection<?> c) {
        for (Object x : c) {
            for (int i = 0; i < size; i++) {
                if (x.equals(container[i])) {
                    remove(i);
                }
            }
        }

        return true;
    }
}
