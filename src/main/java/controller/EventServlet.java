package controller;

import model.EventPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/events")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 15   // 15 MB
)
public class EventServlet extends HttpServlet {

    private EventPackageController eventController = EventPackageController.getInstance();
    private static final String UPLOAD_DIR = "uploads" + File.separator + "events";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        
        if ("list".equalsIgnoreCase(action)) {
            List<EventPackage> eventList = eventController.getAllEventPackages();
            request.setAttribute("eventList", eventList);
            request.getRequestDispatcher("/staff/manageEvents.jsp").forward(request, response);
            
        } else if ("search".equalsIgnoreCase(action)) {
            String query = request.getParameter("query");
            List<EventPackage> eventList = eventController.searchEvents(query);
            request.setAttribute("eventList", eventList);
            request.getRequestDispatcher("/staff/manageEvents.jsp").forward(request, response);

        } else if ("addForm".equalsIgnoreCase(action)) {
            request.getRequestDispatcher("/staff/addEvent.jsp").forward(request, response);
            
        } else if ("editForm".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("eventId");
            if (idStr != null) {
                int eventId = Integer.parseInt(idStr);
                EventPackage event = eventController.getEventById(eventId);
                request.setAttribute("event", event);
                request.getRequestDispatcher("/staff/editEvent.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/events?action=list");
            }

        } else if ("delete".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("eventId");
            if (idStr != null) {
                int eventId = Integer.parseInt(idStr);
                eventController.deleteEvent(eventId);
            }
            response.sendRedirect(request.getContextPath() + "/events?action=list");

        } else if ("customerList".equalsIgnoreCase(action)) {
            int page = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            int limit = 6; // Events per page
            int offset = (page - 1) * limit;
            int totalCount = eventController.getTotalEventCount();
            int totalPages = (int) Math.ceil((double) totalCount / limit);

            List<EventPackage> eventList = eventController.getEventsWithPagination(offset, limit);
            
            request.setAttribute("eventList", eventList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            
            request.getRequestDispatcher("/customer/events.jsp").forward(request, response);

        } else {
            response.sendRedirect(request.getContextPath() + "/staff/dashboard.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String description = request.getParameter("description");
            
            String imagePath = handleFileUpload(request);

            try {
                double price = Double.parseDouble(priceStr);
                boolean success = eventController.addEventPackage(name, price, description, imagePath);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/events?action=list");
                } else {
                    request.setAttribute("error", "Failed to add event package. Please check inputs.");
                    request.getRequestDispatcher("/staff/addEvent.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid price format. Please enter a valid number.");
                request.getRequestDispatcher("/staff/addEvent.jsp").forward(request, response);
            }

        } else if ("update".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("eventId");
            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String description = request.getParameter("description");
            String existingImage = request.getParameter("existingImage");

            String newImagePath = handleFileUpload(request);
            String finalImagePath = (newImagePath != null && !newImagePath.isEmpty()) ? newImagePath : existingImage;

            try {
                int eventId = Integer.parseInt(idStr);
                double price = Double.parseDouble(priceStr);
                
                EventPackage event = new EventPackage(name, price, description, finalImagePath);
                event.setEventId(eventId);
                
                boolean success = eventController.updateEvent(event);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/events?action=list");
                } else {
                    request.setAttribute("error", "Failed to update event package.");
                    request.setAttribute("event", event);
                    request.getRequestDispatcher("/staff/editEvent.jsp").forward(request, response);
                }
            } catch (Exception e) {
                request.setAttribute("error", "Error: " + e.getMessage());
                request.getRequestDispatcher("/staff/editEvent.jsp").forward(request, response);
            }

        } else {
            response.sendRedirect(request.getContextPath() + "/staff/dashboard.jsp");
        }
    }

    private String handleFileUpload(HttpServletRequest request) throws ServletException, IOException {
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        try {
            Part part = request.getPart("imageFile");
            if (part != null && part.getSize() > 0) {
                String fileName = getFileName(part);
                if (fileName != null && !fileName.isEmpty()) {
                    String filePath = uploadPath + File.separator + fileName;
                    part.write(filePath);
                    return UPLOAD_DIR + "/" + fileName;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return null;
    }
}
