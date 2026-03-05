//package factory;
//
//import model.*;
//import java.util.Date;
//import java.util.List;
//import java.util.UUID;
//
//public class ReservationFactory {
//
//    public static Reservation createReservation(User customer,
//                                                Rooms room,
//                                                Date checkIn,
//                                                Date checkOut,
//                                                List<FoodPackage> foodList,
//                                                List<EventPackage> eventList) {
//
//        Reservation reservation = new Reservation();
//        reservation.setCustomer(customer);
//        reservation.setRoom(room);
//        reservation.setCheckInDate(checkIn);
//        reservation.setCheckOutDate(checkOut);
//        reservation.setFoodPackages(foodList);
//        reservation.setEventPackages(eventList);
//
//        // Generate unique reservation number
//        reservation.setReservationNumber("RES-" + UUID.randomUUID().toString().substring(0,8));
//
//        return reservation;
//    }
//}