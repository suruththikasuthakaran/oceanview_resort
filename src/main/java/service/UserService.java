package service;

import dao.UserDAO;
import model.User;

import java.util.List;

public class UserService {

    private UserDAO userDAO = new UserDAO();

    public String registerUser(User user) {
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            return "Username cannot be empty.";
        }
        if (user.getPassword() == null || user.getPassword().length() < 4) {
            return "Password must be at least 4 characters long.";
        }
        
        if (userDAO.isUsernameExists(user.getUsername())) {
            return "Username already exists. Please choose another.";
        }
        
        boolean saved = userDAO.addUser(user);
        if (saved) {
            return null; // Success
        } else {
            return "Registration failed due to a database error.";
        }
    }

    public User loginUser(String username, String password) {
        if(username == null || username.isEmpty()) return null;
        if(password == null || password.isEmpty()) return null;
        return userDAO.login(username, password);
    }

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public List<User> searchUsers(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getAllUsers();
        }
        return userDAO.searchUsers(query.trim());
    }

    public boolean deleteUser(int userId) {
        if (userId <= 0) return false;
        return userDAO.deleteUser(userId);
    }
}