package controller;

import model.EventPackage;
import service.EventPackageService;

import java.util.List;

/**
 * EventPackageController acts as a Facade to the EventPackageService.
 * It exposes simple methods for the frontend (JSP/Servlet) to interact with event packages.
 * This uses the Facade design pattern to hide the complexity of service interactions.
 */
public class EventPackageController {

    private EventPackageService eventService;

    // Singleton pattern: Only one controller instance for the application
    private static EventPackageController instance;

    private EventPackageController() {
        this.eventService = new EventPackageService();
    }

    public static EventPackageController getInstance() {
        if (instance == null) {
            instance = new EventPackageController();
        }
        return instance;
    }

    /**
     * Add a new event package
     * @param name Event name
     * @param price Event price
     * @param description Event description
     * @param image Event image path
     * @return true if added successfully
     */
    public boolean addEventPackage(String name, double price, String description, String image) {
        EventPackage event = new EventPackage(name, price, description, image);
        return eventService.addEventPackage(event);
    }

    /**
     * Get all event packages
     * @return List of EventPackage
     */
    public List<EventPackage> getAllEventPackages() {
        return eventService.getAllEventPackages();
    }

    public List<EventPackage> getEventsWithPagination(int offset, int limit) {
        return eventService.getEventsWithPagination(offset, limit);
    }

    public int getTotalEventCount() {
        return eventService.getTotalEventCount();
    }

    /**
     * Find event by ID
     * @param eventId Event ID
     * @return EventPackage object or null if not found
     */
    public EventPackage getEventById(int eventId) {
        return eventService.getEventPackageById(eventId);
    }

    /**
     * Update an existing event package
     * @param event The event package with updated details
     * @return true if successful
     */
    public boolean updateEvent(EventPackage event) {
        return eventService.updateEventPackage(event);
    }

    /**
     * Delete an event package
     * @param eventId The ID of the event to delete
     * @return true if successful
     */
    public boolean deleteEvent(int eventId) {
        return eventService.deleteEventPackage(eventId);
    }

    /**
     * Search for events
     * @param query Search string
     * @return List of matching events
     */
    public List<EventPackage> searchEvents(String query) {
        return eventService.searchEventPackages(query);
    }
}