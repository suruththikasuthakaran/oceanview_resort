package command.rooms;

import command.Command;
import service.RoomsService;
import model.Rooms;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class PublicRoomsCommand implements Command {
    private final RoomsService roomsService = RoomsService.getInstance();
    private static final int ITEMS_PER_PAGE = 6; // Show 6 rooms per page

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        String pageParam = request.getParameter("page");
        
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int offset = (page - 1) * ITEMS_PER_PAGE;
        
        List<Rooms> roomsList = roomsService.getPaginatedRooms(offset, ITEMS_PER_PAGE);
        int totalRooms = roomsService.getTotalRoomsCount();
        int totalPages = (int) Math.ceil((double) totalRooms / ITEMS_PER_PAGE);

        request.setAttribute("roomsList", roomsList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/customer/allRooms.jsp").forward(request, response);
    }
}
