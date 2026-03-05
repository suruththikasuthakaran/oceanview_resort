package service;

import dao.ReservationDAO;
import model.Reservation;

import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * Singleton service for reservation business logic.
 * Pattern: Singleton
 */
public class ReservationService {

    private static ReservationService instance;
    private final ReservationDAO reservationDAO;

    private ReservationService() {
        reservationDAO = new ReservationDAO();
    }

    public static synchronized ReservationService getInstance() {
        if (instance == null) {
            instance = new ReservationService();
        }
        return instance;
    }

    /**
     * Creates a new reservation with auto reservation number and calculated total.
     * Returns reservation_id on success, or -1 on failure.
     * Pattern: Factory method for reservation no generation
     */
    public int createReservation(Reservation r) {
        if (r == null) return -1;
        if (r.getFullName() == null || r.getFullName().trim().isEmpty()) return -1;
        if (r.getCheckIn() == null || r.getCheckOut() == null) return -1;
        if (!r.getCheckOut().after(r.getCheckIn())) return -1;

        // Auto-generate reservation number
        String reservationNo = reservationDAO.getNextReservationNo();
        r.setReservationNo(reservationNo);

        // Calculate total amount based on nights (base rate per room type)
        double total = calculateTotal(r);
        r.setTotalAmount(total);

        return reservationDAO.addReservation(r);
    }

    private double calculateTotal(Reservation r) {
        long diffMs = r.getCheckOut().getTime() - r.getCheckIn().getTime();
        long nights = Math.max(1, TimeUnit.DAYS.convert(diffMs, TimeUnit.MILLISECONDS));

        double pricePerNight = getRoomPrice(r.getRoomType());
        double total = nights * pricePerNight * r.getGuestCount();

        // Add food package cost if selected
        if (r.getFoodPackage() != null && !r.getFoodPackage().isEmpty()) {
            total += 25.0 * nights; // base food package cost per night
        }

        return total;
    }

    private double getRoomPrice(String roomType) {
        if (roomType == null) return 100.0;
        switch (roomType.toUpperCase()) {
            case "SINGLE":   return 80.0;
            case "DOUBLE":   return 120.0;
            case "DELUXE":   return 180.0;
            case "SUITE":    return 300.0;
            default:         return 100.0;
        }
    }

    public Reservation getByReservationNo(String no) {
        return reservationDAO.getByReservationNo(no);
    }

    public Reservation getById(int id) {
        return reservationDAO.getById(id);
    }

    public List<Reservation> getAllReservations() {
        return reservationDAO.getAllReservations();
    }

    public List<Reservation> searchReservations(String query, String checkIn, String checkOut) {
        return reservationDAO.searchReservations(query, checkIn, checkOut);
    }

    public boolean confirmReservation(int reservationId) {
        return reservationDAO.updateStatus(reservationId, "CONFIRMED");
    }

    public boolean cancelReservation(int reservationId) {
        return reservationDAO.updateStatus(reservationId, "CANCELLED");
    }
}