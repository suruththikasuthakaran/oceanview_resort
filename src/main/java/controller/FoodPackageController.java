package controller;

import factory.FoodPackageFactory;
import iterator.FoodPackageIterator;
import model.FoodPackage;
import service.FoodPackageService;
import validation.FoodNameValidation;
import validation.FoodPriceValidation;
import validation.FoodValidationHandler;

import java.util.ArrayList;
import java.util.List;

public class FoodPackageController {

    private static FoodPackageController instance;
    private FoodPackageService service;

    private FoodPackageController() {
        service = FoodPackageService.getInstance();
    }

    public static FoodPackageController getInstance() {
        if (instance == null) {
            instance = new FoodPackageController();
        }
        return instance;
    }

    /**-
     *
     * Add new food package using
     * Factory + Chain of Responsibility + Singleton
     */
    public boolean addFoodPackage(String name, double price, String description, String image) {

        // 1️⃣ Factory Pattern
        FoodPackage food = FoodPackageFactory.createFoodPackage(name, price, description, image);

        // 2️⃣ Chain of Responsibility (Validation)
        FoodValidationHandler nameValidation = new FoodNameValidation();
        FoodValidationHandler priceValidation = new FoodPriceValidation();

        nameValidation.setNext(priceValidation);

        if (!nameValidation.validate(food)) {
            return false;
        }

        // 3️⃣ Singleton Service
        return service.saveFoodPackage(food);
    }

    /**
     * Get all food packages using Iterator pattern
     */
    public List<FoodPackage> getAllFoodPackages() {

        List<FoodPackage> originalList = service.getAllFoodPackages();
        List<FoodPackage> result = new ArrayList<>();

        // 4️⃣ Iterator Pattern
        FoodPackageIterator iterator = new FoodPackageIterator(originalList);

        while (iterator.hasNext()) {
            result.add(iterator.next());
        }

        return result;
    }

    public FoodPackage getFoodPackageById(int packageId) {
        return service.getFoodPackageById(packageId);
    }

    public boolean updateFoodPackage(int packageId, String name, double price, String description, String image) {
        FoodPackage food = new FoodPackage(name, price, description, image);
        food.setPackageId(packageId);

        FoodValidationHandler nameValidation = new FoodNameValidation();
        FoodValidationHandler priceValidation = new FoodPriceValidation();
        nameValidation.setNext(priceValidation);

        if (!nameValidation.validate(food)) {
            return false;
        }

        return service.updateFoodPackage(food);
    }

    public boolean deleteFoodPackage(int packageId) {
        return service.deleteFoodPackage(packageId);
    }

    public List<FoodPackage> searchFoodPackages(String query) {
        return service.searchFoodPackages(query);
    }
}