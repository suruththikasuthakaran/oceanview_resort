package controller;

import factory.PaymentFactory;
import model.Payment;
import model.User;
import model.Role;
import service.PaymentService;
import validation.AmountValidation;
import validation.PaymentValidationHandler;
import validation.ReservationValidation;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Handles payment processing from all payment pages (QR, Card, Cash)
 * and payment history management for staff.
 */
@WebServlet("/payment")
public class PaymentController extends HttpServlet {

    private final PaymentService paymentService = PaymentService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        // Staff protection
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || (currentUser.getRole() != Role.STAFF && currentUser.getRole() != Role.ADMIN)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if ("history".equalsIgnoreCase(action)) {
            request.setAttribute("paymentList", paymentService.getAllPayments());
            request.getRequestDispatcher("/staff/paymentHistory.jsp").forward(request, response);
        } else if ("search".equalsIgnoreCase(action)) {
            String query = request.getParameter("query");
            String status = request.getParameter("status");
            String start = request.getParameter("checkIn");
            String end = request.getParameter("checkOut");
            
            request.setAttribute("paymentList", paymentService.searchPayments(query, status, start, end));
            request.setAttribute("searchQuery", query);
            request.setAttribute("searchStatus", status);
            request.setAttribute("searchStart", start);
            request.setAttribute("searchEnd", end);
            request.getRequestDispatcher("/staff/paymentHistory.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            String method = request.getParameter("paymentMethod");

            /* 1. Create Payment via Factory Pattern */
            Payment payment = PaymentFactory.createPayment(reservationId, amount, method);

            /* 2. Validate via Chain of Responsibility */
            PaymentValidationHandler reservationValidation = new ReservationValidation();
            PaymentValidationHandler amountValidation = new AmountValidation();
            reservationValidation.setNext(amountValidation);

            boolean valid = reservationValidation.validate(payment);
            if (!valid) {
                String payPage = getPaymentPage(method);
                request.setAttribute("error", "Invalid payment details. Please try again.");
                request.getRequestDispatcher("/customer/" + payPage +
                        "?reservationId=" + reservationId + "&amount=" + amount)
                        .forward(request, response);
                return;
            }

            /* 3. Process via Singleton Service */
            boolean success = paymentService.processPayment(payment);

            if (success) {
                request.setAttribute("message", "Payment of $" + String.format("%.2f", amount) +
                        " via " + method + " was successful!");
                request.getRequestDispatcher("/customer/paymentSuccess.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Payment processing failed. Please try again.");
                request.getRequestDispatcher("/customer/paymentMethod.jsp" +
                        "?reservationId=" + reservationId + "&amount=" + amount)
                        .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/customer/paymentMethod.jsp");
        }
    }

    private String getPaymentPage(String method) {
        if ("QR".equals(method))   return "qrPayment.jsp";
        if ("CARD".equals(method)) return "cardPayment.jsp";
        return "cashPayment.jsp";
    }
}