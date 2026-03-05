package model;

import java.sql.Date;
import java.sql.Timestamp;

public class Reservation {

    private int reservationId;
    private String reservationNo;
    private int userId;
    private String fullName;
    private String address;
    private String email;
    private String nic;
    private Date checkIn;
    private Date checkOut;
    private int guestCount;
    private String roomType;
    private String foodPackage;
    private double totalAmount;
    private String status;
    private Timestamp createdAt;

    public Reservation() {}

    public Reservation(String reservationNo, int userId, String fullName,
                       String address, String email, String nic,
                       Date checkIn, Date checkOut, int guestCount,
                       String roomType, String foodPackage) {

        this.reservationNo = reservationNo;
        this.userId = userId;
        this.fullName = fullName;
        this.address = address;
        this.email = email;
        this.nic = nic;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.guestCount = guestCount;
        this.roomType = roomType;
        this.foodPackage = foodPackage;
    }

    // Getters and Setters

    public int getReservationId() { return reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }

    public String getReservationNo() { return reservationNo; }
    public void setReservationNo(String reservationNo) { this.reservationNo = reservationNo; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public Date getCheckIn() { return checkIn; }
    public void setCheckIn(Date checkIn) { this.checkIn = checkIn; }

    public Date getCheckOut() { return checkOut; }
    public void setCheckOut(Date checkOut) { this.checkOut = checkOut; }

    public int getGuestCount() { return guestCount; }
    public void setGuestCount(int guestCount) { this.guestCount = guestCount; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public String getFoodPackage() { return foodPackage; }
    public void setFoodPackage(String foodPackage) { this.foodPackage = foodPackage; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}