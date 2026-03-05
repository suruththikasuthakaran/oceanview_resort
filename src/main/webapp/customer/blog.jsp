<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Blog - Ocean View Resort</title>

    <!-- Tailwind CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">

<%@ include file="header.jsp" %>

<section class="pt-20 pb-20">
    <div class="container mx-auto px-4">

        <!-- Title -->
        <div class="text-center mb-12">
            <h1 class="text-3xl md:text-4xl font-bold text-gray-800 mb-2">
                Our Blog
            </h1>
            <p class="text-gray-500">
                Stories, tips, and updates from Ocean View Resort
            </p>
        </div>

        <!-- Blog Grid -->
        <div class="grid md:grid-cols-3 gap-8 max-w-6xl mx-auto">

            <!-- Blog 1 -->
            <div class="bg-white rounded-xl overflow-hidden shadow-md hover:shadow-xl transition duration-300 group">
                <div class="relative h-48 overflow-hidden">
                    <img src="<%= contextPath %>/images/hero-resort.jpg"
                         class="w-full h-full object-cover group-hover:scale-105 transition duration-500"
                         alt="Galle Travel">
                    <span class="absolute top-3 left-3 bg-green-600 text-white px-2 py-1 rounded text-xs">
                        Travel Tips
                    </span>
                </div>
                <div class="p-6">
                    <p class="text-xs text-gray-400 mb-2">Feb 15, 2024</p>
                    <h3 class="text-lg font-semibold text-gray-800 mb-2">
                        Top 10 Things to Do in Galle, Sri Lanka
                    </h3>
                    <p class="text-gray-500 text-sm mb-4">
                        Discover the best attractions, from Galle Fort to whale watching.
                    </p>
                    <a href="#" class="text-green-600 text-sm font-medium hover:underline">
                        Read More →
                    </a>
                </div>
            </div>

            <!-- Blog 2 -->
            <div class="bg-white rounded-xl overflow-hidden shadow-md hover:shadow-xl transition duration-300 group">
                <div class="relative h-48 overflow-hidden">
                    <img src="<%= contextPath %>/images/gallery-spa.jpg"
                         class="w-full h-full object-cover group-hover:scale-105 transition duration-500"
                         alt="Spa">
                    <span class="absolute top-3 left-3 bg-green-600 text-white px-2 py-1 rounded text-xs">
                        Wellness
                    </span>
                </div>
                <div class="p-6">
                    <p class="text-xs text-gray-400 mb-2">Feb 10, 2024</p>
                    <h3 class="text-lg font-semibold text-gray-800 mb-2">
                        The Art of Relaxation: Our Spa Experience
                    </h3>
                    <p class="text-gray-500 text-sm mb-4">
                        Explore our world-class spa offerings and Ayurvedic treatments.
                    </p>
                    <a href="#" class="text-green-600 text-sm font-medium hover:underline">
                        Read More →
                    </a>
                </div>
            </div>

            <!-- Blog 3 -->
            <div class="bg-white rounded-xl overflow-hidden shadow-md hover:shadow-xl transition duration-300 group">
                <div class="relative h-48 overflow-hidden">
                    <img src="<%= contextPath %>/images/room-suite.jpg"
                         class="w-full h-full object-cover group-hover:scale-105 transition duration-500"
                         alt="Dining">
                    <span class="absolute top-3 left-3 bg-green-600 text-white px-2 py-1 rounded text-xs">
                        Dining
                    </span>
                </div>
                <div class="p-6">
                    <p class="text-xs text-gray-400 mb-2">Feb 5, 2024</p>
                    <h3 class="text-lg font-semibold text-gray-800 mb-2">
                        Sunset Dining: A Culinary Journey
                    </h3>
                    <p class="text-gray-500 text-sm mb-4">
                        Enjoy the finest local and international cuisines by the beach.
                    </p>
                    <a href="#" class="text-green-600 text-sm font-medium hover:underline">
                        Read More →
                    </a>
                </div>
            </div>

        </div>

    </div>
</section>

<%@ include file="footer.jsp" %>

</body>
</html>