package iterator;

import model.FoodPackage;
import java.util.Iterator;
import java.util.List;

public class FoodPackageIterator implements Iterator<FoodPackage> {

    private List<FoodPackage> list;
    private int position = 0;

    public FoodPackageIterator(List<FoodPackage> list) {
        this.list = list;
    }

    @Override
    public boolean hasNext() {
        return position < list.size();
    }

    @Override
    public FoodPackage next() {
        return list.get(position++);
    }
}