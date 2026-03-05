package service;

import dao.EventPackageDAO;
import model.EventPackage;

import java.util.ArrayList;
import java.util.List;

public class EventPackageService {

    private EventPackageDAO eventDAO = new EventPackageDAO();

    public boolean addEventPackage(EventPackage event) {
        if (event == null) return false;
        if (event.getName() == null || event.getName().isEmpty()) return false;
        if (event.getPrice() <= 0) return false;

        return eventDAO.addEventPackage(event);
    }

    public List<EventPackage> getAllEventPackages() {
        return eventDAO.getAllEventPackages();
    }

    public List<EventPackage> getEventsWithPagination(int offset, int limit) {
        if (limit <= 0) return new ArrayList<>();
        return eventDAO.getEventsWithPagination(Math.max(0, offset), limit);
    }

    public int getTotalEventCount() {
        return eventDAO.getTotalEventCount();
    }

    public EventPackage getEventPackageById(int eventId) {
        return eventDAO.getEventPackageById(eventId);
    }

    public boolean updateEventPackage(EventPackage event) {
        if (event == null || event.getEventId() <= 0) return false;
        if (event.getName() == null || event.getName().isEmpty()) return false;
        if (event.getPrice() <= 0) return false;

        return eventDAO.updateEventPackage(event);
    }

    public boolean deleteEventPackage(int eventId) {
        return eventDAO.deleteEventPackage(eventId);
    }

    public List<EventPackage> searchEventPackages(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getAllEventPackages();
        }
        return eventDAO.searchEventPackages(query.trim());
    }
}