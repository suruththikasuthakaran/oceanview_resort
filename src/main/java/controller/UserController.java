package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.User;
import model.Role;
import service.UserService;

@WebServlet("/userAuth")
public class UserController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        System.out.println("UserController doPost action: " + action);

        if ("register".equalsIgnoreCase(action)) {
            handleRegister(request, response);
        } else if ("login".equalsIgnoreCase(action)) {
            handleLogin(request, response);
        } else if ("deleteUser".equalsIgnoreCase(action)) {
            handleDeleteUser(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        System.out.println("UserController doGet action: " + action);

        if ("viewUsers".equalsIgnoreCase(action)) {
            handleViewUsers(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String nic = request.getParameter("nic");
        String roleStr = request.getParameter("role");

        System.out.println("Attempting to register user: " + username + " with role: " + roleStr);

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (roleStr == null || roleStr.trim().isEmpty()) {
            request.setAttribute("error", "Role not selected.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        Role role;
        try {
            role = Role.valueOf(roleStr.trim().toUpperCase());
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid role selected.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Create user with trimmed credentials
        User user = new User(username.trim(), password.trim(), contact, address, email, nic, role);
        String errorMsg = userService.registerUser(user);

        if (errorMsg == null) {
            System.out.println("Registration successful for: " + username);
            request.setAttribute("message", "User Registered Successfully! Please Login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            System.out.println("Registration failed for " + username + ": " + errorMsg);
            request.setAttribute("error", errorMsg);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("Login attempt for: " + username);

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Login with trimmed credentials
        User user = userService.loginUser(username.trim(), password.trim());

        if (user != null) {
            System.out.println("Login success! User: " + user.getUsername() + " Role: " + user.getRole());
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            if (user.getRole() == Role.ADMIN) {
                response.sendRedirect("admin/dashboard.jsp");
            } else if (user.getRole() == Role.STAFF) {
                response.sendRedirect("staff/dashboard.jsp");
            } else if (user.getRole() == Role.CUSTOMER) {
                response.sendRedirect("index.jsp");
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            System.out.println("Login failed for username: " + username);
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void handleViewUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || (currentUser.getRole() != Role.ADMIN && currentUser.getRole() != Role.STAFF)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String query = request.getParameter("query");
        List<User> users;
        if (query != null && !query.trim().isEmpty()) {
            users = userService.searchUsers(query);
            request.setAttribute("searchQuery", query);
        } else {
            users = userService.getAllUsers();
        }
        
        request.setAttribute("users", users);
        if (currentUser.getRole() == Role.ADMIN) {
            request.getRequestDispatcher("/admin/viewUsers.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/staff/viewUsers.jsp").forward(request, response);
        }
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null || (currentUser.getRole() != Role.ADMIN && currentUser.getRole() != Role.STAFF)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String userIdStr = request.getParameter("userId");
        if (userIdStr != null && !userIdStr.isEmpty()) {
            try {
                int userId = Integer.parseInt(userIdStr);
                if (userId == currentUser.getUserId()) {
                    request.setAttribute("error", "You cannot delete your own account.");
                } else {
                    boolean deleted = userService.deleteUser(userId);
                    if (deleted) {
                        request.setAttribute("message", "User deleted successfully.");
                    } else {
                        request.setAttribute("error", "Failed to delete user.");
                    }
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid user ID.");
            }
        }
        
        handleViewUsers(request, response);
    }
}