package model;

import java.sql.Timestamp;

public class Rooms {

    private int roomId;
    private String roomNumber;
    private String roomType;
    private double price;
    private int capacity;
    private String bedType;
    private String description;
    private String status;
    private String image;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Rooms() {}

    public Rooms(String roomNumber, String roomType, double price, int capacity,
                String bedType, String description, String status, String image) {
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.price = price;
        this.capacity = capacity;
        this.bedType = bedType;
        this.description = description;
        this.status = status;
        this.image = image;
    }

    public Rooms(int roomId, String roomNumber, String roomType, double price, int capacity,
                String bedType, String description, String status, String image) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.price = price;
        this.capacity = capacity;
        this.bedType = bedType;
        this.description = description;
        this.status = status;
        this.image = image;
    }

    // Getters and Setters

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }

    public String getBedType() { return bedType; }
    public void setBedType(String bedType) { this.bedType = bedType; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
}