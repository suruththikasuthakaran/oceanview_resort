package command.rooms;

import command.Command;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Rooms;
import service.RoomsService;

import java.io.IOException;
import java.util.List;

public class ListRoomsCommand implements Command {
    private RoomsService roomsService;

    public ListRoomsCommand() {
        this.roomsService = RoomsService.getInstance();
    }

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Rooms> roomsList = roomsService.getAllRooms();
        request.setAttribute("roomsList", roomsList);
        request.getRequestDispatcher("/staff/manageRooms.jsp").forward(request, response);
    }
}
