package command.rooms;

import command.Command;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Rooms;
import service.RoomsService;

import java.io.IOException;

public class EditRoomFormCommand implements Command {
    private RoomsService roomsService;

    public EditRoomFormCommand() {
        this.roomsService = RoomsService.getInstance();
    }

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            Rooms room = roomsService.getRoomById(roomId);
            request.setAttribute("room", room);
            request.getRequestDispatcher("/staff/editRoom.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/rooms?action=list");
        }
    }
}
