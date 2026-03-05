<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Footer - Ocean View Resort</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Font Awesome Icons -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<footer class="bg-green-600 text-white">
    <div class="container mx-auto px-4 py-10">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-10">

            <!-- Brand -->
            <div>
                 <a href="<%= request.getContextPath() %>/index.jsp" class="flex items-center space-x-2">
                                    <img src="<%= request.getContextPath() %>/images/logo2.png"
                                         alt="Logo"
                                         class="h-12 w-auto">
                                    <span class="text-xl font-bold text-gray-800">
                                        Ocean View Resort
                                    </span>
                                </a>

                <p class="text-green-100 text-sm leading-relaxed mb-4">
                    A luxury beachside retreat in the heart of Galle, Sri Lanka.
                    Experience paradise with world-class amenities and breathtaking ocean views.
                </p>

                <!-- Social Icons -->
                <div class="flex gap-3">
                    <a href="#" class="w-9 h-9 rounded-full bg-white/20 flex items-center justify-center hover:bg-white/30 transition">
                        <i class="fab fa-facebook-f text-white"></i>
                    </a>
                    <a href="#" class="w-9 h-9 rounded-full bg-white/20 flex items-center justify-center hover:bg-white/30 transition">
                        <i class="fab fa-instagram text-white"></i>
                    </a>
                    <a href="#" class="w-9 h-9 rounded-full bg-white/20 flex items-center justify-center hover:bg-white/30 transition">
                        <i class="fab fa-twitter text-white"></i>
                    </a>
                    <a href="#" class="w-9 h-9 rounded-full bg-white/20 flex items-center justify-center hover:bg-white/30 transition">
                        <i class="fab fa-youtube text-white"></i>
                    </a>
                </div>
            </div>

            <!-- Quick Links -->
            <div>
                <h4 class="text-lg font-semibold mb-4">Quick Links</h4>
                <div class="flex flex-col gap-2 text-sm">
                    <a href="<%= request.getContextPath() %>/index.jsp" class="text-green-100 hover:text-white transition">Home</a>
                    <a href="<%= request.getContextPath() %>/customer/rooms.jsp" class="text-green-100 hover:text-white transition">Rooms</a>
                    <a href="<%= request.getContextPath() %>/customer/events.jsp" class="text-green-100 hover:text-white transition">Events</a>
                    <a href="<%= request.getContextPath() %>/customer/food.jsp" class="text-green-100 hover:text-white transition">Food Services</a>
                    <a href="<%= request.getContextPath() %>/customer/gallery.jsp" class="text-green-100 hover:text-white transition">Gallery</a>
                    <a href="<%= request.getContextPath() %>/customer/blog.jsp" class="text-green-100 hover:text-white transition">Blog</a>
                </div>
            </div>

            <!-- Contact -->
            <div>
                <h4 class="text-lg font-semibold mb-4">Contact Us</h4>
                <div class="flex flex-col gap-3 text-green-100 text-sm">
                    <div class="flex items-start gap-2">
                        <span>📍</span>
                        <span>123 Beach Road, Unawatuna, Galle, Sri Lanka</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <span>📞</span>
                        <span>+94 77 234 5678</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <span>✉️</span>
                        <span>sparkleoceanview@oceanviewgalle.com</span>
                    </div>
                </div>
            </div>

            <!-- Newsletter -->
            <div>
                <h4 class="text-lg font-semibold mb-4">Newsletter</h4>
                <p class="text-green-100 text-sm mb-3">
                    Subscribe for exclusive offers and updates.
                </p>

                <div class="flex gap-2">
                    <input type="email"
                           placeholder="Your email"
                           class="flex-1 px-3 py-2 rounded-md bg-white/20 border border-white/30 text-sm text-white placeholder-white/60 focus:outline-none focus:border-white">
                    <button class="px-4 py-2 rounded-md bg-pink-600 text-white text-sm font-medium hover:opacity-90 transition">
                        Join
                    </button>
                </div>
            </div>

        </div>
    </div>

    <!-- Bottom line -->
    <div class="border-t border-white/20">
        <div class="container mx-auto px-6 py-4 text-center text-xs text-green-100">
            &copy; <%= java.time.Year.now() %> Ocean View Resort, Galle. All rights reserved.
        </div>
    </div>
</footer>

</body>
</html>