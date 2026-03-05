<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="model.User, model.FoodPackage, java.util.List, java.time.LocalDate" %>
        <% /* Login guard */ User currentUser=(User) session.getAttribute("currentUser"); if (currentUser==null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } List<FoodPackage> foodPackages =
            (List<FoodPackage>) request.getAttribute("foodPackages");
                String preselectedRoom = (String) request.getAttribute("preselectedRoom");
                if (preselectedRoom == null) preselectedRoom = "";
                String preselectedFood = (String) request.getAttribute("preselectedFood");
                if (preselectedFood == null) preselectedFood = "";
                String today = LocalDate.now().toString();
                String error = (String) request.getAttribute("error");

                /* Safe null-checks for auto-fill */
                String prefillName = currentUser.getUsername() != null ? currentUser.getUsername() : "";
                String prefillEmail = currentUser.getEmail() != null ? currentUser.getEmail() : "";
                String prefillAddress = currentUser.getAddress() != null ? currentUser.getAddress() : "";
                String prefillNic = currentUser.getNicOrPassport() != null ? currentUser.getNicOrPassport() : "";
                %>
                <jsp:include page="header.jsp" />

                <section class="relative h-44 flex items-center justify-center overflow-hidden">
                    <img src="<%= request.getContextPath() %>/images/room-deluxe.jpg" alt="Reservation"
                        class="absolute inset-0 w-full h-full object-cover">
                    <div class="absolute inset-0 bg-black/55"></div>
                    <div class="relative text-white text-center">
                        <h1 class="text-4xl font-bold">Room Reservation</h1>
                        <p class="text-gray-200 mt-1">Complete your booking details below</p>
                    </div>
                </section>

                <main class="py-10 px-4 bg-gray-50 min-h-screen">
                    <div class="max-w-5xl mx-auto">

                        <% if (error !=null) { %>
                            <div class="bg-red-100 text-red-700 px-4 py-3 rounded-xl mb-6 text-center font-medium">
                                <%= error %>
                            </div>
                            <% } %>

                                <form action="<%= request.getContextPath() %>/reservation" method="post"
                                    id="reservationForm">
                                    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

                                        <!-- Left: Personal Details -->
                                        <div class="lg:col-span-2 bg-white rounded-2xl shadow-lg p-6">
                                            <h2 class="text-lg font-bold text-gray-700 mb-4 border-b pb-2">Personal
                                                Details</h2>
                                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">

                                                <div>
                                                    <label
                                                        class="block text-xs font-semibold text-gray-500 mb-1 uppercase tracking-wide">Full
                                                        Name <span class="text-red-500">*</span></label>
                                                    <input type="text" name="fullName" required
                                                        value="<%= prefillName %>"
                                                        class="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                                                </div>

                                                <div>
                                                    <label
                                                        class="block text-xs font-semibold text-gray-500 mb-1 uppercase tracking-wide">Email
                                                        <span class="text-red-500">*</span></label>
                                                    <input type="email" name="email" required
                                                        value="<%= prefillEmail %>"
                                                        class="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                                                </div>

                                                <div class="sm:col-span-2">
                                                    <label
                                                        class="block text-xs font-semibold text-gray-500 mb-1 uppercase tracking-wide">Address
                                                        <span class="text-red-500">*</span></label>
                                                    <input type="text" name="address" required
                                                        value="<%= prefillAddress %>"
                                                        class="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                                                </div>

                                                <div>
                                                    <label
                                                        class="block text-xs font-semibold text-gray-500 mb-1 uppercase tracking-wide">NIC
                                                        / Passport <span class="text-red-500">*</span></label>
                                                    <input type="text" name="nic" required value="<%= prefillNic %>"
                                                        class="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                                                </div>

                                                <div>
                                                    <label
                                                        class="block text-xs font-semibold text-gray-500 mb-1 uppercase tracking-wide">Guests
                                                        <span class="text-red-500">*</span></label>
                                                    <input type="number" name="guestCount" min="1" max="10" value="1"
                                                        required id="guestCount"
                                                        class="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                                                </div>
                                            </div>

                                            <!-- Stay Details Row -->
                                            <h2 class="text-lg font-bold text-gray-700 mt-6 mb-4 border-b pb-2">Stay
                                                Details</h2>
                                            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">

                                                <div>
                                                    <label
                                                        class="block text-xs font-semibold text-gray-500 mb-1 uppercase tracking-wide">Room
                                                        Type <span class="text-red-500">*</span></label>
                                                    <select name="roomType" id="roomType" required
                                                        class="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                                                        <option value="">Select Type</option>
                                                        <option value="SINGLE" <%="SINGLE"
                                                            .equalsIgnoreCase(preselectedRoom) ? "selected" : "" %>
                                                            >Single — $80/night</option>
                                                        <option value="DOUBLE" <%="DOUBLE"
                                                            .equalsIgnoreCase(preselectedRoom) ? "selected" : "" %>
                                                            >Double — $120/night</option>
                                                        <option value="DELUXE" <%="DELUXE"
                                                            .equalsIgnoreCase(preselectedRoom) ? "selected" : "" %>
                                                            >Deluxe — $180/night</option>
                                                        <option value="SUITE" <%="SUITE"
                                                            .equalsIgnoreCase(preselectedRoom) ? "selected" : "" %>
                                                            >Suite — $300/night</option>
                                                    </select>
                                                </div>

                                                <div>
                                                    <label
                                                        class="block text-xs font-semibold text-gray-500 mb-1 uppercase tracking-wide">Check-In
                                                        <span class="text-red-500">*</span></label>
                                                    <input type="date" id="checkIn" name="checkIn" min="<%= today %>"
                                                        required
                                                        class="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                                                </div>

                                                <div>
                                                    <label
                                                        class="block text-xs font-semibold text-gray-500 mb-1 uppercase tracking-wide">Check-Out
                                                        <span class="text-red-500">*</span></label>
                                                    <input type="date" id="checkOut" name="checkOut" min="<%= today %>"
                                                        required
                                                        class="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                                                    <p id="dateError" class="text-red-500 text-xs mt-1 hidden">Check-out
                                                        must be after check-in.</p>
                                                </div>
                                            </div>

                                            <!-- Food Package -->
                                            <div class="mt-4">
                                                <label
                                                    class="block text-xs font-semibold text-gray-500 mb-1 uppercase tracking-wide">
                                                    Food Package <span
                                                        class="text-gray-400 font-normal normal-case">(Optional)</span>
                                                </label>
                                                <select name="foodPackage"
                                                    class="w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                                                    <option value="">No food package</option>
                                                    <% if (foodPackages !=null && !foodPackages.isEmpty()) { for
                                                        (FoodPackage fp : foodPackages) { %>
                                                        <option value="<%= fp.getName() %>"
                                                            <%=fp.getName().equals(preselectedFood) ? "selected" : "" %>
                                                            >
                                                            <%= fp.getName() %> — $<%=
                                                                    String.format("%.0f",fp.getPrice()) %>/night
                                                        </option>
                                                        <% }} else { %>
                                                            <option disabled>No packages currently available</option>
                                                            <% } %>
                                                </select>
                                            </div>
                                        </div>

                                        <!-- Right: Reservation Summary Sidebar -->
                                        <div class="lg:col-span-1">
                                            <!-- Auto Reservation No -->
                                            <div
                                                class="bg-gradient-to-br from-green-500 to-emerald-600 text-white rounded-2xl shadow-lg p-5 mb-4">
                                                <p
                                                    class="text-green-100 text-xs font-semibold uppercase tracking-wider">
                                                    Reservation Number</p>
                                                <p class="text-xl font-bold mt-1">Auto-assigned on submit</p>
                                                <p class="text-green-200 text-xs mt-1">e.g. RES-0001</p>
                                            </div>

                                            <!-- Price Summary -->
                                            <div class="bg-white rounded-2xl shadow-lg p-5">
                                                <h3
                                                    class="text-sm font-bold text-gray-600 uppercase tracking-wider mb-3">
                                                    Price Estimate</h3>
                                                <div class="space-y-2 text-sm text-gray-600">
                                                    <div class="flex justify-between">
                                                        <span>Room Rate</span>
                                                        <span id="roomRate">—</span>
                                                    </div>
                                                    <div class="flex justify-between">
                                                        <span>Nights</span>
                                                        <span id="nightsCount">—</span>
                                                    </div>
                                                    <div class="flex justify-between">
                                                        <span>Guests</span>
                                                        <span id="guestDisplay">1</span>
                                                    </div>
                                                    <div
                                                        class="border-t pt-2 mt-2 flex justify-between font-bold text-base text-gray-800">
                                                        <span>Estimated Total</span>
                                                        <span id="totalAmount" class="text-green-600">$0.00</span>
                                                    </div>
                                                </div>

                                                <button type="submit" id="bookBtn"
                                                    class="mt-5 w-full bg-gradient-to-r from-green-500 to-emerald-600 text-white py-3 rounded-xl font-bold hover:opacity-90 hover:shadow-lg transition">
                                                    📋 Book Now
                                                </button>
                                                <a href="<%= request.getContextPath() %>/rooms?action=publicList"
                                                    class="block text-center mt-3 text-gray-400 text-xs hover:text-gray-600 transition">←
                                                    Back to Rooms</a>
                                            </div>
                                        </div>

                                    </div>
                                </form>
                    </div>
                </main>

                <script>
                    const checkIn = document.getElementById('checkIn');
                    const checkOut = document.getElementById('checkOut');
                    const roomType = document.getElementById('roomType');
                    const guestCount = document.getElementById('guestCount');
                    const dateError = document.getElementById('dateError');
                    const prices = { SINGLE: 80, DOUBLE: 120, DELUXE: 180, SUITE: 300 };

                    function updateSummary() {
                        const ci = checkIn.value, co = checkOut.value, rt = roomType.value;
                        const guests = parseInt(guestCount.value) || 1;

                        document.getElementById('guestDisplay').textContent = guests;

                        if (rt) {
                            document.getElementById('roomRate').textContent = '$' + (prices[rt] || 0) + '/night';
                        }

                        if (ci && co && co > ci) {
                            dateError.classList.add('hidden');
                            const nights = Math.max(1, (new Date(co) - new Date(ci)) / 86400000);
                            document.getElementById('nightsCount').textContent = nights + ' night(s)';
                            if (rt) {
                                const total = nights * (prices[rt] || 100) * guests;
                                document.getElementById('totalAmount').textContent = '$' + total.toFixed(2);
                            }
                        } else if (ci && co && co <= ci) {
                            dateError.classList.remove('hidden');
                        }
                    }

                    checkIn.addEventListener('change', () => { checkOut.min = checkIn.value; updateSummary(); });
                    checkOut.addEventListener('change', updateSummary);
                    roomType.addEventListener('change', updateSummary);
                    guestCount.addEventListener('input', updateSummary);

                    document.getElementById('reservationForm').addEventListener('submit', function (e) {
                        if (checkIn.value && checkOut.value && checkOut.value <= checkIn.value) {
                            e.preventDefault();
                            dateError.classList.remove('hidden');
                        }
                    });
                </script>

                <jsp:include page="footer.jsp" />