package factory;

import model.FoodPackage;

public class FoodPackageFactory {

    public static FoodPackage createFoodPackage(String name, double price, String description, String image) {
        return new FoodPackage(name, price, description, image);
    }
}