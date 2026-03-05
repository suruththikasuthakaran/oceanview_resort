<%@ page session="true" %>
    <%@ page import="java.util.List, model.User, model.Role, service.UserService" %>
        <% User currentUser=(User) session.getAttribute("currentUser"); if (currentUser==null || (currentUser.getRole()
            !=Role.ADMIN && currentUser.getRole() !=Role.STAFF)) { response.sendRedirect(request.getContextPath()
            + "/login.jsp" ); return; } List<User> users = (List<User>) request.getAttribute("users");
                if (users == null) {
                UserService userService = new UserService();
                users = userService.getAllUsers();
                }
                %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <title>View Users - Ocean View Resort</title>
                    <script src="https://cdn.tailwindcss.com"></script>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                    <style>
                        @keyframes fadeIn {
                            0% {
                                opacity: 0;
                                transform: translateY(-10px);
                            }

                            100% {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        .animate-fade-in {
                            animation: fadeIn 0.8s ease forwards;
                        }
                    </style>
                </head>

                <body class="bg-gray-50 flex min-h-screen">

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
                                                            Registered Users</h1>
                                                        <p class="text-gray-500 text-sm mt-1">Manage and view all system
                                                            users</p>
                                                    </div>

                                                    <div class="flex items-center gap-3">
                                                        <form action="<%= request.getContextPath() %>/userAuth"
                                                            method="get" class="relative group">
                                                            <input type="hidden" name="action" value="viewUsers">
                                                            <input type="text" name="query"
                                                                value="<%= request.getAttribute(" searchQuery") !=null ?
                                                                request.getAttribute("searchQuery") : "" %>"
                                                            placeholder="Search username, email..."
                                                            class="pl-10 pr-4 py-2 bg-white border border-gray-200
                                                            rounded-xl text-sm focus:ring-2 focus:ring-blue-500
                                                            focus:border-transparent outline-none transition-all w-64
                                                            shadow-sm">
                                                            <i
                                                                class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-sm group-focus-within:text-blue-500 transition-colors"></i>
                                                            <% if (request.getAttribute("searchQuery") !=null) { %>
                                                                <a href="<%= request.getContextPath() %>/userAuth?action=viewUsers"
                                                                    class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-red-500 transition-colors">
                                                                    <i class="fas fa-times-circle"></i>
                                                                </a>
                                                                <% } %>
                                                        </form>

                                                        <div
                                                            class="bg-blue-600 text-white px-4 py-2 rounded-xl text-sm font-bold shadow-lg shadow-blue-200">
                                                            Total: <%= users.size() %>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div
                                                    class="bg-white shadow-xl rounded-2xl overflow-hidden border border-gray-100 animate-fade-in">
                                                    <div class="overflow-x-auto">
                                                        <table class="min-w-full divide-y divide-gray-200">
                                                            <thead class="bg-gray-50">
                                                                <tr>
                                                                    <th
                                                                        class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                        User</th>
                                                                    <th
                                                                        class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                        Contact</th>
                                                                    <th
                                                                        class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                        Email</th>
                                                                    <th
                                                                        class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                        NIC/Passport</th>
                                                                    <th
                                                                        class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                        Role</th>
                                                                    <th
                                                                        class="px-6 py-4 text-center text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                        Actions</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody class="bg-white divide-y divide-gray-100">
                                                                <% for(User u : users) { String
                                                                    roleColor="bg-blue-100 text-blue-700" ; if
                                                                    (u.getRole()==Role.ADMIN)
                                                                    roleColor="bg-purple-100 text-purple-700" ; else if
                                                                    (u.getRole()==Role.STAFF)
                                                                    roleColor="bg-green-100 text-green-700" ; %>
                                                                    <tr class="hover:bg-gray-50/80 transition-colors">
                                                                        <td class="px-6 py-4">
                                                                            <div class="flex items-center">
                                                                                <div
                                                                                    class="h-10 w-10 flex-shrink-0 bg-gray-200 rounded-full flex items-center justify-center text-gray-500 font-bold">
                                                                                    <%= u.getUsername().substring(0,
                                                                                        1).toUpperCase() %>
                                                                                </div>
                                                                                <div class="ml-4">
                                                                                    <div
                                                                                        class="text-sm font-bold text-gray-900">
                                                                                        <%= u.getUsername() %>
                                                                                    </div>
                                                                                    <div class="text-xs text-gray-400">
                                                                                        ID: #<%= u.getUserId() %>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                        <td
                                                                            class="px-6 py-4 text-sm text-gray-600 font-medium">
                                                                            <%= u.getContactNo() !=null ?
                                                                                u.getContactNo() : "N/A" %>
                                                                        </td>
                                                                        <td class="px-6 py-4 text-sm text-gray-600">
                                                                            <%= u.getEmail() %>
                                                                        </td>
                                                                        <td
                                                                            class="px-6 py-4 text-sm text-gray-600 font-mono">
                                                                            <%= u.getNicOrPassport() !=null ?
                                                                                u.getNicOrPassport() : "N/A" %>
                                                                        </td>
                                                                        <td class="px-6 py-4">
                                                                            <span
                                                                                class="px-3 py-1 rounded-full text-xs font-bold uppercase <%= roleColor %>">
                                                                                <%= u.getRole() %>
                                                                            </span>
                                                                        </td>
                                                                        <td class="px-6 py-4 text-center">
                                                                            <% if(u.getUserId()
                                                                                !=currentUser.getUserId()) { %>
                                                                                <form
                                                                                    action="<%= request.getContextPath() %>/userAuth"
                                                                                    method="post"
                                                                                    onsubmit="return confirm('Are you sure you want to delete user: <%= u.getUsername() %>?');">
                                                                                    <input type="hidden" name="action"
                                                                                        value="deleteUser">
                                                                                    <input type="hidden" name="userId"
                                                                                        value="<%= u.getUserId() %>">
                                                                                    <button type="submit"
                                                                                        class="text-red-500 hover:text-red-700 p-2 rounded-lg hover:bg-red-50 transition"
                                                                                        title="Delete User">
                                                                                        <i class="fas fa-trash-alt"></i>
                                                                                    </button>
                                                                                </form>
                                                                                <% } else { %>
                                                                                    <span class="text-gray-300"
                                                                                        title="Cannot delete self"><i
                                                                                            class="fas fa-user-slash text-sm"></i></span>
                                                                                    <% } %>
                                                                        </td>
                                                                    </tr>
                                                                    <% } %>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </main>
                </body>

                </html>