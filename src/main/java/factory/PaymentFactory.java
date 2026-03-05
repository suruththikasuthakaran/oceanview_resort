package factory;

import model.Payment;
import model.PaymentMethod;
import model.PaymentStatus;

public class PaymentFactory {

    public static Payment createPayment(int reservationId, double amount, String method) {

        PaymentMethod paymentMethod = PaymentMethod.valueOf(method.toUpperCase());

        Payment payment = new Payment();
        payment.setReservationId(reservationId);
        payment.setAmount(amount);
        payment.setPaymentMethod(paymentMethod);
        payment.setStatus(PaymentStatus.PENDING);

        return payment;
    }
}