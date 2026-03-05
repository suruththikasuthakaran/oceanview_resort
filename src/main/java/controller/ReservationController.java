package controller;

import model.Reservation;
import model.User;
import service.EventBookingService;
import service.FoodPackageService;
import service.ReservationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

/**
 * Handles all reservation-related HTTP requests.
 * Uses Singleton ReservationService and delegates to JSP views.
 * Pattern: Front Controller + Command dispatch via action parameter
 */
@WebServlet("/reservation")
public class ReservationController extends HttpServlet {

    private final ReservationService reservationService = ReservationService.getInstance();
    private final FoodPackageService foodService = FoodPackageService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("viewAll".equals(action)) {
            // Staff: list all reservations (Rooms + Events)
            List<Reservation> combinedList = reservationService.getAllReservations();
            
            // Add Event Bookings as virtual reservations
            List<model.EventBooking> eventBookings = EventBookingService.getInstance().getAllBookingsJoined();
            for (model.EventBooking eb : eventBookings) {
                combinedList.add(convertToReservation(eb));
            }
            
            // Sort combined list by created_at (descending)
            combinedList.sort((r1, r2) -> {
                if (r1.getCreatedAt() == null || r2.getCreatedAt() == null) return 0;
                return r2.getCreatedAt().compareTo(r1.getCreatedAt());
            });

            request.setAttribute("reservationList", combinedList);
            request.getRequestDispatcher("/staff/manageReservation.jsp").forward(request, response);

        } else if ("search".equals(action)) {
            String query = request.getParameter("query");
            String checkIn = request.getParameter("checkIn");
            String checkOut = request.getParameter("checkOut");
            
            // Search Room Reservations with dates
            List<Reservation> combinedList = reservationService.searchReservations(query, checkIn, checkOut);
            
            // For Event Bookings, we only search by query (since they don't have check-in/out dates in the same way)
            if (checkIn == null || checkIn.isEmpty()) {
                try {
                    List<model.EventBooking> eventBookings = EventBookingService.getInstance().searchBookingsJoined(query);
                    for (model.EventBooking eb : eventBookings) {
                        combinedList.add(convertToReservation(eb));
                    }
                } catch (Exception e) { /* Ignore if event system fails */ }
            }
            
            // Sort combined list by created_at (descending)
            combinedList.sort((r1, r2) -> {
                if (r1.getCreatedAt() == null || r2.getCreatedAt() == null) return 0;
                return r2.getCreatedAt().compareTo(r1.getCreatedAt());
            });

            request.setAttribute("reservationList", combinedList);
            request.setAttribute("searchQuery", query);
            request.setAttribute("searchCheckIn", checkIn);
            request.setAttribute("searchCheckOut", checkOut);
            request.getRequestDispatcher("/staff/manageReservation.jsp").forward(request, response);

        } else if ("details".equals(action)) {
            // Show reservation details by reservation number
            String resNo = request.getParameter("no");
            Reservation reservation = reservationService.getByReservationNo(resNo);
            if (reservation == null) {
                response.sendRedirect(request.getContextPath() + "/customer/reservation.jsp?error=notfound");
                return;
            }
            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/customer/reservationDetails.jsp").forward(request, response);

        } else if ("staffDetails".equals(action)) {
            // Staff view reservation details
            String resNo = request.getParameter("no");
            Reservation reservation = reservationService.getByReservationNo(resNo);
            if (reservation == null) {
                response.sendRedirect(request.getContextPath() + "/staff/manageReservation.jsp?error=notfound");
                return;
            }
            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/staff/reservationDetails.jsp").forward(request, response);
        } else {
            // Show reservation form (login required)
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("currentUser") == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?redirect=reservation");
                return;
            }

            // Pre-fill user info from session
            User user = (User) session.getAttribute("currentUser");
            request.setAttribute("user", user);

            // Load food packages for optional selection
            FoodPackageService fps = FoodPackageService.getInstance();
            request.setAttribute("foodPackages", fps.getAllFoodPackages());

            // Pre-fill room type if coming from room page
            String roomType = request.getParameter("roomType");
            if (roomType != null) request.setAttribute("preselectedRoom", roomType);

            // Pre-fill food package if coming from foods page
            String foodPackage = request.getParameter("foodPackage");
            if (foodPackage != null) request.setAttribute("preselectedFood", foodPackage);

            request.getRequestDispatcher("/customer/reservation.jsp").forward(request, response);
        }
    }

    private Reservation convertToReservation(model.EventBooking eb) {
        Reservation r = new Reservation();
        r.setReservationId(eb.getBookingId());
        r.setReservationNo("EVT-" + eb.getBookingId());
        r.setFullName(eb.getUserFullName() != null ? eb.getUserFullName() : "Guest");
        
        if (eb.getEventDate() != null) {
            r.setCheckIn(new java.sql.Date(eb.getEventDate().getTime()));
            r.setCheckOut(new java.sql.Date(eb.getEventDate().getTime()));
            r.setCreatedAt(new java.sql.Timestamp(eb.getEventDate().getTime()));
        } else {
            // Default to current time if no event date found
            long now = System.currentTimeMillis();
            r.setCheckIn(new java.sql.Date(now));
            r.setCheckOut(new java.sql.Date(now));
            r.setCreatedAt(new java.sql.Timestamp(now));
        }
        
        r.setRoomType(eb.getEventName() != null ? eb.getEventName() : "Event");
        r.setGuestCount(eb.getGuests());
        r.setStatus(eb.getStatus() != null ? eb.getStatus() : "PENDING");
        return r;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("confirm".equals(action)) {
            // Confirm a pending reservation → update status, redirect to payment
            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            reservationService.confirmReservation(reservationId);
            response.sendRedirect(request.getContextPath() +
                    "/customer/paymentMethod.jsp?reservationId=" + reservationId + "&amount=" + amount);
            return;
        }

        if ("cancel".equals(action)) {
            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            reservationService.cancelReservation(reservationId);
            response.sendRedirect(request.getContextPath() + "/reservation?action=viewAll");
            return;
        }

        // Book new reservation
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("currentUser");

        try {
            Reservation r = new Reservation();
            r.setUserId(user.getUserId());
            r.setFullName(request.getParameter("fullName"));
            r.setAddress(request.getParameter("address"));
            r.setEmail(request.getParameter("email"));
            r.setNic(request.getParameter("nic"));
            r.setCheckIn(Date.valueOf(request.getParameter("checkIn")));
            r.setCheckOut(Date.valueOf(request.getParameter("checkOut")));
            r.setGuestCount(Integer.parseInt(request.getParameter("guestCount")));
            r.setRoomType(request.getParameter("roomType"));
            r.setFoodPackage(request.getParameter("foodPackage")); // optional, can be null

            int id = reservationService.createReservation(r);

            if (id > 0) {
                response.sendRedirect(request.getContextPath() +
                        "/reservation?action=details&no=" + r.getReservationNo());
            } else {
                request.setAttribute("error", "Reservation failed. Please check your inputs.");
                FoodPackageService fps = FoodPackageService.getInstance();
                request.setAttribute("foodPackages", fps.getAllFoodPackages());
                request.setAttribute("user", user);
                request.getRequestDispatcher("/customer/reservation.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input. Please fill all fields correctly.");
            FoodPackageService fps = FoodPackageService.getInstance();
            request.setAttribute("foodPackages", fps.getAllFoodPackages());
            request.setAttribute("user", user);
            request.getRequestDispatcher("/customer/reservation.jsp").forward(request, response);
        }
    }
}