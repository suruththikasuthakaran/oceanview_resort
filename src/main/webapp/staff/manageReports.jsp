<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List, model.ContactMessage, model.User, model.Role, java.sql.Timestamp" %>
        <% /* Staff/Admin access guard */ User currentUser=(User) session.getAttribute("currentUser"); if
            (currentUser==null || (currentUser.getRole() !=Role.STAFF && currentUser.getRole() !=Role.ADMIN)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } List<ContactMessage> messages =
            (List<ContactMessage>) request.getAttribute("messages");
                String message = (String) request.getAttribute("message");
                String error = (String) request.getAttribute("error");
                String searchQuery = (String) request.getAttribute("searchQuery");
                searchQuery = (searchQuery != null) ? searchQuery : "";
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMM dd, yyyy");
                %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Customer Reports & Messages - Ocean View Resort</title>
                    <script src="https://cdn.tailwindcss.com"></script>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                    <style>
                        .animate-fade-in {
                            animation: fadeIn 0.8s ease forwards;
                        }

                        @keyframes fadeIn {
                            from {
                                opacity: 0;
                                transform: translateY(10px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }
                    </style>
                </head>

                <body class="bg-gray-50">
                    <div class="flex min-h-screen">
                        <% if (currentUser.getRole()==Role.ADMIN) { %>
                            <%@ include file="/admin/sidebar.jsp" %>
                                <% } else { %>
                                    <%@ include file="/staff/sidebar.jsp" %>
                                        <% } %>

                                            <main class="flex-1 p-6 lg:p-10">
                                                <div class="max-w-7xl mx-auto">
                                                    <div
                                                        class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
                                                        <div>
                                                            <h1 class="text-3xl font-bold text-gray-800 tracking-tight">
                                                                Customer Messages</h1>
                                                            <p class="text-gray-500 text-sm mt-1">Manage and view
                                                                reports and feedback</p>
                                                        </div>

                                                        <div class="flex items-center gap-3">
                                                            <form action="<%= request.getContextPath() %>/contact"
                                                                method="get" class="relative group">
                                                                <input type="hidden" name="action" value="search">
                                                                <input type="text" name="query"
                                                                    value="<%= searchQuery %>"
                                                                    placeholder="Search sender, subject..."
                                                                    class="pl-10 pr-4 py-2 bg-white border border-gray-200 rounded-xl text-sm focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all w-64 shadow-sm">
                                                                <i
                                                                    class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-sm group-focus-within:text-blue-500 transition-colors"></i>
                                                                <% if (!searchQuery.isEmpty()) { %>
                                                                    <a href="<%= request.getContextPath() %>/contact?action=manageReports"
                                                                        class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-red-500 transition-colors">
                                                                        <i class="fas fa-times-circle"></i>
                                                                    </a>
                                                                    <% } %>
                                                            </form>

                                                            <div
                                                                class="bg-blue-600 text-white px-4 py-2 rounded-xl text-sm font-bold shadow-lg shadow-blue-200">
                                                                Total: <%= messages !=null ? messages.size() : 0 %>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <% if (message !=null) { %>
                                                        <div
                                                            class="bg-green-100 border border-green-200 text-green-700 px-4 py-3 rounded-xl mb-6 text-center font-medium animate-fade-in">
                                                            <i class="fas fa-check-circle mr-2"></i>
                                                            <%= message %>
                                                        </div>
                                                        <% } %>
                                                            <% if (error !=null) { %>
                                                                <div
                                                                    class="bg-red-100 border border-red-200 text-red-700 px-4 py-3 rounded-xl mb-6 text-center font-medium animate-fade-in">
                                                                    <i class="fas fa-exclamation-circle mr-2"></i>
                                                                    <%= error %>
                                                                </div>
                                                                <% } %>

                                                                    <% if (messages==null || messages.isEmpty()) { %>
                                                                        <div
                                                                            class="bg-white p-12 rounded-2xl shadow-sm text-center border border-gray-100 animate-fade-in">
                                                                            <div class="text-gray-300 text-6xl mb-4">
                                                                                <i class="fas fa-inbox"></i>
                                                                            </div>
                                                                            <p
                                                                                class="text-gray-500 text-lg font-medium">
                                                                                No messages found.</p>
                                                                            <% if (!searchQuery.isEmpty()) { %>
                                                                                <p class="text-gray-400 mt-2 text-sm">
                                                                                    Try adjusting your search criteria.
                                                                                </p>
                                                                                <% } %>
                                                                        </div>
                                                                        <% } else { %>
                                                                            <div
                                                                                class="bg-white shadow-xl rounded-2xl overflow-hidden border border-gray-100 animate-fade-in">
                                                                                <div class="overflow-x-auto">
                                                                                    <table
                                                                                        class="min-w-full divide-y divide-gray-200">
                                                                                        <thead class="bg-gray-50">
                                                                                            <tr>
                                                                                                <th
                                                                                                    class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider w-1/4">
                                                                                                    Sender</th>
                                                                                                <th
                                                                                                    class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider w-1/4">
                                                                                                    Subject</th>
                                                                                                <th
                                                                                                    class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider w-1/3">
                                                                                                    Message</th>
                                                                                                <th
                                                                                                    class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                                                    Date</th>
                                                                                                <th
                                                                                                    class="px-6 py-4 text-center text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                                                    Actions</th>
                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody
                                                                                            class="bg-white divide-y divide-gray-100">
                                                                                            <% for(ContactMessage msg :
                                                                                                messages) { %>
                                                                                                <tr
                                                                                                    class="hover:bg-gray-50/80 transition-colors">
                                                                                                    <td
                                                                                                        class="px-6 py-4">
                                                                                                        <div
                                                                                                            class="flex items-center">
                                                                                                            <div
                                                                                                                class="h-10 w-10 flex-shrink-0 bg-blue-100 text-blue-600 rounded-full flex items-center justify-center font-bold">
                                                                                                                <% String
                                                                                                                    senderName=msg.getName();
                                                                                                                    %>
                                                                                                                    <%= (senderName
                                                                                                                        !=null
                                                                                                                        &&
                                                                                                                        !senderName.isEmpty())
                                                                                                                        ?
                                                                                                                        senderName.substring(0,
                                                                                                                        1).toUpperCase()
                                                                                                                        : "?"
                                                                                                                        %>
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="ml-4">
                                                                                                                <div
                                                                                                                    class="text-sm font-bold text-gray-900">
                                                                                                                    <%= msg.getName()
                                                                                                                        %>
                                                                                                                </div>
                                                                                                                <div
                                                                                                                    class="text-xs text-gray-500">
                                                                                                                    <%= msg.getEmail()
                                                                                                                        %>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        class="px-6 py-4 text-sm text-gray-800 font-semibold">
                                                                                                        <%= msg.getSubject()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        class="px-6 py-4 text-sm text-gray-600">
                                                                                                        <div
                                                                                                            class="max-h-20 overflow-y-auto pr-2 whitespace-pre-wrap">
                                                                                                            <%= msg.getMessage()
                                                                                                                %>
                                                                                                        </div>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        class="px-6 py-4 text-sm text-gray-500 font-mono whitespace-nowrap">
                                                                                                        <%= sdf.format(msg.getCreatedAt())
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        class="px-6 py-4 text-center">
                                                                                                        <form
                                                                                                            action="<%= request.getContextPath() %>/contact"
                                                                                                            method="post"
                                                                                                            onsubmit="return confirm('Delete message?');">
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="action"
                                                                                                                value="delete">
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="messageId"
                                                                                                                value="<%= msg.getMessageId() %>">
                                                                                                            <button
                                                                                                                type="submit"
                                                                                                                class="text-red-500 hover:text-red-700 p-2 rounded-lg hover:bg-red-50 transition"
                                                                                                                title="Delete Message">
                                                                                                                <i
                                                                                                                    class="fas fa-trash-alt"></i>
                                                                                                            </button>
                                                                                                        </form>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <% } %>
                                                                                        </tbody>
                                                                                    </table>
                                                                                </div>
                                                                            </div>
                                                                            <% } %>
                                                </div>
                                            </main>
                    </div>
                </body>

                </html>