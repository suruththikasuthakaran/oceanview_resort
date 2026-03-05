<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <jsp:include page="header.jsp" />

    <main class="min-h-screen bg-gray-50 flex items-center justify-center py-12 px-4">
        <div class="max-w-md w-full">

            <!-- Success Popup Card -->
            <div id="successCard"
                class="bg-white rounded-2xl shadow-2xl p-10 text-center transform transition-all duration-500 scale-0 opacity-0 relative overflow-hidden">
                <!-- Animated Checkmark -->
                <div class="flex justify-center mb-6">
                    <div class="w-24 h-24 rounded-full bg-green-100 flex items-center justify-center">
                        <svg class="w-14 h-14 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                    </div>
                </div>

                <h2 class="text-3xl font-bold text-gray-800 mb-2">Payment Successful!</h2>
                <p class="text-gray-500 mb-6">
                    Thank you for your payment. Your reservation is now confirmed.
                    A confirmation will be sent to your registered email.
                </p>

                <% String message=(String) request.getAttribute("message"); if (message !=null) { %>
                    <div class="bg-green-50 border border-green-200 rounded-xl p-4 mb-6">
                        <p class="text-green-700 font-medium">
                            <%= message %>
                        </p>
                    </div>
                    <% } %>

                        <div class="space-y-3 mt-6">
                            <button type="button" onclick="window.print()"
                                class="w-full bg-blue-600 text-white py-3 rounded-xl font-semibold hover:bg-blue-700 transition flex items-center justify-center gap-2">
                                <i class="fa-solid fa-print"></i> Print Receipt
                            </button>
                            <button type="button" onclick="downloadReceipt()"
                                class="w-full bg-indigo-600 text-white py-3 rounded-xl font-semibold hover:bg-indigo-700 transition flex items-center justify-center gap-2">
                                <i class="fa-solid fa-download"></i> Download Receipt
                            </button>
                            <a href="<%= request.getContextPath() %>/reservation?action=form"
                                class="block w-full border border-green-500 text-green-600 py-3 rounded-xl font-semibold hover:bg-green-50 transition">
                                Make Another Reservation
                            </a>
                            <a href="<%= request.getContextPath() %>/index.jsp"
                                class="block w-full border border-gray-200 text-gray-600 py-3 rounded-xl font-semibold hover:bg-gray-50 transition">
                                Back to Home
                            </a>
                        </div>
            </div>

            <!-- Hidden Printable Receipt -->
            <div id="receiptContent" class="hidden print:block absolute top-0 left-0 w-full bg-white p-10 text-left">
                <div class="border-b-2 border-gray-800 pb-4 mb-6 flex justify-between items-center">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-800">Ocean View Resort</h1>
                        <p class="text-gray-500">Galle, Sri Lanka</p>
                    </div>
                    <div class="text-right">
                        <h2 class="text-xl font-bold">PAYMENT RECEIPT</h2>
                        <p class="text-gray-500">Date: <%= new java.util.Date() %>
                        </p>
                    </div>
                </div>

                <div class="mb-8">
                    <h3 class="font-bold text-lg mb-2">Transaction Details</h3>
                    <p><strong>Status:</strong> <span class="text-green-600 font-bold">SUCCESS</span></p>
                    <% if (message !=null) { %>
                        <p><strong>Details:</strong>
                            <%= message %>
                        </p>
                        <% } %>
                </div>

                <div class="text-center mt-12 text-gray-500">
                    <p>Thank you for choosing Ocean View Resort!</p>
                    <p>Contact us: +94 91 234 5678 | info@oceanview.com</p>
                </div>
            </div>

        </div>
    </main>

    <!-- html2pdf for downloading -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <script>
        function downloadReceipt() {
            // Unhide temporarily for PDF generation
            const receipt = document.getElementById('receiptContent');
            receipt.classList.remove('hidden', 'print:block', 'absolute');

            var opt = {
                margin: 1,
                filename: 'OceanView_Receipt.pdf',
                image: { type: 'jpeg', quality: 0.98 },
                html2canvas: { scale: 2 },
                jsPDF: { unit: 'in', format: 'letter', orientation: 'portrait' }
            };

            html2pdf().set(opt).from(receipt).save().then(() => {
                // Restore classes
                receipt.classList.add('hidden', 'print:block', 'absolute');
                // Force hidden to apply immediately
                receipt.style.display = 'none';
                setTimeout(() => { receipt.style.display = ''; }, 100);
            });
        }

        /* Animate the popup card on page load */
        window.addEventListener('load', function () {
            const card = document.getElementById('successCard');
            card.classList.remove('scale-0', 'opacity-0');
            card.classList.add('scale-100', 'opacity-100');
        });
    </script>

    <style>
        #successCard {
            animation: popIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
        }

        @keyframes popIn {
            0% {
                transform: scale(0.5);
                opacity: 0;
            }

            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
    </style>

    <jsp:include page="footer.jsp" />