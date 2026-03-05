package model;

import java.util.Date;

public class EventBooking {
    private int bookingId;
    private int userId;
    private int eventId;
    private String phone;
    private int guests;
    private Date eventDate;
    private String specialRequests;
    private String status;
    private Date createdAt;
    
    // Transient fields for joined data
    private String userFullName;
    private String eventName;

    // Constructors
    public EventBooking() {}

    public EventBooking(int userId, int eventId, String phone, int guests, Date eventDate, String specialRequests) {
        this.userId = userId;
        this.eventId = eventId;
        this.phone = phone;
        this.guests = guests;
        this.eventDate = eventDate;
        this.specialRequests = specialRequests;
        this.status = "PENDING";
    }

    // Getters and Setters
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getEventId() { return eventId; }
    public void setEventId(int eventId) { this.eventId = eventId; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getGuests() { return guests; }
    public void setGuests(int guests) { this.guests = guests; }

    public Date getEventDate() { return eventDate; }
    public void setEventDate(Date eventDate) { this.eventDate = eventDate; }

    public String getSpecialRequests() { return specialRequests; }
    public void setSpecialRequests(String specialRequests) { this.specialRequests = specialRequests; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public String getUserFullName() { return userFullName; }
    public void setUserFullName(String userFullName) { this.userFullName = userFullName; }

    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }
}
