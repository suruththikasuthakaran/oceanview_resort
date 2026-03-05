package command.rooms;

import command.Command;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Rooms;
import service.RoomsService;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class UpdateRoomCommand implements Command {
    private RoomsService roomsService;

    public UpdateRoomCommand() {
        this.roomsService = RoomsService.getInstance();
    }

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String roomNumber = request.getParameter("roomNumber");
            String roomType = request.getParameter("roomType");
            double price = Double.parseDouble(request.getParameter("price"));
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String bedType = request.getParameter("bedType");
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            String existingImage = request.getParameter("existingImage");

            // Handle Image Upload
            String imageName = existingImage;
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);
                String extension = fileName.substring(fileName.lastIndexOf("."));
                String newImageName = UUID.randomUUID().toString() + extension;
                
                String uploadPath = request.getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "rooms";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                
                filePart.write(uploadPath + File.separator + newImageName);
                imageName = "uploads/rooms/" + newImageName;
            }

            Rooms updatedRoom = new Rooms(
                    roomId,
                    roomNumber,
                    roomType,
                    price,
                    capacity,
                    bedType,
                    description,
                    status,
                    imageName
            );

            boolean success = roomsService.updateRoom(updatedRoom);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/rooms?action=list");
            } else {
                request.setAttribute("errorMessage", "Failed to update room.");
                request.setAttribute("room", updatedRoom);
                request.getRequestDispatcher("/staff/editRoom.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid numeric format.");
            request.getRequestDispatcher("/staff/editRoom.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/staff/editRoom.jsp").forward(request, response);
        }
    }

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return "default.jpg";
    }
}
