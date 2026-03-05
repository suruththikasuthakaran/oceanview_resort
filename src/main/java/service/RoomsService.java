package service;

import dao.RoomsDAO;
import model.Rooms;

import java.util.List;

public class RoomsService {

    private static RoomsService instance;
    private RoomsDAO roomsDAO;

    // Private constructor → Singleton
    private RoomsService() {
        roomsDAO = new RoomsDAO();
    }

    // Get singleton instance
    public static synchronized RoomsService getInstance() {
        if (instance == null) {
            instance = new RoomsService();
        }
        return instance;
    }

    // Business logic methods
    public boolean addRoom(Rooms room) {
        // Example: Validate room price
        if (room.getPrice() <= 0 || room.getCapacity() <= 0) {
            return false;
        }
        return roomsDAO.addRoom(room);
    }

    public boolean updateRoom(Rooms room) {
        if (room.getRoomId() <= 0) return false;
        return roomsDAO.updateRoom(room);
    }

    public boolean deleteRoom(int roomId) {
        return roomsDAO.deleteRoom(roomId);
    }

    public List<Rooms> getAllRooms() {
        return roomsDAO.getAllRooms();
    }

    public Rooms getRoomById(int roomId) {
        return roomsDAO.getRoomById(roomId);
    }

    public List<Rooms> searchRooms(String roomNumber, String roomType, String status) {
        return roomsDAO.searchRooms(roomNumber, roomType, status);
    }

    public List<Rooms> getPaginatedRooms(int offset, int limit) {
        return roomsDAO.getPaginatedRooms(offset, limit);
    }

    public int getTotalRoomsCount() {
        return roomsDAO.getTotalRoomsCount();
    }

    public int getAvailableRoomsCount() {
        return roomsDAO.getAvailableRoomsCount();
    }

    public String getLatestRoomNumber() {
        return roomsDAO.getLatestRoomNumber();
    }
}