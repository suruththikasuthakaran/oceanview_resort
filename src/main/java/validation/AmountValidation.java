package validation;

import model.Payment;

public class AmountValidation extends PaymentValidationHandler {

    @Override
    public boolean validate(Payment payment) {
        if (payment.getAmount() <= 0) {
            return false;
        }
        return next == null || next.validate(payment);
    }
}