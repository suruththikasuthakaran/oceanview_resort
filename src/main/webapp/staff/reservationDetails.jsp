<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="model.Reservation" %>
        <% Reservation r=(Reservation) request.getAttribute("reservation"); if (r==null) {
            response.sendRedirect(request.getContextPath() + "/reservation?action=form" ); return; } %>
            <jsp:include page="/staff/sidebar.jsp" />
            <main class="flex-1 p-6 bg-gray-50 min-h-screen">
                <div class="container mx-auto">
                    <h1 class="text-3xl font-bold mb-6 text-gray-800">Reservation Details</h1>
                    <div class="bg-white rounded-xl shadow-lg p-6">
                        <table class="min-w-full divide-y divide-gray-200">
                            <tr>
                                <th class="px-4 py-2 text-left">Reservation No</th>
                                <td class="px-4 py-2">${r.reservationNo}</td>
                            </tr>
                            <tr>
                                <th class="px-4 py-2 text-left">Guest Name</th>
                                <td class="px-4 py-2">${r.fullName}</td>
                            </tr>
                            <tr>
                                <th class="px-4 py-2 text-left">Room Type</th>
                                <td class="px-4 py-2">${r.roomType}</td>
                            </tr>
                            <tr>
                                <th class="px-4 py-2 text-left">Check‑In</th>
                                <td class="px-4 py-2">${r.checkIn}</td>
                            </tr>
                            <tr>
                                <th class="px-4 py-2 text-left">Check‑Out</th>
                                <td class="px-4 py-2">${r.checkOut}</td>
                            </tr>
                            <tr>
                                <th class="px-4 py-2 text-left">Guests</th>
                                <td class="px-4 py-2">${r.guestCount}</td>
                            </tr>
                            <tr>
                                <th class="px-4 py-2 text-left">Food Package</th>
                                <td class="px-4 py-2">${r.foodPackage != null && !r.foodPackage.isEmpty() ?
                                    r.foodPackage : "None"}</td>
                            </tr>
                            <tr>
                                <th class="px-4 py-2 text-left">Total Amount</th>
                                <td class="px-4 py-2 text-green-600 font-bold">$${String.format("%.2f", r.totalAmount)}
                                </td>
                            </tr>
                            <tr>
                                <th class="px-4 py-2 text-left">Status</th>
                                <% String status=r.getStatus() !=null ? r.getStatus() : "PENDING" ; String
                                    sClass="bg-yellow-100 text-yellow-700" ; if ("CONFIRMED".equals(status))
                                    sClass="bg-green-100 text-green-700" ; else if ("CANCELLED".equals(status))
                                    sClass="bg-red-100 text-red-700" ; %>
                                    <td class="px-4 py-2">
                                        <span class="px-3 py-1 rounded-full text-xs font-semibold <%= sClass %>">
                                            <%= status %>
                                        </span>
                                    </td>
                            </tr>
                        </table>
                        <c:if test="${" PENDING".equals(r.status)}">
                            <form action="${pageContext.request.contextPath}/reservation" method="post" class="mt-4">
                                <input type="hidden" name="action" value="confirm" />
                                <input type="hidden" name="reservationId" value="${r.reservationId}" />
                                <input type="hidden" name="amount" value="${r.totalAmount}" />
                                <button type="submit"
                                    class="bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded-lg">Confirm
                                    &amp; Proceed to Payment</button>
                            </form>
                        </c:if>
                        <c:if test="${" CONFIRMED".equals(r.status)}">
                            <a href="${pageContext.request.contextPath}/customer/paymentMethod.jsp?reservationId=${r.reservationId}&amp;amount=${r.totalAmount}"
                                class="inline-block bg-blue-600 text-white py-2 px-4 rounded-lg mt-4">Proceed to
                                Payment</a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/staff/manageReservation.jsp"
                            class="inline-block text-gray-600 mt-4">← Back to Reservations</a>
                    </div>
                </div>
            </main>