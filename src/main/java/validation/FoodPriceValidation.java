package validation;

import model.FoodPackage;

public class FoodPriceValidation extends FoodValidationHandler {

    @Override
    public boolean validate(FoodPackage food) {
        if (food.getPrice() <= 0) {
            return false;
        }
        return next == null || next.validate(food);
    }
}