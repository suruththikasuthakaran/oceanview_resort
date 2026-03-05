package command.rooms;

import command.Command;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.RoomsService;

import java.io.IOException;

public class DeleteRoomCommand implements Command {
    private RoomsService roomsService;

    public DeleteRoomCommand() {
        this.roomsService = RoomsService.getInstance();
    }

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int deleteId = Integer.parseInt(request.getParameter("roomId"));
            roomsService.deleteRoom(deleteId);
        } catch (NumberFormatException ignore) {
        }
        response.sendRedirect(request.getContextPath() + "/rooms?action=list");
    }
}
