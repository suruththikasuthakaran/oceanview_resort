package validation;

import model.Payment;

public abstract class PaymentValidationHandler {

    protected PaymentValidationHandler next;

    public void setNext(PaymentValidationHandler next) {
        this.next = next;
    }

    public abstract boolean validate(Payment payment);
}