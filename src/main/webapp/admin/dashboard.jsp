<%@ page session="true" %>
    <%@ page import="model.User, model.Role" %>
        <%@ page import="service.RoomsService" %>
            <%@ page import="java.sql.*, util.DBConnection" %>
                <% /* Check if user is logged in and has admin role */ User currentUser=(User)
                    session.getAttribute("currentUser"); if (currentUser==null || currentUser.getRole() !=Role.ADMIN) {
                    response.sendRedirect("../login.jsp"); return; } RoomsService
                    roomsService=RoomsService.getInstance(); int totalRooms=roomsService.getTotalRoomsCount(); int
                    availableRooms=roomsService.getAvailableRoomsCount(); int checkInsToday=0; int checkOutsToday=0; /*
                    Quick inline query for dashboard stats */ try (Connection conn=DBConnection.getConnection()) { if
                    (conn !=null) { String
                    checkInSql="SELECT COUNT(*) FROM reservations WHERE DATE(check_in_date) = CURDATE()" ; try
                    (Statement st=conn.createStatement(); ResultSet rs=st.executeQuery(checkInSql)) { if (rs.next()) {
                    checkInsToday=rs.getInt(1); } } catch (Exception e) { /* Ignore if table doesn't exist */ } String
                    checkOutSql="SELECT COUNT(*) FROM reservations WHERE DATE(check_out_date) = CURDATE()" ; try
                    (Statement st=conn.createStatement(); ResultSet rs=st.executeQuery(checkOutSql)) { if (rs.next()) {
                    checkOutsToday=rs.getInt(1); } } catch (Exception e) { /* Ignore if table doesn't exist */ } } }
                    catch (Exception e) { e.printStackTrace(); } %>

                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <title>Admin Dashboard - Ocean View Resort</title>
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

                        <%@ include file="/admin/sidebar.jsp" %>

                            <div class="flex-1 p-6">
                                <h1 class="text-3xl font-bold mb-6 animate-fade-in text-gray-800 tracking-tight">
                                    Welcome Master Admiral, <%= currentUser.getUsername() %>!
                                </h1>

                                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                                    <div
                                        class="bg-white shadow-sm border border-gray-100 rounded-xl p-6 transform hover:-translate-y-1 hover:shadow-lg transition duration-300 animate-fade-in">
                                        <div class="flex items-center justify-between">
                                            <div>
                                                <p class="text-sm font-medium text-gray-500 uppercase tracking-wider">
                                                    Available Rooms</p>
                                                <p class="text-3xl font-bold text-gray-900 mt-2">
                                                    <%= availableRooms %> <span
                                                            class="text-sm font-normal text-gray-400">/ <%= totalRooms
                                                                %></span>
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
                                                <p class="text-sm font-medium text-gray-500 uppercase tracking-wider">
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
                                                <p class="text-sm font-medium text-gray-500 uppercase tracking-wider">
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
                                </div>

                                <div class="mt-10">
                                    <h2 class="text-2xl font-bold text-gray-800 mb-6 animate-fade-in">Admin Controls
                                    </h2>
                                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">

                                        <a href="viewUsers.jsp"
                                            class="group bg-white border border-gray-100 p-6 rounded-xl shadow-sm hover:shadow-md hover:border-blue-500 transition-all flex items-center animate-fade-in">
                                            <div
                                                class="w-12 h-12 bg-yellow-50 rounded-lg flex items-center justify-center mr-4 group-hover:bg-yellow-500 transition-colors">
                                                <i
                                                    class="fas fa-user-shield text-yellow-600 group-hover:text-white transition-colors"></i>
                                            </div>
                                            <div>
                                                <h3 class="font-bold text-gray-800">User Mgmt</h3>
                                                <p class="text-sm text-gray-500">Manage all staff & admins</p>
                                            </div>
                                        </a>

                                        <a href="<%= request.getContextPath() %>/rooms?action=list"
                                            class="group bg-white border border-gray-100 p-6 rounded-xl shadow-sm hover:shadow-md hover:border-blue-500 transition-all flex items-center animate-fade-in"
                                            style="animation-delay: 0.1s;">
                                            <div
                                                class="w-12 h-12 bg-blue-50 rounded-lg flex items-center justify-center mr-4 group-hover:bg-blue-500 transition-colors">
                                                <i
                                                    class="fas fa-door-open text-blue-500 group-hover:text-white transition-colors"></i>
                                            </div>
                                            <div>
                                                <h3 class="font-bold text-gray-800">Room Mgmt</h3>
                                                <p class="text-sm text-gray-500">Fully manage inventory</p>
                                            </div>
                                        </a>

                                        <a href="<%= request.getContextPath() %>/staff/manageReservation.jsp"
                                            class="group bg-white border border-gray-100 p-6 rounded-xl shadow-sm hover:shadow-md hover:border-blue-500 transition-all flex items-center animate-fade-in"
                                            style="animation-delay: 0.2s;">
                                            <div
                                                class="w-12 h-12 bg-green-50 rounded-lg flex items-center justify-center mr-4 group-hover:bg-green-500 transition-colors">
                                                <i
                                                    class="fas fa-book text-green-500 group-hover:text-white transition-colors"></i>
                                            </div>
                                            <div>
                                                <h3 class="font-bold text-gray-800">Reservations</h3>
                                                <p class="text-sm text-gray-500">Oversee all bookings</p>
                                            </div>
                                        </a>

                                        <a href="<%= request.getContextPath() %>/staff/paymentHistory.jsp"
                                            class="group bg-white border border-gray-100 p-6 rounded-xl shadow-sm hover:shadow-md hover:border-blue-500 transition-all flex items-center animate-fade-in"
                                            style="animation-delay: 0.3s;">
                                            <div
                                                class="w-12 h-12 bg-teal-50 rounded-lg flex items-center justify-center mr-4 group-hover:bg-teal-500 transition-colors">
                                                <i
                                                    class="fas fa-coins text-teal-600 group-hover:text-white transition-colors"></i>
                                            </div>
                                            <div>
                                                <h3 class="font-bold text-gray-800">Finances</h3>
                                                <p class="text-sm text-gray-500">Financial records</p>
                                            </div>
                                        </a>

                                    </div>
                                </div>
                            </div>
                    </body>

                    </html>