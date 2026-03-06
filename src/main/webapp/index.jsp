<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="controller.EventPackageController" %>
        <%@ page import="model.EventPackage" %>
            <%@ page import="service.RoomsService" %>
                <%@ page import="model.Rooms" %>
                    <%@ page import="java.util.List" %>
                        <% EventPackageController eventController=EventPackageController.getInstance();
                            List<EventPackage> homepageEvents = eventController.getAllEventPackages();

                            RoomsService roomsService = RoomsService.getInstance();
                            List<Rooms> homepageRooms = roomsService.getAllRooms();
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

                                        /* Custom Scrollbar for horizontal slider */
                                        .hide-scrollbar::-webkit-scrollbar {
                                            display: none;
                                        }

                                        .hide-scrollbar {
                                            -ms-overflow-style: none;
                                            scrollbar-width: none;
                                        }
                                    </style>
                                </head>

                                <body class="bg-gray-50 text-gray-800">

                                    <%@ include file="customer/header.jsp" %>

                                        <!-- ================= HERO SECTION ================= -->
                                        <!-- ... (hero section remains the same) ... -->
                                        <section
                                            class="relative h-screen flex items-center justify-center overflow-hidden">
                                            <img src="images/beach2.jpg"
                                                class="absolute inset-0 w-full h-full object-cover">
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
                                                    <a href="customer/rooms?action=publicList"
                                                        class="bg-blue-600 hover:bg-blue-700 px-8 py-3 rounded-lg text-white font-semibold transition">
                                                        Explore Rooms
                                                    </a>
                                                </div>
                                            </div>
                                        </section>

                                        <!-- ================= STATS SECTION ================= -->
                                        <!-- ... (stats section remains the same) ... -->
                                        <section class="py-16 bg-white">
                                            <div
                                                class="container mx-auto grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
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

                                        <!-- ================= ROOMS PREVIEW (DYNAMIC SLIDER) ================= -->
                                        <section class="py-20 bg-white overflow-hidden">
                                            <div class="container mx-auto px-6">
                                                <div class="flex flex-col md:flex-row justify-between items-end mb-12">
                                                    <div>
                                                        <h2 class="text-4xl font-bold mb-4">Our Rooms & Suites</h2>
                                                        <p class="text-gray-600">Designed for ultimate comfort and
                                                            relaxation. Swipe to explore.</p>
                                                    </div>
                                                    <div class="hidden md:flex gap-3 mt-4 md:mt-0">
                                                        <button onclick="scrollRooms('left')"
                                                            class="w-12 h-12 rounded-full border border-gray-200 flex items-center justify-center hover:bg-blue-600 hover:text-white transition shadow-sm">
                                                            <i class="fas fa-chevron-left"></i>
                                                        </button>
                                                        <button onclick="scrollRooms('right')"
                                                            class="w-12 h-12 rounded-full border border-gray-200 flex items-center justify-center hover:bg-blue-600 hover:text-white transition shadow-sm">
                                                            <i class="fas fa-chevron-right"></i>
                                                        </button>
                                                    </div>
                                                </div>

                                                <div id="room-slider"
                                                    class="flex gap-8 overflow-x-auto hide-scrollbar pb-8 snap-x snap-mandatory scroll-smooth">
                                                    <% if (homepageRooms !=null && !homepageRooms.isEmpty()) { for
                                                        (Rooms room : homepageRooms) { %>
                                                        <div
                                                            class="min-w-[300px] md:min-w-[400px] bg-gray-50 rounded-2xl shadow-lg overflow-hidden hover:shadow-2xl transition-all duration-300 snap-start group flex-shrink-0">
                                                            <div class="h-64 relative overflow-hidden">
                                                                <% if (room.getImage() !=null &&
                                                                    !room.getImage().isEmpty()) { %>
                                                                    <img src="<%= request.getContextPath() %>/<%= room.getImage() %>"
                                                                        class="w-full h-full object-cover transform group-hover:scale-110 transition duration-700"
                                                                        onerror="this.src='<%= request.getContextPath() %>/images/room-standard.jpg'">
                                                                    <% } else { %>
                                                                        <img src="images/room-standard.jpg"
                                                                            class="w-full h-full object-cover">
                                                                        <% } %>
                                                                            <div
                                                                                class="absolute top-4 right-4 bg-white/90 backdrop-blur px-3 py-1 rounded-full text-blue-600 font-bold text-sm shadow-sm">
                                                                                $<%= room.getPrice() %> / night
                                                                            </div>
                                                            </div>
                                                            <div class="p-8">
                                                                <div class="flex justify-between items-start mb-2">
                                                                    <h3
                                                                        class="text-2xl font-bold text-gray-800 group-hover:text-blue-600 transition tracking-tight">
                                                                        <%= room.getRoomType() %>
                                                                    </h3>
                                                                    <span
                                                                        class="bg-blue-50 text-blue-600 text-[10px] uppercase font-bold px-2 py-1 rounded tracking-widest">
                                                                        <%= room.getStatus() %>
                                                                    </span>
                                                                </div>
                                                                <p class="text-gray-600 mb-6 line-clamp-2 h-12 italic">
                                                                    "<%= room.getDescription() %>"
                                                                </p>
                                                                <div class="flex items-center justify-between">
                                                                    <div
                                                                        class="flex items-center gap-4 text-gray-500 text-sm">
                                                                        <span class="flex items-center gap-1"><i
                                                                                class="fas fa-user-friends"></i>
                                                                            <%= room.getCapacity() %>
                                                                        </span>
                                                                        <span class="flex items-center gap-1"><i
                                                                                class="fas fa-bed"></i>
                                                                            <%= room.getBedType() %>
                                                                        </span>
                                                                    </div>
                                                                    <a href="<%= request.getContextPath() %>/reservation"
                                                                        class="bg-blue-600 text-white px-5 py-2.5 rounded-xl font-bold hover:bg-pink-600 transition shadow-lg shadow-blue-200/50">
                                                                        Reserve
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <% } } else { %>
                                                            <div
                                                                class="w-full text-center py-20 bg-gray-50 rounded-2xl border-2 border-dashed border-gray-200">
                                                                <p class="text-gray-400 font-medium">No luxury rooms
                                                                    available at the moment. Check back soon!</p>
                                                            </div>
                                                            <% } %>
                                                </div>
                                            </div>
                                        </section>

                                        <script>
                                            function scrollRooms(direction) {
                                                const slider = document.getElementById('room-slider');
                                                const scrollAmount = direction === 'left' ? -400 : 400;
                                                slider.scrollBy({ left: scrollAmount, behavior: 'smooth' });
                                            }
                                        </script>

                                        <!-- ================= EVENTS PACKAGES ================= -->
                                        <section class="py-20 bg-gray-50">
                                            <div class="container mx-auto px-6">
                                                <div class="text-center mb-12">
                                                    <h2 class="text-4xl font-bold mb-4">Unforgettable Events</h2>
                                                    <p class="text-gray-600">From beach weddings to corporate retreats,
                                                        we make
                                                        every moment special</p>
                                                </div>

                                                <div class="grid md:grid-cols-3 gap-8">
                                                    <% if (homepageEvents !=null && !homepageEvents.isEmpty()) { for
                                                        (EventPackage event : homepageEvents) { %>
                                                        <div
                                                            class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition group">
                                                            <div class="h-64 relative overflow-hidden">
                                                                <% if (event.getImage() !=null &&
                                                                    !event.getImage().isEmpty()) { %>
                                                                    <img src="<%= request.getContextPath() %>/<%= event.getImage() %>"
                                                                        alt="<%= event.getName() %>"
                                                                        class="w-full h-full object-cover transform group-hover:scale-110 transition duration-500"
                                                                        onerror="this.src='<%= request.getContextPath() %>/images/event-fallback.jpg'">
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
                                                                <a href="<%= request.getContextPath() %>/customer/eventBooking.jsp?eventId=<%= event.getEventId() %>"
                                                                    class="inline-flex items-center gap-2 text-purple-600 font-bold hover:gap-3 transition-all">
                                                                    Book Event Package <i
                                                                        class="fa-solid fa-arrow-right-long"></i>
                                                                </a>
                                                            </div>
                                                        </div>
                                                        <% } } else { %>
                                                            <div
                                                                class="col-span-full text-center py-10 bg-white rounded-2xl border border-dashed border-gray-300">
                                                                <i
                                                                    class="fa-solid fa-calendar-days text-4xl text-gray-300 mb-4 block"></i>
                                                                <p class="text-gray-500">New event packages coming soon.
                                                                    Stay tuned!
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
                                                            "An absolutely magical experience. The ocean views are
                                                            breathtaking!"
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
                                                            "Perfect honeymoon destination. Sunset dinners were
                                                            unforgettable."
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