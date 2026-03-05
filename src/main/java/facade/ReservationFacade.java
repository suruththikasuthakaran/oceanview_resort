//package facade;
//
//import model.Reservation;
//import service.ReservationService;
//
//import java.util.List;
//
//public class ReservationFacade {
//
//    private ReservationService reservationService;
//
//    public ReservationFacade() {
//        reservationService = new ReservationService();
//    }
//
//    public boolean makeReservation(Reservation reservation) {
//        return reservationService.createReservation(reservation);
//    }
//
//    public List<Reservation> getAllReservations() {
//        return reservationService.getAllReservations();
//    }
//}