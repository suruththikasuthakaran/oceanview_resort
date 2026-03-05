<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List, model.Reservation, model.User, model.Role, service.ReservationService" %>
        <% /* Staff/Admin access guard */ User currentUser=(User) session.getAttribute("currentUser"); if
            (currentUser==null || (currentUser.getRole() !=Role.STAFF && currentUser.getRole() !=Role.ADMIN)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } List<Reservation> reservationList
            = (List<Reservation>) request.getAttribute("reservationList");
                if (reservationList == null) {
                reservationList = ReservationService.getInstance().getAllReservations();
                }
                String message = (String) request.getAttribute("message");
                String error = (String) request.getAttribute("error");
                String searchQuery = (String) request.getAttribute("searchQuery");
                String searchCheckIn = (String) request.getAttribute("searchCheckIn");
                String searchCheckOut = (String) request.getAttribute("searchCheckOut");
                searchQuery = (searchQuery != null) ? searchQuery : "";
                searchCheckIn = (searchCheckIn != null) ? searchCheckIn : "";
                searchCheckOut = (searchCheckOut != null) ? searchCheckOut : "";
                %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Manage Reservations - Ocean View Resort</title>
                    <script src="https://cdn.tailwindcss.com"></script>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                </head>

                <body class="bg-gray-50">
                    <div class="flex min-h-screen">
                        <%@ include file="/staff/sidebar.jsp" %>

                            <main class="flex-1 p-6 lg:p-10">
                                <div class="max-w-7xl mx-auto">

                                    <div
                                        class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
                                        <div>
                                            <h1 class="text-3xl font-bold text-gray-800 tracking-tight">Manage
                                                Reservations</h1>
                                            <p class="text-gray-500 text-sm mt-1">View and manage all room and event
                                                bookings</p>
                                        </div>
                                        <div
                                            class="bg-blue-600 text-white px-4 py-2 rounded-xl text-sm font-bold shadow-lg shadow-blue-200">
                                            Total: <%= reservationList.size() %>
                                        </div>
                                    </div>

                                    <% if (message !=null) { %>
                                        <div
                                            class="bg-green-100 border border-green-200 text-green-700 px-4 py-3 rounded-xl mb-6 text-center font-medium">
                                            <i class="fas fa-check-circle mr-2"></i>
                                            <%= message %>
                                        </div>
                                        <% } %>
                                            <% if (error !=null) { %>
                                                <div
                                                    class="bg-red-100 border border-red-200 text-red-700 px-4 py-3 rounded-xl mb-6 text-center font-medium">
                                                    <i class="fas fa-exclamation-circle mr-2"></i>
                                                    <%= error %>
                                                </div>
                                                <% } %>

                                                    <!-- Search & Filters -->
                                                    <div
                                                        class="mb-6 bg-white p-6 rounded-xl shadow-sm border border-gray-100">
                                                        <form action="<%= request.getContextPath() %>/reservation"
                                                            method="get"
                                                            class="flex flex-col md:flex-row gap-4 items-end">
                                                            <input type="hidden" name="action" value="search">

                                                            <div class="flex-1 space-y-2">
                                                                <label
                                                                    class="text-xs font-semibold text-gray-500 uppercase">Search
                                                                    Query</label>
                                                                <input type="text" name="query"
                                                                    value="<%= searchQuery %>"
                                                                    placeholder="Name or Res. No..."
                                                                    class="w-full px-4 py-2 rounded-lg border border-gray-200 focus:ring-2 focus:ring-blue-500 outline-none">
                                                            </div>

                                                            <div class="w-full md:w-48 space-y-2">
                                                                <label
                                                                    class="text-xs font-semibold text-gray-500 uppercase">From
                                                                    Date</label>
                                                                <input type="date" name="checkIn"
                                                                    value="<%= searchCheckIn %>"
                                                                    class="w-full px-4 py-2 rounded-lg border border-gray-200 focus:ring-2 focus:ring-blue-500 outline-none">
                                                            </div>

                                                            <div class="w-full md:w-48 space-y-2">
                                                                <label
                                                                    class="text-xs font-semibold text-gray-500 uppercase">To
                                                                    Date</label>
                                                                <input type="date" name="checkOut"
                                                                    value="<%= searchCheckOut %>"
                                                                    class="w-full px-4 py-2 rounded-lg border border-gray-200 focus:ring-2 focus:ring-blue-500 outline-none">
                                                            </div>

                                                            <div class="flex gap-2">
                                                                <button type="submit"
                                                                    class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition font-semibold">
                                                                    <i class="fas fa-search mr-2"></i>Filter
                                                                </button>
                                                                <% if (!searchQuery.isEmpty() ||
                                                                    !searchCheckIn.isEmpty()) { %>
                                                                    <a href="<%= request.getContextPath() %>/reservation?action=viewAll"
                                                                        class="bg-gray-100 text-gray-600 px-4 py-2 rounded-lg hover:bg-gray-200 transition font-medium text-center">
                                                                        Clear
                                                                    </a>
                                                                    <% } %>
                                                            </div>
                                                        </form>
                                                    </div>

                                                    <!-- Reservation Table -->
                                                    <div
                                                        class="bg-white shadow-xl rounded-2xl overflow-hidden border border-gray-100">
                                                        <div class="overflow-x-auto">
                                                            <table class="min-w-full divide-y divide-gray-200">
                                                                <thead class="bg-gray-50">
                                                                    <tr>
                                                                        <th
                                                                            class="px-4 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                            Res. No</th>
                                                                        <th
                                                                            class="px-4 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                            Guest Name</th>
                                                                        <th
                                                                            class="px-4 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                            Room/Event</th>
                                                                        <th
                                                                            class="px-4 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                            Check-In</th>
                                                                        <th
                                                                            class="px-4 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                            Check-Out</th>
                                                                        <th
                                                                            class="px-4 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                            Guests</th>
                                                                        <th
                                                                            class="px-4 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                            Total</th>
                                                                        <th
                                                                            class="px-4 py-4 text-center text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                            Status</th>
                                                                        <th
                                                                            class="px-4 py-4 text-center text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                                            Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody class="bg-white divide-y divide-gray-100">
                                                                    <% if (reservationList==null ||
                                                                        reservationList.isEmpty()) { %>
                                                                        <tr>
                                                                            <td colspan="9"
                                                                                class="px-6 py-12 text-center text-gray-400">
                                                                                <div class="text-5xl mb-3"><i
                                                                                        class="fas fa-calendar-times"></i>
                                                                                </div>
                                                                                No reservations found.
                                                                            </td>
                                                                        </tr>
                                                                        <% } else { for (Reservation res :
                                                                            reservationList) { String
                                                                            statusClass="bg-yellow-100 text-yellow-700"
                                                                            ; String status=res.getStatus(); if
                                                                            ("CONFIRMED".equals(status))
                                                                            statusClass="bg-green-100 text-green-700" ;
                                                                            else if ("CANCELLED".equals(status))
                                                                            statusClass="bg-red-100 text-red-700" ; %>
                                                                            <tr
                                                                                class="hover:bg-gray-50/80 transition-colors">
                                                                                <td
                                                                                    class="px-4 py-3 text-sm font-semibold text-blue-600">
                                                                                    <%= res.getReservationNo() %>
                                                                                </td>
                                                                                <td
                                                                                    class="px-4 py-3 text-sm text-gray-800 font-medium">
                                                                                    <%= res.getFullName() %>
                                                                                </td>
                                                                                <td
                                                                                    class="px-4 py-3 text-sm text-gray-700">
                                                                                    <%= res.getRoomType() %>
                                                                                </td>
                                                                                <td
                                                                                    class="px-4 py-3 text-sm text-gray-700">
                                                                                    <%= res.getCheckIn() %>
                                                                                </td>
                                                                                <td
                                                                                    class="px-4 py-3 text-sm text-gray-700">
                                                                                    <%= res.getCheckOut() %>
                                                                                </td>
                                                                                <td
                                                                                    class="px-4 py-3 text-sm text-gray-700">
                                                                                    <%= res.getGuestCount() %>
                                                                                </td>
                                                                                <td
                                                                                    class="px-4 py-3 text-sm font-semibold text-green-600">
                                                                                    $<%= String.format("%.2f",
                                                                                        res.getTotalAmount()) %>
                                                                                </td>
                                                                                <td class="px-4 py-3 text-center">
                                                                                    <span
                                                                                        class="px-3 py-1 rounded-full text-xs font-semibold <%= statusClass %>">
                                                                                        <%= res.getStatus() %>
                                                                                    </span>
                                                                                </td>
                                                                                <td
                                                                                    class="px-4 py-3 text-center space-x-1">
                                                                                    <a href="<%= request.getContextPath() %>/reservation?action=staffDetails&no=<%= res.getReservationNo() %>"
                                                                                        class="inline-block bg-blue-600 hover:bg-blue-700 text-white py-1 px-3 rounded-lg text-xs font-semibold transition">
                                                                                        Details
                                                                                    </a>
                                                                                    <% if
                                                                                        ("PENDING".equals(res.getStatus()))
                                                                                        { %>
                                                                                        <form
                                                                                            action="<%= request.getContextPath() %>/reservation"
                                                                                            method="post"
                                                                                            class="inline">
                                                                                            <input type="hidden"
                                                                                                name="action"
                                                                                                value="confirm">
                                                                                            <input type="hidden"
                                                                                                name="reservationId"
                                                                                                value="<%= res.getReservationId() %>">
                                                                                            <input type="hidden"
                                                                                                name="amount"
                                                                                                value="<%= res.getTotalAmount() %>">
                                                                                            <button type="submit"
                                                                                                class="bg-green-600 hover:bg-green-700 text-white py-1 px-3 rounded-lg text-xs font-semibold transition">Confirm</button>
                                                                                        </form>
                                                                                        <% } %>
                                                                                            <% if
                                                                                                (!"CANCELLED".equals(res.getStatus()))
                                                                                                { %>
                                                                                                <form
                                                                                                    action="<%= request.getContextPath() %>/reservation"
                                                                                                    method="post"
                                                                                                    class="inline"
                                                                                                    onsubmit="return confirm('Cancel reservation?')">
                                                                                                    <input type="hidden"
                                                                                                        name="action"
                                                                                                        value="cancel">
                                                                                                    <input type="hidden"
                                                                                                        name="reservationId"
                                                                                                        value="<%= res.getReservationId() %>">
                                                                                                    <button
                                                                                                        type="submit"
                                                                                                        class="bg-red-600 hover:bg-red-700 text-white py-1 px-3 rounded-lg text-xs font-semibold transition">Cancel</button>
                                                                                                </form>
                                                                                                <% } %>
                                                                                </td>
                                                                            </tr>
                                                                            <% }} %>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                </div>
                            </main>
                    </div>
                </body>

                </html>