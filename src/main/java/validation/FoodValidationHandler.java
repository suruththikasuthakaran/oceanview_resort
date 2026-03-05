package validation;

import model.FoodPackage;

public abstract class FoodValidationHandler {

    protected FoodValidationHandler next;

    public void setNext(FoodValidationHandler next) {
        this.next = next;
    }

    public abstract boolean validate(FoodPackage food);
}