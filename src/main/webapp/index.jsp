<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="controller.EventPackageController" %>
        <%@ page import="model.EventPackage" %>
            <%@ page import="java.util.List" %>
                <% EventPackageController eventController=EventPackageController.getInstance(); List<EventPackage>
                    homepageEvents = eventController.getAllEventPackages();
                    %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <title>Ocean View Resort - Home</title>

                        <!-- Tailwind CSS -->
                        <script src="https://cdn.tailwindcss.com"></script>

                        <style>
                            @keyframes fadeUp {
                                from {
                                    opacity: 0;
                                    transform: translateY(30px);
                                }

                                to {
                                    opacity: 1;
                                    transform: translateY(0);
                                }
                            }

                            .animate-fade-up {
                                animation: fadeUp 1s ease forwards;
                            }

                            @keyframes fadeIn {
                                from {
                                    opacity: 0;
                                }

                                to {
                                    opacity: 1;
                                }
                            }

                            .animate-fade-in {
                                animation: fadeIn 1.2s ease forwards;
                            }
                        </style>
                    </head>

                    <body class="bg-gray-50 text-gray-800">

                        <%@ include file="customer/header.jsp" %>

                            <!-- ================= HERO SECTION ================= -->
                            <section class="relative h-screen flex items-center justify-center overflow-hidden">
                                <img src="images/beach2.jpg" class="absolute inset-0 w-full h-full object-cover">
                                <div class="absolute inset-0 bg-black bg-opacity-50"></div>

                                <div class="relative z-10 text-center text-white px-6 animate-fade-up">
                                    <p class="uppercase tracking-widest text-sm mb-4">Welcome to Sparkle</p>
                                    <h1 class="text-5xl md:text-7xl font-bold mb-6">Ocean View Resort</h1>
                                    <p class="text-lg md:text-xl mb-8 max-w-2xl mx-auto">
                                        A luxury beachside retreat in beautiful Galle, Sri Lanka
                                    </p>

                                    <div class="flex justify-center gap-4 mt-4">
                                        <a href="customer/reservation.jsp"
                                            class="bg-pink-600 hover:bg-blue-700 px-8 py-3 rounded-lg text-white font-semibold transition">
                                            Book Your Stay
                                        </a>
                                        <a href="customer/rooms.jsp"
                                            class="bg-blue-600 hover:bg-blue-700 px-8 py-3 rounded-lg text-white font-semibold transition">
                                            Explore Rooms
                                        </a>
                                    </div>
                                </div>
                            </section>

                            <!-- ================= STATS SECTION ================= -->
                            <section class="py-16 bg-white">
                                <div class="container mx-auto grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
                                    <div>
                                        <h3 class="text-4xl font-bold text-blue-600">120+</h3>
                                        <p class="text-gray-600 mt-2">Luxury Rooms</p>
                                    </div>
                                    <div>
                                        <h3 class="text-4xl font-bold text-blue-600">5400+</h3>
                                        <p class="text-gray-600 mt-2">Happy Guests</p>
                                    </div>
                                    <div>
                                        <h3 class="text-4xl font-bold text-blue-600">340+</h3>
                                        <p class="text-gray-600 mt-2">Events Hosted</p>
                                    </div>
                                    <div>
                                        <h3 class="text-4xl font-bold text-blue-600">28+</h3>
                                        <p class="text-gray-600 mt-2">Awards Won</p>
                                    </div>
                                </div>
                            </section>

                            <!-- ================= ABOUT SECTION ================= -->
                            <section class="py-20 bg-gray-100 text-center">
                                <div class="max-w-3xl mx-auto px-6">
                                    <h2 class="text-4xl font-bold mb-6">
                                        Experience <span class="text-blue-600">Luxury</span> by the Sea
                                    </h2>
                                    <p class="text-gray-600 leading-relaxed">
                                        Ocean View Resort offers an unparalleled blend of luxury,
                                        comfort, and natural beauty. Enjoy world-class dining,
                                        pristine beaches, a full-service spa, and unforgettable sunsets.
                                    </p>
                                </div>
                            </section>

                            <!-- ================= ROOMS PREVIEW ================= -->
                            <section class="py-20 bg-white">
                                <div class="container mx-auto px-6">
                                    <div class="text-center mb-12">
                                        <h2 class="text-4xl font-bold mb-4">Our Rooms & Suites</h2>
                                        <p class="text-gray-600">Designed for ultimate comfort and relaxation</p>
                                    </div>

                                    <div class="grid md:grid-cols-3 gap-8">
                                        <!-- Standard -->
                                        <div
                                            class="bg-gray-50 rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition">
                                            <img src="images/room-standard.jpg" class="w-full h-56 object-cover">
                                            <div class="p-6">
                                                <h3 class="text-xl font-semibold mb-2">Standard Room</h3>
                                                <p class="text-gray-600 mb-3">Comfortable room with garden views</p>
                                                <p class="font-bold text-blue-600 mb-3">$120 / night</p>
                                                <div class="flex justify-center gap-4 mt-4">
                                                    <a href="customer/rooms.jsp"
                                                        class="bg-white text-yellow-600 px-1 py-3 rounded-md font-medium hover:bg-gray-100 transition">
                                                        Book Room >
                                                    </a>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Deluxe -->
                                        <div
                                            class="bg-gray-50 rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition">
                                            <img src="images/room-deluxe.jpg" class="w-full h-56 object-cover">
                                            <div class="p-6">
                                                <h3 class="text-xl font-semibold mb-2">Deluxe Ocean View</h3>
                                                <p class="text-gray-600 mb-3">Spacious room with stunning ocean views
                                                </p>
                                                <p class="font-bold text-blue-600 mb-3">$220 / night</p>
                                                <div class="flex justify-center gap-4 mt-4">
                                                    <a href="customer/rooms.jsp"
                                                        class="bg-white text-yellow-600 px-1 py-3 rounded-md font-medium hover:bg-gray-100 transition">
                                                        Book Room >
                                                    </a>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Suite -->
                                        <div
                                            class="bg-gray-50 rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition">
                                            <img src="images/room-suite.jpg" class="w-full h-56 object-cover">
                                            <div class="p-6">
                                                <h3 class="text-xl font-semibold mb-2">Royal Suite</h3>
                                                <p class="text-gray-600 mb-3">Luxurious suite with private pool</p>
                                                <p class="font-bold text-blue-600 mb-3">$450 / night</p>
                                                <div class="flex justify-center gap-4 mt-4">
                                                    <a href="customer/rooms.jsp"
                                                        class="bg-white text-yellow-600 px-1 py-3 rounded-md font-medium hover:bg-gray-100 transition">
                                                        Book Room >
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>

                            <!-- ================= EVENTS PACKAGES ================= -->
                            <section class="py-20 bg-gray-50">
                                <div class="container mx-auto px-6">
                                    <div class="text-center mb-12">
                                        <h2 class="text-4xl font-bold mb-4">Unforgettable Events</h2>
                                        <p class="text-gray-600">From beach weddings to corporate retreats, we make
                                            every moment special</p>
                                    </div>

                                    <div class="grid md:grid-cols-3 gap-8">
                                        <% if (homepageEvents !=null && !homepageEvents.isEmpty()) { for (EventPackage
                                            event : homepageEvents) { %>
                                            <div
                                                class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition group">
                                                <div class="h-64 relative overflow-hidden">
                                                    <% if (event.getImage() !=null && !event.getImage().isEmpty()) { %>
                                                        <img src="<%= request.getContextPath() + " /" + event.getImage()
                                                            %>"
                                                        class="w-full h-full object-cover transform
                                                        group-hover:scale-110 transition duration-500">
                                                        <% } else { %>
                                                            <div
                                                                class="w-full h-full bg-purple-50 flex items-center justify-center">
                                                                <i
                                                                    class="fa-solid fa-gift text-purple-200 text-5xl"></i>
                                                            </div>
                                                            <% } %>
                                                                <div
                                                                    class="absolute top-4 right-4 bg-white/90 backdrop-blur px-3 py-1 rounded-full text-purple-600 font-bold text-sm shadow-sm">
                                                                    From $<%= event.getPrice() %>
                                                                </div>
                                                </div>
                                                <div class="p-6">
                                                    <h3
                                                        class="text-xl font-bold mb-2 group-hover:text-purple-600 transition tracking-tight">
                                                        <%= event.getName() %>
                                                    </h3>
                                                    <p class="text-gray-600 text-sm mb-4 line-clamp-3">
                                                        <%= event.getDescription() %>
                                                    </p>
                                                    <a href="customer/eventBooking.jsp?eventId=<%= event.getEventId() %>"
                                                        class="inline-flex items-center gap-2 text-purple-600 font-bold hover:gap-3 transition-all">
                                                        Book Event Package <i class="fa-solid fa-arrow-right-long"></i>
                                                    </a>
                                                </div>
                                            </div>
                                            <% } } else { %>
                                                <div
                                                    class="col-span-full text-center py-10 bg-white rounded-2xl border border-dashed border-gray-300">
                                                    <i
                                                        class="fa-solid fa-calendar-days text-4xl text-gray-300 mb-4 block"></i>
                                                    <p class="text-gray-500">New event packages coming soon. Stay tuned!
                                                    </p>
                                                </div>
                                                <% } %>
                                    </div>
                                </div>
                            </section>


                            <!-- ================= SPECIAL OFFER ================= -->
                            <section class="py-20 bg-yellow-600 text-white text-center">
                                <h2 class="text-4xl font-bold mb-4">Special Offer</h2>
                                <p class="mb-2 text-lg">Early Bird Discount — Book 30 days in advance</p>
                                <p class="text-5xl font-bold mb-6">20% OFF</p>
                                <a href="customer/reservation.jsp"
                                    class="border border-white px-8 py-3 rounded-lg hover:bg-white hover:text-blue-600 transition">
                                    Reserve Now
                                </a>
                            </section>

                            <!-- ================= TESTIMONIALS ================= -->
                            <section class="py-20 bg-gray-100">
                                <div class="container mx-auto px-6 text-center">
                                    <h2 class="text-4xl font-bold mb-12">What Our Guests Say</h2>

                                    <div class="grid md:grid-cols-3 gap-8">
                                        <div class="bg-white p-8 rounded-xl shadow-lg">
                                            <img src="images/sarah.jpeg" class="w-full h-56 object-cover">
                                            <p class="italic text-gray-600 mb-6">
                                                "An absolutely magical experience. The ocean views are breathtaking!"
                                            </p>
                                            <h4 class="font-semibold">Sarah Johnson</h4>
                                            <p class="text-sm text-gray-500">USA</p>
                                        </div>

                                        <div class="bg-white p-8 rounded-xl shadow-lg">
                                            <img src="images/raj.jpg" class="w-full h-56 object-cover">
                                            <p class="italic text-gray-600 mb-6">
                                                "Best resort in Galle! The food was incredible."
                                            </p>
                                            <h4 class="font-semibold">Raj Patel</h4>
                                            <p class="text-sm text-gray-500">India</p>
                                        </div>

                                        <div class="bg-white p-8 rounded-xl shadow-lg">
                                            <img src="images/emma.jpg" class="w-full h-56 object-cover">
                                            <p class="italic text-gray-600 mb-6">
                                                "Perfect honeymoon destination. Sunset dinners were unforgettable."
                                            </p>
                                            <h4 class="font-semibold">Emma Wilson</h4>
                                            <p class="text-sm text-gray-500">UK</p>
                                        </div>
                                    </div>
                                </div>
                            </section>

                            <%@ include file="customer/footer.jsp" %>

                    </body>

                    </html>