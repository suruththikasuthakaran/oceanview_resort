<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String reservationId=request.getParameter("reservationId"); String amount=request.getParameter("amount"); if
        (reservationId==null || amount==null) { response.sendRedirect(request.getContextPath()
        + "/reservation?action=form" ); return; } %>
        <jsp:include page="header.jsp" />

        <section class="relative h-44 flex items-center justify-center overflow-hidden">
            <img src="<%= request.getContextPath() %>/images/room-deluxe.jpg" alt="Payment"
                class="absolute inset-0 w-full h-full object-cover">
            <div class="absolute inset-0 bg-black/55"></div>
            <div class="relative text-white text-center">
                <h1 class="text-4xl font-bold">Select Payment Method</h1>
                <p class="text-gray-200 mt-1">Choose how you'd like to pay</p>
            </div>
        </section>

        <main class="py-12 px-4">
            <div class="max-w-3xl mx-auto">

                <div class="text-center mb-8">
                    <p class="text-gray-500 text-sm">Reservation #<%= reservationId %>
                    </p>
                    <p class="text-3xl font-bold text-green-600 mt-1">Total: $<%= String.format("%.2f",
                            Double.parseDouble(amount)) %>
                    </p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

                    <!-- QR Payment -->
                    <a href="<%= request.getContextPath() %>/customer/qrPayment.jsp?reservationId=<%= reservationId %>&amount=<%= amount %>"
                        class="group bg-white rounded-2xl shadow-lg p-8 text-center border-2 border-transparent hover:border-green-400 hover:shadow-xl transition-all duration-300 cursor-pointer">
                        <div class="text-6xl mb-4">📱</div>
                        <h3 class="text-xl font-bold text-gray-800 group-hover:text-green-600 transition">QR Pay</h3>
                        <p class="text-gray-400 text-sm mt-2">Scan to pay instantly with your mobile</p>
                    </a>

                    <!-- Card Payment -->
                    <a href="<%= request.getContextPath() %>/customer/cardPayment.jsp?reservationId=<%= reservationId %>&amount=<%= amount %>"
                        class="group bg-white rounded-2xl shadow-lg p-8 text-center border-2 border-transparent hover:border-blue-400 hover:shadow-xl transition-all duration-300 cursor-pointer">
                        <div class="text-6xl mb-4">💳</div>
                        <h3 class="text-xl font-bold text-gray-800 group-hover:text-blue-600 transition">Card Payment
                        </h3>
                        <p class="text-gray-400 text-sm mt-2">Pay securely with credit or debit card</p>
                    </a>

                    <!-- Cash Payment -->
                    <a href="<%= request.getContextPath() %>/customer/cashPayment.jsp?reservationId=<%= reservationId %>&amount=<%= amount %>"
                        class="group bg-white rounded-2xl shadow-lg p-8 text-center border-2 border-transparent hover:border-yellow-400 hover:shadow-xl transition-all duration-300 cursor-pointer">
                        <div class="text-6xl mb-4">💵</div>
                        <h3 class="text-xl font-bold text-gray-800 group-hover:text-yellow-600 transition">Cash Payment
                        </h3>
                        <p class="text-gray-400 text-sm mt-2">Pay at the front desk on arrival</p>
                    </a>

                </div>
            </div>
        </main>

        <jsp:include page="footer.jsp" />