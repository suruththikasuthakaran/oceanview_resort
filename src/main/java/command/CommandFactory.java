package command;

import command.rooms.*;

import java.util.HashMap;
import java.util.Map;

public class CommandFactory {
    private static CommandFactory instance;
    private final Map<String, Command> commands;

    private CommandFactory() {
        commands = new HashMap<>();
        commands.put("list", new ListRoomsCommand());
        commands.put("publicList", new PublicRoomsCommand());
        commands.put("addForm", new ForwardCommand("/staff/addRoom.jsp"));
        commands.put("editForm", new EditRoomFormCommand());
        commands.put("delete", new DeleteRoomCommand());
        commands.put("search", new SearchRoomsCommand());
        commands.put("add", new AddRoomCommand());
        commands.put("update", new UpdateRoomCommand());
    }

    public static synchronized CommandFactory getInstance() {
        if (instance == null) {
            instance = new CommandFactory();
        }
        return instance;
    }

    public Command getCommand(String action) {
        if (action == null || !commands.containsKey(action)) {
            return commands.get("list");
        }
        return commands.get(action);
    }
}
