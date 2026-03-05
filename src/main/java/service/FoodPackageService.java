package service;

import dao.FoodPackageDAO;
import model.FoodPackage;

import java.util.List;

public class FoodPackageService {

    private static FoodPackageService instance;
    private FoodPackageDAO foodDAO;

    private FoodPackageService() {
        foodDAO = new FoodPackageDAO();
    }

    public static FoodPackageService getInstance() {
        if (instance == null) {
            instance = new FoodPackageService();
        }
        return instance;
    }

    public boolean saveFoodPackage(FoodPackage food) {
        return foodDAO.addFoodPackage(food);
    }

    public List<FoodPackage> getAllFoodPackages() {
        return foodDAO.getAllFoodPackages();
    }

    public FoodPackage getFoodPackageById(int packageId) {
        return foodDAO.getFoodPackageById(packageId);
    }

    public boolean updateFoodPackage(FoodPackage food) {
        return foodDAO.updateFoodPackage(food);
    }

    public boolean deleteFoodPackage(int packageId) {
        return foodDAO.deleteFoodPackage(packageId);
    }

    public List<FoodPackage> searchFoodPackages(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getAllFoodPackages();
        }
        return foodDAO.searchFoodPackages(query.trim());
    }
}