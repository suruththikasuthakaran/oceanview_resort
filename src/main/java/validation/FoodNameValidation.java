package validation;

import model.FoodPackage;

public class FoodNameValidation extends FoodValidationHandler {

    @Override
    public boolean validate(FoodPackage food) {
        if (food.getName() == null || food.getName().isEmpty()) {
            return false;
        }
        return next == null || next.validate(food);
    }
}