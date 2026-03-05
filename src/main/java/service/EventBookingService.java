package service;

import dao.EventBookingDAO;
import model.EventBooking;
import java.util.List;

public class EventBookingService {
    private static EventBookingService instance;
    private EventBookingDAO bookingDAO = EventBookingDAO.getInstance();

    private EventBookingService() {}

    public static EventBookingService getInstance() {
        if (instance == null) {
            instance = new EventBookingService();
        }
        return instance;
    }

    public boolean createBooking(EventBooking booking) {
        if (booking == null) return false;
        if (booking.getUserId() <= 0 || booking.getEventId() <= 0) return false;
        if (booking.getPhone() == null || booking.getPhone().isEmpty()) return false;
        if (booking.getGuests() <= 0) return false;
        if (booking.getEventDate() == null) return false;

        return bookingDAO.addBooking(booking);
    }

    public List<EventBooking> getAllBookingsJoined() {
        return bookingDAO.getAllBookingsJoined();
    }

    public List<EventBooking> searchBookingsJoined(String query) {
        return bookingDAO.searchBookingsJoined(query);
    }
}
