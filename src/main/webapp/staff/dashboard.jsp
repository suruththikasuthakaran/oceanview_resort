<%@ page session="true" %>
    <%@ page import="model.*, service.*, java.sql.*, util.DBConnection, java.util.*" %>

        <% /* Authentication Check */ User currentUser=(User) session.getAttribute("currentUser"); if (currentUser==null
            || (currentUser.getRole() !=Role.STAFF && currentUser.getRole() !=Role.ADMIN)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } %>

            <% /* Statistics Initialization */ RoomsService roomsService=RoomsService.getInstance(); int
                totalRooms=roomsService.getTotalRoomsCount(); int availableRooms=roomsService.getAvailableRoomsCount();
                int checkInsToday=0; int checkOutsToday=0; int messageCount=0; try (Connection
                conn=DBConnection.getConnection()) { if (conn !=null) { try (Statement st=conn.createStatement()) {
                String q1="SELECT COUNT(*) FROM reservations WHERE DATE(check_in) = CURDATE()" ; try (ResultSet
                rs=st.executeQuery(q1)) { if (rs.next()) checkInsToday=rs.getInt(1); } String
                q2="SELECT COUNT(*) FROM reservations WHERE DATE(check_out) = CURDATE()" ; try (ResultSet
                rs=st.executeQuery(q2)) { if (rs.next()) checkOutsToday=rs.getInt(1); } String
                q3="SELECT COUNT(*) FROM contact_messages" ; try (ResultSet rs=st.executeQuery(q3)) { if (rs.next())
                messageCount=rs.getInt(1); } } } } catch (Exception e) { e.printStackTrace(); } %>


                <% /* Payment Data Initialization */ List<model.Payment> recentPayments = new ArrayList<>();
                        try (Connection conn = DBConnection.getConnection()) {
                        if (conn != null) {
                        String q5 = "SELECT p.*, r.full_name FROM payments p "
                        + "LEFT JOIN reservations r ON p.reservation_id = r.reservation_id "
                        + "ORDER BY p.payment_date DESC LIMIT 4";
                        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(q5)) {
                        while (rs.next()) {
                        model.Payment p = new model.Payment();
                        p.setAmount(rs.getDouble("amount"));
                        try {
                        p.setStatus(model.PaymentStatus.valueOf(rs.getString("status")));
                        } catch (Exception ex) {
                        p.setStatus(model.PaymentStatus.PENDING);
                        }
                        model.Reservation res = new model.Reservation();
                        String fn = rs.getString("full_name");
                        res.setFullName(fn != null ? fn : "Walk-in/Event");
                        p.setReservation(res);
                        recentPayments.add(p);
                        }
                        }
                        }
                        } catch (Exception e) {
                        e.printStackTrace();
                        }
                        %>

                        <!DOCTYPE html>
                        <html lang="en">

                        <head>
                            <meta charset="UTF-8">
                            <title>Staff Dashboard - Ocean View Resort</title>
                            <!-- Tailwind CSS -->
                            <script src="https://cdn.tailwindcss.com"></script>
                            <!-- Font Awesome -->
                            <link rel="stylesheet"
                                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                            <style>
                                @keyframes fadeIn {
                                    0% {
                                        opacity: 0;
                                        transform: translateY(-20px);
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

                        <body class="bg-gray-100 flex">

                            <%@ include file="/staff/sidebar.jsp" %>

                                <div class="flex-1 p-6">
                                    <h1 class="text-3xl font-bold mb-6 animate-fade-in text-gray-800 tracking-tight">
                                        Welcome, <%= currentUser.getUsername() %>!
                                    </h1>

                                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                                        <div
                                            class="bg-white shadow-sm border border-gray-100 rounded-xl p-6 transform hover:-translate-y-1 hover:shadow-lg transition duration-300 animate-fade-in">
                                            <div class="flex items-center justify-between">
                                                <div>
                                                    <p
                                                        class="text-sm font-medium text-gray-500 uppercase tracking-wider">
                                                        Available Rooms</p>
                                                    <p class="text-3xl font-bold text-gray-900 mt-2">
                                                        <%= availableRooms %> <span
                                                                class="text-sm font-normal text-gray-400">/
                                                                <%= totalRooms %>
                                                            </span>
                                                    </p>
                                                </div>
                                                <div
                                                    class="w-14 h-14 bg-green-50 rounded-full flex items-center justify-center">
                                                    <i class="fas fa-bed text-2xl text-green-500"></i>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="bg-white shadow-sm border border-gray-100 rounded-xl p-6 transform hover:-translate-y-1 hover:shadow-lg transition duration-300 animate-fade-in"
                                            style="animation-delay: 0.2s;">
                                            <div class="flex items-center justify-between">
                                                <div>
                                                    <p
                                                        class="text-sm font-medium text-gray-500 uppercase tracking-wider">
                                                        Check-ins Today</p>
                                                    <p class="text-3xl font-bold text-gray-900 mt-2">
                                                        <%= checkInsToday %>
                                                    </p>
                                                </div>
                                                <div
                                                    class="w-14 h-14 bg-blue-50 rounded-full flex items-center justify-center">
                                                    <i class="fas fa-sign-in-alt text-2xl text-blue-500"></i>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="bg-white shadow-sm border border-gray-100 rounded-xl p-6 transform hover:-translate-y-1 hover:shadow-lg transition duration-300 animate-fade-in"
                                            style="animation-delay: 0.4s;">
                                            <div class="flex items-center justify-between">
                                                <div>
                                                    <p
                                                        class="text-sm font-medium text-gray-500 uppercase tracking-wider">
                                                        Check-outs Today</p>
                                                    <p class="text-3xl font-bold text-gray-900 mt-2">
                                                        <%= checkOutsToday %>
                                                    </p>
                                                </div>
                                                <div
                                                    class="w-14 h-14 bg-orange-50 rounded-full flex items-center justify-center">
                                                    <i class="fas fa-sign-out-alt text-2xl text-orange-500"></i>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="bg-white shadow-sm border border-gray-100 rounded-xl p-6 transform hover:-translate-y-1 hover:shadow-lg transition duration-300 animate-fade-in"
                                            style="animation-delay: 0.6s;">
                                            <div class="flex items-center justify-between">
                                                <div>
                                                    <p
                                                        class="text-sm font-medium text-gray-500 uppercase tracking-wider">
                                                        New Messages</p>
                                                    <p class="text-3xl font-bold text-gray-900 mt-2">
                                                        <%= messageCount %>
                                                    </p>
                                                </div>
                                                <div
                                                    class="w-14 h-14 bg-pink-50 rounded-full flex items-center justify-center">
                                                    <i class="fas fa-comment-dots text-2xl text-pink-500"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Recent Payments Section -->
                                    <div class="mt-10">

                                        <!-- Recent Payments (Card Format) -->
                                        <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100 animate-fade-in"
                                            style="animation-delay: 0.8s;">
                                            <h3 class="text-lg font-bold text-gray-800 mb-4 flex items-center">
                                                <i class="fas fa-receipt text-green-500 mr-2"></i> Recent Payments
                                            </h3>
                                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                                <% for (model.Payment p : recentPayments) { String
                                                    pClass=(p.getStatus()==model.PaymentStatus.SUCCESS)
                                                    ? "text-green-600 font-bold" : "text-yellow-600 font-bold" ; %>
                                                    <div
                                                        class="border border-gray-100 bg-gray-50 rounded-lg p-4 hover:shadow-md transition">
                                                        <div class="flex justify-between items-start mb-2">
                                                            <span class="text-xs text-gray-400 font-medium">Payment
                                                                ID</span>
                                                            <span
                                                                class="text-[10px] bg-blue-100 text-blue-600 px-2 py-0.5 rounded font-bold uppercase">
                                                                <%= p.getStatus() %>
                                                            </span>
                                                        </div>
                                                        <p class="text-sm font-bold text-gray-800 truncate">
                                                            <%= p.getReservation().getFullName() %>
                                                        </p>
                                                        <p class="text-xl font-bold mt-1 text-gray-900">$<%=
                                                                String.format("%.2f", p.getAmount()) %>
                                                        </p>
                                                    </div>
                                                    <% } %>
                                                        <% if (recentPayments.isEmpty()) { %>
                                                            <p class="col-span-2 text-center text-gray-400 py-10">No
                                                                recent payments found.</p>
                                                            <% } %>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mt-10">
                                        <h2 class="text-2xl font-bold text-gray-800 mb-6 animate-fade-in">Quick
                                            Actions
                                        </h2>
                                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

                                            <a href="<%= request.getContextPath() %>/reservation?action=viewAll"
                                                class="group bg-white border border-gray-100 p-6 rounded-xl shadow-sm hover:shadow-md hover:border-blue-500 transition-all flex items-center animate-fade-in">
                                                <div
                                                    class="w-12 h-12 bg-blue-50 rounded-lg flex items-center justify-center mr-4 group-hover:bg-blue-500 transition-colors">
                                                    <i
                                                        class="fas fa-calendar-check text-blue-500 group-hover:text-white transition-colors"></i>
                                                </div>
                                                <div>
                                                    <h3 class="font-bold text-gray-800">Reservations</h3>
                                                    <p class="text-sm text-gray-500">Manage bookings</p>
                                                </div>
                                            </a>

                                            <a href="<%= request.getContextPath() %>/rooms?action=list"
                                                class="group bg-white border border-gray-100 p-6 rounded-xl shadow-sm hover:shadow-md hover:border-blue-500 transition-all flex items-center animate-fade-in"
                                                style="animation-delay: 0.2s;">
                                                <div
                                                    class="w-12 h-12 bg-green-50 rounded-lg flex items-center justify-center mr-4 group-hover:bg-green-500 transition-colors">
                                                    <i
                                                        class="fas fa-bed text-green-500 group-hover:text-white transition-colors"></i>
                                                </div>
                                                <div>
                                                    <h3 class="font-bold text-gray-800">Rooms</h3>
                                                    <p class="text-sm text-gray-500">Manage rooms</p>
                                                </div>
                                            </a>

                                            <a href="<%= request.getContextPath() %>/contact?action=manageReports"
                                                class="group bg-white border border-gray-100 p-6 rounded-xl shadow-sm hover:shadow-md hover:border-blue-500 transition-all flex items-center animate-fade-in"
                                                style="animation-delay: 0.3s;">
                                                <div
                                                    class="w-12 h-12 bg-orange-50 rounded-lg flex items-center justify-center mr-4 group-hover:bg-orange-500 transition-colors">
                                                    <i
                                                        class="fas fa-comments text-orange-500 group-hover:text-white transition-colors"></i>
                                                </div>
                                                <div>
                                                    <h3 class="font-bold text-gray-800">Reports</h3>
                                                    <p class="text-sm text-gray-500">Customer feedback</p>
                                                </div>
                                            </a>

                                            <a href="<%= request.getContextPath() %>/events?action=list"
                                                class="group bg-white border border-gray-100 p-6 rounded-xl shadow-sm hover:shadow-md hover:border-blue-500 transition-all flex items-center animate-fade-in"
                                                style="animation-delay: 0.4s;">
                                                <div
                                                    class="w-12 h-12 bg-purple-50 rounded-lg flex items-center justify-center mr-4 group-hover:bg-purple-500 transition-colors">
                                                    <i
                                                        class="fas fa-gift text-purple-600 group-hover:text-white transition-colors"></i>
                                                </div>
                                                <div>
                                                    <h3 class="font-bold text-gray-800">Events</h3>
                                                    <p class="text-sm text-gray-500">Manage event packages</p>
                                                </div>
                                            </a>

                                            <a href="<%= request.getContextPath() %>/foods?action=list"
                                                class="group bg-white border border-gray-100 p-6 rounded-xl shadow-sm hover:shadow-md hover:border-blue-500 transition-all flex items-center animate-fade-in">
                                                <div
                                                    class="w-12 h-12 bg-red-50 rounded-lg flex items-center justify-center mr-4 group-hover:bg-red-500 transition-colors">
                                                    <i
                                                        class="fas fa-utensils text-red-500 group-hover:text-white transition-colors"></i>
                                                </div>
                                                <div>
                                                    <h3 class="font-bold text-gray-800">Food</h3>
                                                    <p class="text-sm text-gray-500">Manage food menus</p>
                                                </div>
                                            </a>

                                            <a href="<%= request.getContextPath() %>/payment?action=history"
                                                class="group bg-white border border-gray-100 p-6 rounded-xl shadow-sm hover:shadow-md hover:border-blue-500 transition-all flex items-center animate-fade-in"
                                                style="animation-delay: 0.2s;">
                                                <div
                                                    class="w-12 h-12 bg-teal-50 rounded-lg flex items-center justify-center mr-4 group-hover:bg-teal-500 transition-colors">
                                                    <i
                                                        class="fas fa-file-invoice-dollar text-teal-600 group-hover:text-white transition-colors"></i>
                                                </div>
                                                <div>
                                                    <h3 class="font-bold text-gray-800">Payments</h3>
                                                    <p class="text-sm text-gray-500">View payment history</p>
                                                </div>
                                            </a>
                                            <a href="<%= request.getContextPath() %>/userAuth?action=viewUsers"
                                                class="group bg-white border border-gray-100 p-6 rounded-xl shadow-sm hover:shadow-md hover:border-blue-500 transition-all flex items-center animate-fade-in"
                                                style="animation-delay: 0.3s;">
                                                <div
                                                    class="w-12 h-12 bg-pink-50 rounded-lg flex items-center justify-center mr-4 group-hover:bg-pink-500 transition-colors">
                                                    <i
                                                        class="fas fa-users text-pink-600 group-hover:text-white transition-colors"></i>
                                                </div>
                                                <div>
                                                    <h3 class="font-bold text-gray-800">Users</h3>
                                                    <p class="text-sm text-gray-500">View registered users</p>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                        </body>

                        </html>