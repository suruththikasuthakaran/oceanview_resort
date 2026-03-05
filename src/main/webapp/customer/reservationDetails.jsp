<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="model.Reservation" %>
        <% Reservation r=(Reservation) request.getAttribute("reservation"); if (r==null) {
            response.sendRedirect(request.getContextPath() + "/reservation?action=form" ); return; } %>
            <jsp:include page="header.jsp" />

            <section class="relative h-48 flex items-center justify-center overflow-hidden">
                <img src="<%= request.getContextPath() %>/images/room-deluxe.jpg" alt="Reservation Details"
                    class="absolute inset-0 w-full h-full object-cover">
                <div class="absolute inset-0 bg-black/55"></div>
                <div class="relative text-white text-center">
                    <h1 class="text-4xl font-bold">Reservation Details</h1>
                    <p class="mt-1 text-gray-200">Review your booking before confirming</p>
                </div>
            </section>

            <main class="py-12 px-4">
                <div class="max-w-2xl mx-auto">
                    <div class="bg-white rounded-2xl shadow-xl overflow-hidden">

                        <!-- Header Banner -->
                        <div
                            class="bg-gradient-to-r from-green-500 to-emerald-600 px-8 py-5 flex justify-between items-center">
                            <div>
                                <p class="text-green-100 text-sm">Reservation No.</p>
                                <h2 class="text-white text-2xl font-bold">
                                    <%= r.getReservationNo() %>
                                </h2>
                            </div>
                            <% String status=r.getStatus() !=null ? r.getStatus() : "PENDING" ; String
                                sClass="bg-yellow-100 text-yellow-700" ; if ("CONFIRMED".equals(status))
                                sClass="bg-blue-100 text-blue-700" ; else if ("CANCELLED".equals(status))
                                sClass="bg-red-100 text-red-700" ; %>
                                <span class="px-4 py-2 rounded-full text-sm font-semibold <%= sClass %>">
                                    <%= status %>
                                </span>
                        </div>

                        <!-- Details Grid -->
                        <div class="p-8">
                            <div class="grid grid-cols-2 gap-y-5 gap-x-8 text-sm">
                                <div>
                                    <p class="text-gray-400 font-medium">Full Name</p>
                                    <p class="text-gray-800 font-semibold mt-1">
                                        <%= r.getFullName() %>
                                    </p>
                                </div>
                                <div>
                                    <p class="text-gray-400 font-medium">Email</p>
                                    <p class="text-gray-800 font-semibold mt-1">
                                        <%= r.getEmail() %>
                                    </p>
                                </div>
                                <div>
                                    <p class="text-gray-400 font-medium">Address</p>
                                    <p class="text-gray-800 font-semibold mt-1">
                                        <%= r.getAddress() %>
                                    </p>
                                </div>
                                <div>
                                    <p class="text-gray-400 font-medium">NIC / Passport</p>
                                    <p class="text-gray-800 font-semibold mt-1">
                                        <%= r.getNic() %>
                                    </p>
                                </div>
                                <div>
                                    <p class="text-gray-400 font-medium">Room Type</p>
                                    <p class="text-gray-800 font-semibold mt-1">
                                        <%= r.getRoomType() %>
                                    </p>
                                </div>
                                <div>
                                    <p class="text-gray-400 font-medium">Guests</p>
                                    <p class="text-gray-800 font-semibold mt-1">
                                        <%= r.getGuestCount() %> person(s)
                                    </p>
                                </div>
                                <div>
                                    <p class="text-gray-400 font-medium">Check-In</p>
                                    <p class="text-gray-800 font-semibold mt-1">
                                        <%= r.getCheckIn() %>
                                    </p>
                                </div>
                                <div>
                                    <p class="text-gray-400 font-medium">Check-Out</p>
                                    <p class="text-gray-800 font-semibold mt-1">
                                        <%= r.getCheckOut() %>
                                    </p>
                                </div>
                                <div>
                                    <p class="text-gray-400 font-medium">Food Package</p>
                                    <p class="text-gray-800 font-semibold mt-1">
                                        <%= (r.getFoodPackage() !=null && !r.getFoodPackage().isEmpty()) ?
                                            r.getFoodPackage() : "None" %>
                                    </p>
                                </div>
                                <div>
                                    <p class="text-gray-400 font-medium">Total Amount</p>
                                    <p class="text-green-600 text-xl font-bold mt-1">$<%= String.format("%.2f",
                                            r.getTotalAmount()) %>
                                    </p>
                                </div>
                            </div>

                            <% if ("PENDING".equals(r.getStatus())) { %>
                                <!-- Confirm & Pay Button -->
                                <form action="<%= request.getContextPath() %>/reservation" method="post" class="mt-8">
                                    <input type="hidden" name="action" value="confirm">
                                    <input type="hidden" name="reservationId" value="<%= r.getReservationId() %>">
                                    <input type="hidden" name="amount" value="<%= r.getTotalAmount() %>">
                                    <button type="submit"
                                        class="w-full bg-gradient-to-r from-green-500 to-emerald-600 text-white py-4 rounded-xl font-bold text-lg hover:opacity-90 transition duration-300">
                                        ✅ Confirm &amp; Proceed to Payment
                                    </button>
                                </form>
                                <% } else if ("CONFIRMED".equals(r.getStatus())) { %>
                                    <div class="mt-8 text-center">
                                        <a href="<%= request.getContextPath() %>/customer/paymentMethod.jsp?reservationId=<%= r.getReservationId() %>&amount=<%= r.getTotalAmount() %>"
                                            class="inline-block bg-blue-600 text-white px-8 py-3 rounded-xl font-bold hover:bg-blue-700 transition">
                                            💳 Proceed to Payment
                                        </a>
                                    </div>
                                    <% } %>

                                        <div class="mt-4 text-center">
                                            <a href="<%= request.getContextPath() %>/reservation?action=form"
                                                class="text-gray-400 text-sm hover:text-gray-600 transition">← Make
                                                Another Reservation</a>
                                        </div>
                        </div>
                    </div>
                </div>
            </main>

            <jsp:include page="footer.jsp" />