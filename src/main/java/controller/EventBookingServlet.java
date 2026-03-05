package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.EventBooking;
import model.User;
import service.EventBookingService;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/eventBooking")
public class EventBookingServlet extends HttpServlet {
    private EventBookingService bookingService = EventBookingService.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int userId = currentUser.getUserId();
            int eventId = Integer.parseInt(request.getParameter("eventType"));
            String phone = request.getParameter("phone");
            int guests = Integer.parseInt(request.getParameter("guests"));
            String dateStr = request.getParameter("date");
            String specialRequests = request.getParameter("requests");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date eventDate = sdf.parse(dateStr);

            EventBooking booking = new EventBooking(userId, eventId, phone, guests, eventDate, specialRequests);
            
            boolean success = bookingService.createBooking(booking);

            if (success) {
                response.sendRedirect("customer/bookingSuccess.jsp");
            } else {
                request.setAttribute("error", "Failed to submit booking. Please try again.");
                request.getRequestDispatcher("customer/eventBooking.jsp").forward(request, response);
            }

        } catch (NumberFormatException | ParseException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input data. Please check your form.");
            request.getRequestDispatcher("customer/eventBooking.jsp").forward(request, response);
        }
    }
}
