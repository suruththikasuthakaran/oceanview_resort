package command.rooms;

import command.Command;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Rooms;
import service.RoomsService;

import java.io.IOException;
import java.util.List;

public class SearchRoomsCommand implements Command {
    private RoomsService roomsService;

    public SearchRoomsCommand() {
        this.roomsService = RoomsService.getInstance();
    }

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomNumber = request.getParameter("roomNumber");
        String roomType = request.getParameter("roomType");
        String status = request.getParameter("status");

        if (roomNumber == null) roomNumber = "";
        if (roomType == null) roomType = "";
        if (status == null) status = "";

        List<Rooms> searchList = roomsService.searchRooms(roomNumber, roomType, status);
        request.setAttribute("roomsList", searchList);
        request.getRequestDispatcher("/staff/manageRooms.jsp").forward(request, response);
    }
}
