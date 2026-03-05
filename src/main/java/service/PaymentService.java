package service;

import dao.PaymentDAO;
import model.Payment;
import model.PaymentStatus;

import java.util.List;

public class PaymentService {

    private static PaymentService instance;
    private PaymentDAO paymentDAO;

    private PaymentService() {
        paymentDAO = new PaymentDAO();
    }

    public static PaymentService getInstance() {
        if (instance == null) {
            instance = new PaymentService();
        }
        return instance;
    }

    public boolean processPayment(Payment payment) {
        if (payment == null) return false;
        payment.setStatus(PaymentStatus.SUCCESS);
        return paymentDAO.addPayment(payment);
    }

    public List<Payment> getAllPayments() {
        return paymentDAO.getAllPayments();
    }

    public List<Payment> searchPayments(String query, String status, String startDate, String endDate) {
        return paymentDAO.searchPayments(query, status, startDate, endDate);
    }
}