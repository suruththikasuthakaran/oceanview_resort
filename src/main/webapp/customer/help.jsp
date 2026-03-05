<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="header.jsp" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Help & Guide - Ocean View Resort</title>
            <script src="https://cdn.tailwindcss.com"></script>
        </head>

        <body class="relative min-h-screen">

            <!-- Background -->
            <img src="<%= request.getContextPath() %>/images/help-bg.avif" class="absolute inset-0 w-full object-cover"
                alt="Resort Background">
            <div class="absolute inset-0 bg-black/50 backdrop-blur-sm"></div>

            <div class="relative z-10 container mx-auto px-4 pt-28 pb-20 max-w-7xl">

                <!-- Page Heading -->
                <div class="text-center mb-12">
                    <h1 class="text-3xl md:text-4xl font-bold text-white mb-2">Help & Guide &Report</h1>
                    <p class="text-gray-200 text-sm md:text-base">Everything you need to know about using the system</p>
                </div>

                <!-- FAQ + Ask Form Grid -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">

                    <!-- FAQ Section -->
                    <div class="bg-white/90 backdrop-blur-xl rounded-2xl p-6 md:p-8 shadow-2xl">
                        <% String[] questions={ "How do I add a new reservation?" , "How is the bill calculated?"
                            , "How do I process a payment?" , "How do I view all reservations?"
                            , "How do I manage events and food packages?" , "What room types are available?" }; String[]
                            answers={ "Navigate to the Reservation page from the top menu. Click 'New Reservation' and fill in the guest details including name, contact, room type, and dates. The system will auto-generate a reservation number and calculate the total cost."
                            , "The bill is calculated automatically based on: Number of nights × Room rate per night. Additional costs for event packages and food services can be added separately. The system shows a detailed breakdown on the Reservation Details page."
                            , "Go to the reservation details page and click 'Make Payment'. Select your preferred payment method (Card, Bank Transfer, QR Code, or Cash). Complete the payment process and a receipt will be generated automatically."
                            , "Click on 'All Reservations' from the navigation menu. You can search by reservation number or guest name, filter by room type, and filter by check-in date. Click on any reservation to view full details."
                            , "Browse our event and food packages through the Events and Food Services pages. To book an event, click 'Book Event' and fill in the contact form. Food packages can be added to existing reservations."
                            , "We offer three room types: Standard Room ($120/night) with garden views, Deluxe Ocean View ($220/night) with ocean panorama, and Royal Suite ($450/night) with private pool and butler service."
                            }; %>

                            <div class="space-y-2">
                                <% for(int i=0; i<questions.length; i++) { %>
                                    <details class="border rounded-xl px-4 py-3 bg-white/80 hover:bg-white transition">
                                        <summary class="font-medium cursor-pointer text-gray-800">
                                            <%= questions[i] %>
                                        </summary>
                                        <p class="mt-2 text-gray-600 leading-relaxed">
                                            <%= answers[i] %>
                                        </p>
                                    </details>
                                    <% } %>
                            </div>
                    </div>

                    <!-- Ask a Question Form -->
                    <div class="bg-white/90 backdrop-blur-xl rounded-2xl p-6 md:p-8 shadow-2xl">
                        <% String msg=(String) request.getAttribute("message"); String err=(String)
                            request.getAttribute("error"); if (msg !=null) { %>
                            <div class="bg-green-100 text-green-700 px-4 py-2 rounded-lg mb-4 text-center font-medium">
                                <%= msg %>
                            </div>
                            <% } if (err !=null) { %>
                                <div class="bg-red-100 text-red-700 px-4 py-2 rounded-lg mb-4 text-center font-medium">
                                    <%= err %>
                                </div>
                                <% } %>
                                    <h2 class="text-2xl font-bold mb-4 text-gray-800">Ask a Question & Report your
                                        Problem
                                    </h2>
                                    <form action="<%= request.getContextPath() %>/sendMessageServlet" method="post"
                                        class="space-y-4">
                                        <input type="hidden" name="sourcePage" value="help">
                                        <input type="text" name="name" placeholder="Your Name" required
                                            class="form-input">
                                        <input type="email" name="email" placeholder="Your Email" required
                                            class="form-input">
                                        <input type="text" name="subject" placeholder="Subject" required
                                            class="form-input">
                                        <textarea name="message" placeholder="Your Question" required
                                            class="form-textarea"></textarea>
                                        <button type="submit"
                                            class="w-full bg-gradient-to-r from-blue-500 to-cyan-400 text-white py-3 rounded-xl hover:scale-105 hover:shadow-lg transition duration-300 font-semibold">
                                            Submit
                                        </button>
                                    </form>
                    </div>

                </div>

                <!-- Support Info -->
                <div class="mt-12 bg-gradient-to-r from-blue-500 to-cyan-400 rounded-2xl p-8 text-center text-white">
                    <h3 class="text-xl font-bold mb-2">Still need help?</h3>
                    <p class="text-white/80 text-sm mb-4">Contact our support team for assistance</p>
                    <p class="font-semibold">+94 77 234 5678 · sparkleoceanview@oceanviewgalle.com</p>
                </div>

            </div>

            <%@ include file="footer.jsp" %>

                <!-- Styles -->
                <style>
                    .form-input,
                    .form-textarea {
                        width: 100%;
                        padding: 0.8rem;
                        border-radius: 0.75rem;
                        border: 1.5px solid #d1d5db;
                        background: rgba(255, 255, 255, 0.9);
                        transition: all 0.3s ease;
                    }

                    .form-input:focus,
                    .form-textarea:focus {
                        border-color: #3b82f6;
                        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
                        outline: none;
                        background: white;
                    }

                    .form-textarea {
                        min-height: 120px;
                        resize: vertical;
                    }

                    details summary::-webkit-details-marker {
                        display: none;
                    }
                </style>
        </body>

        </html>