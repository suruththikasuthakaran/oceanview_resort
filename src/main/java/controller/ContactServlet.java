package controller;

import dao.ContactMessageDAO;
import model.ContactMessage;
import model.User;
import model.Role;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ContactServlet", urlPatterns = {"/sendMessageServlet", "/contact"})
public class ContactServlet extends HttpServlet {

    private final ContactMessageDAO messageDAO = new ContactMessageDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("manageReports".equalsIgnoreCase(action)) {
                // Staff protection
                HttpSession session = request.getSession();
                User currentUser = (User) session.getAttribute("currentUser");
                if (currentUser == null || (currentUser.getRole() != Role.STAFF && currentUser.getRole() != Role.ADMIN)) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                    return;
                }

                List<ContactMessage> messages = messageDAO.getAllMessages();
                request.setAttribute("messages", messages);
                request.getRequestDispatcher("/staff/manageReports.jsp").forward(request, response);
            } else if ("search".equalsIgnoreCase(action)) {
                // Staff protection
                HttpSession session = request.getSession();
                User currentUser = (User) session.getAttribute("currentUser");
                if (currentUser == null || (currentUser.getRole() != Role.STAFF && currentUser.getRole() != Role.ADMIN)) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                    return;
                }

                String query = request.getParameter("query");
                List<ContactMessage> messages = messageDAO.searchMessages(query);
                request.setAttribute("messages", messages);
                request.setAttribute("searchQuery", query);
                request.getRequestDispatcher("/staff/manageReports.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/customer/contact.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading reports: " + e.getMessage());
            request.getRequestDispatcher("/staff/manageReports.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("messageId"));
            messageDAO.deleteMessage(id);
            response.sendRedirect(request.getContextPath() + "/contact?action=manageReports");
        } else {
            // Default action: Send Message from contact form
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");

            ContactMessage msg = new ContactMessage();
            msg.setName(name);
            msg.setEmail(email);
            msg.setSubject(subject);
            msg.setMessage(message);

            String sourcePage = request.getParameter("sourcePage");
            String targetJsp = "/customer/contact.jsp";
            if ("help".equals(sourcePage)) {
                targetJsp = "/customer/help.jsp";
            }

            if (messageDAO.addMessage(msg)) {
                request.setAttribute("message", "Your message has been sent successfully!");
            } else {
                request.setAttribute("error", "There was an error sending your message. Please try again.");
            }
            request.getRequestDispatcher(targetJsp).forward(request, response);
        }
    }
}
