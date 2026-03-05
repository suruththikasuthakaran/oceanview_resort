package validation;

import model.Payment;

public class ReservationValidation extends PaymentValidationHandler {

    @Override
    public boolean validate(Payment payment) {
        if (payment.getReservationId() <= 0) {
            return false;
        }
        return next == null || next.validate(payment);
    }
}