<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String reservationId=request.getParameter("reservationId"); String amount=request.getParameter("amount"); if
        (reservationId==null || amount==null) { response.sendRedirect(request.getContextPath()
        + "/reservation?action=form" ); return; } /* Build QR data: encodes reservation info for payment */ String
        qrData=java.net.URLEncoder.encode( "OceanViewResort|ReservationID:" + reservationId + "|Amount:$" +
        amount, "UTF-8" ); String qrUrl="https://api.qrserver.com/v1/create-qr-code/?size=220x220&data=" + qrData; %>
        <jsp:include page="header.jsp" />

        <main class="py-12 px-4 min-h-screen bg-gray-50">
            <div class="max-w-md mx-auto">
                <div class="bg-white rounded-2xl shadow-xl p-8 text-center">

                    <div class="flex justify-center mb-3">
                        <div class="w-10 h-10 rounded-full bg-green-100 flex items-center justify-center">
                            <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M12 4v1m0 14v1m8-8h-1M5 12H4m15.07-6.07l-.71.71M5.64 18.36l-.71.71M18.36 18.36l-.71-.71M5.64 5.64l-.71-.71" />
                            </svg>
                        </div>
                    </div>

                    <h2 class="text-2xl font-bold text-gray-800 mb-1">QR Code Payment</h2>
                    <p class="text-gray-500 text-sm mb-6">Scan this QR code with your banking app to complete the
                        payment</p>

                    <!-- Real Scannable QR Code from API -->
                    <div class="flex justify-center mb-5">
                        <div class="p-3 border-4 border-green-400 rounded-2xl bg-white shadow-md inline-block">
                            <img src="<%= qrUrl %>" alt="Payment QR Code" width="220" height="220" class="rounded-lg"
                                onerror="this.src='https://api.qrserver.com/v1/create-qr-code/?size=220x220&data=OceanViewResort-Payment'">
                        </div>
                    </div>

                    <div class="bg-green-50 border border-green-200 rounded-xl px-5 py-4 mb-6">
                        <p class="text-gray-500 text-xs uppercase tracking-wider font-semibold">Reservation ID</p>
                        <p class="text-gray-800 font-bold text-lg">#<%= reservationId %>
                        </p>
                        <p class="text-gray-500 text-xs uppercase tracking-wider font-semibold mt-2">Total Amount</p>
                        <p class="text-green-600 font-bold text-3xl">$<%= String.format("%.2f",
                                Double.parseDouble(amount)) %>
                        </p>
                    </div>

                    <p class="text-gray-400 text-xs mb-6">
                        Scan with <strong>Google Pay, PayPay, any UPI app</strong> or your bank's app.<br>
                        After payment, click the button below to confirm.
                    </p>

                    <form action="<%= request.getContextPath() %>/payment" method="post">
                        <input type="hidden" name="reservationId" value="<%= reservationId %>">
                        <input type="hidden" name="amount" value="<%= amount %>">
                        <input type="hidden" name="paymentMethod" value="QR">
                        <button type="submit"
                            class="w-full bg-gradient-to-r from-green-500 to-emerald-600 text-white py-4 rounded-xl font-bold text-lg hover:opacity-90 transition shadow-lg">
                            ✅ I've Completed the Payment
                        </button>
                    </form>

                    <a href="<%= request.getContextPath() %>/customer/paymentMethod.jsp?reservationId=<%= reservationId %>&amount=<%= amount %>"
                        class="block mt-4 text-gray-400 text-sm hover:text-gray-600 transition">← Choose another
                        method</a>
                </div>
            </div>
        </main>

        <jsp:include page="footer.jsp" />