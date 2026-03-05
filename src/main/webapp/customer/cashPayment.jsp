<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String reservationId=request.getParameter("reservationId"); String amount=request.getParameter("amount"); %>
        <jsp:include page="header.jsp" />

        <main class="py-12 px-4 min-h-screen bg-gray-50">
            <div class="max-w-md mx-auto">
                <div class="bg-white rounded-2xl shadow-xl p-8 text-center">

                    <div class="text-7xl mb-4">💵</div>
                    <h2 class="text-2xl font-bold text-gray-800 mb-2">Cash Payment</h2>
                    <p class="text-gray-500 text-sm mb-8">Please follow the steps below to complete your cash payment
                    </p>

                    <!-- Amount Due -->
                    <div class="bg-yellow-50 border border-yellow-200 rounded-xl p-5 mb-8">
                        <p class="text-gray-500 text-sm">Amount Due</p>
                        <p class="text-yellow-600 text-4xl font-bold mt-1">$<%= String.format("%.2f",
                                Double.parseDouble(amount !=null ? amount : "0" )) %>
                        </p>
                    </div>

                    <!-- Steps -->
                    <div class="text-left space-y-4 mb-8">
                        <div class="flex items-start gap-4">
                            <div
                                class="flex-shrink-0 w-8 h-8 rounded-full bg-green-100 text-green-600 font-bold flex items-center justify-center text-sm">
                                1</div>
                            <div>
                                <p class="font-semibold text-gray-700">Visit our Front Desk</p>
                                <p class="text-gray-400 text-sm">Go to the Ocean View Resort reception counter.</p>
                            </div>
                        </div>
                        <div class="flex items-start gap-4">
                            <div
                                class="flex-shrink-0 w-8 h-8 rounded-full bg-green-100 text-green-600 font-bold flex items-center justify-center text-sm">
                                2</div>
                            <div>
                                <p class="font-semibold text-gray-700">Show your Reservation Number</p>
                                <p class="text-gray-400 text-sm">Reservation ID: <strong class="text-gray-700">#<%=
                                            reservationId %></strong></p>
                            </div>
                        </div>
                        <div class="flex items-start gap-4">
                            <div
                                class="flex-shrink-0 w-8 h-8 rounded-full bg-green-100 text-green-600 font-bold flex items-center justify-center text-sm">
                                3</div>
                            <div>
                                <p class="font-semibold text-gray-700">Pay the Due Amount</p>
                                <p class="text-gray-400 text-sm">Pay $<%= String.format("%.2f",
                                        Double.parseDouble(amount !=null ? amount : "0" )) %> in cash. You will receive
                                        a receipt.</p>
                            </div>
                        </div>
                    </div>

                    <form action="<%= request.getContextPath() %>/payment" method="post">
                        <input type="hidden" name="reservationId" value="<%= reservationId %>">
                        <input type="hidden" name="amount" value="<%= amount %>">
                        <input type="hidden" name="paymentMethod" value="CASH">
                        <button type="submit"
                            class="w-full bg-gradient-to-r from-yellow-400 to-orange-500 text-white py-4 rounded-xl font-bold text-lg hover:opacity-90 transition">
                            ✅ Confirm Cash Payment
                        </button>
                    </form>

                    <a href="<%= request.getContextPath() %>/customer/paymentMethod.jsp?reservationId=<%= reservationId %>&amount=<%= amount %>"
                        class="block mt-4 text-gray-400 text-sm hover:text-gray-600 transition">← Choose another
                        method</a>
                </div>
            </div>
        </main>

        <jsp:include page="footer.jsp" />