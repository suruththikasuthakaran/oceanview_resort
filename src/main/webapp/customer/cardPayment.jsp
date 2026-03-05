<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String reservationId=request.getParameter("reservationId"); String amount=request.getParameter("amount"); %>
        <jsp:include page="header.jsp" />

        <main class="py-12 px-4 min-h-screen bg-gray-50">
            <div class="max-w-md mx-auto">
                <div class="bg-white rounded-2xl shadow-xl p-8">
                    <h2 class="text-2xl font-bold text-gray-800 mb-2 text-center">Card Payment</h2>
                    <p class="text-gray-500 text-sm text-center mb-6">Enter your card details securely</p>

                    <div class="bg-gradient-to-r from-blue-600 to-indigo-700 rounded-2xl p-6 mb-8 text-white shadow-lg">
                        <p class="text-xs text-blue-200 mb-4">OCEAN VIEW RESORT</p>
                        <p class="text-xl tracking-widest font-mono mb-4">•••• •••• •••• ••••</p>
                        <div class="flex justify-between text-sm">
                            <div>
                                <p class="text-blue-200 text-xs">CARD HOLDER</p>
                                <p class="font-semibold">YOUR NAME</p>
                            </div>
                            <div>
                                <p class="text-blue-200 text-xs">EXPIRES</p>
                                <p class="font-semibold">MM / YY</p>
                            </div>
                        </div>
                    </div>

                    <form action="<%= request.getContextPath() %>/payment" method="post" id="cardForm">
                        <input type="hidden" name="reservationId" value="<%= reservationId %>">
                        <input type="hidden" name="amount" value="<%= amount %>">
                        <input type="hidden" name="paymentMethod" value="CARD">

                        <div class="mb-4">
                            <label class="block text-sm font-semibold text-gray-600 mb-1">Cardholder Name</label>
                            <input type="text" id="cardName" required placeholder="John Smith"
                                class="w-full border border-gray-200 rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-400">
                        </div>

                        <div class="mb-4">
                            <label class="block text-sm font-semibold text-gray-600 mb-1">Card Number</label>
                            <input type="text" id="cardNo" maxlength="19" required placeholder="0000 0000 0000 0000"
                                class="w-full border border-gray-200 rounded-xl px-4 py-3 font-mono focus:outline-none focus:ring-2 focus:ring-blue-400">
                        </div>

                        <div class="grid grid-cols-2 gap-4 mb-6">
                            <div>
                                <label class="block text-sm font-semibold text-gray-600 mb-1">Expiry Date</label>
                                <input type="text" id="expiry" required maxlength="5" placeholder="MM/YY"
                                    class="w-full border border-gray-200 rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-400">
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-gray-600 mb-1">CVV</label>
                                <input type="password" id="cvv" required maxlength="4" placeholder="•••"
                                    class="w-full border border-gray-200 rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-blue-400">
                            </div>
                        </div>

                        <div class="bg-blue-50 rounded-xl p-4 mb-6 text-center">
                            <p class="text-gray-500 text-sm">Total Amount</p>
                            <p class="text-blue-600 text-2xl font-bold">$<%= String.format("%.2f",
                                    Double.parseDouble(amount !=null ? amount : "0" )) %>
                            </p>
                        </div>

                        <button type="submit"
                            class="w-full bg-gradient-to-r from-blue-500 to-indigo-600 text-white py-4 rounded-xl font-bold text-lg hover:opacity-90 transition">
                            💳 Pay Now
                        </button>
                    </form>

                    <a href="<%= request.getContextPath() %>/customer/paymentMethod.jsp?reservationId=<%= reservationId %>&amount=<%= amount %>"
                        class="block mt-4 text-gray-400 text-sm text-center hover:text-gray-600 transition">← Choose
                        another method</a>
                </div>
            </div>
        </main>

        <script>
            /* Auto-format card number with spaces */
            document.getElementById('cardNo').addEventListener('input', function (e) {
                let val = e.target.value.replace(/\D/g, '').substring(0, 16);
                e.target.value = val.replace(/(.{4})/g, '$1 ').trim();
            });
            /* Auto-format expiry */
            document.getElementById('expiry').addEventListener('input', function (e) {
                let val = e.target.value.replace(/\D/g, '').substring(0, 4);
                if (val.length >= 3) val = val.substring(0, 2) + '/' + val.substring(2);
                e.target.value = val;
            });
        </script>

        <jsp:include page="footer.jsp" />