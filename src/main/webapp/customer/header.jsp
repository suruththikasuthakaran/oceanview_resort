<!-- customer/header.jsp -->
<%@ page import="jakarta.servlet.http.HttpSession" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <% String username=(String) session.getAttribute("username"); %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Ocean View Resort</title>
                <!-- Tailwind CSS -->
                <script src="https://cdn.tailwindcss.com"></script>
            </head>

            <body class="bg-gray-50">

                <!-- Navbar -->
                <header class="bg-green-600 text-white shadow-md fixed w-full z-50">
                    <div class="container mx-auto flex justify-between items-center p-4">
                        <!-- Logo + Site Name -->
                        <!-- Logo -->
                        <a href="<%= request.getContextPath() %>/index.jsp" class="flex items-center space-x-2">
                            <img src="<%= request.getContextPath() %>/images/logo2.png" alt="Logo" class="h-12 w-auto">
                            <span class="text-xl font-bold text-gray-800">
                                Ocean View Resort
                            </span>
                        </a>

                        <!-- Navigation links -->
                        <nav class="hidden md:flex space-x-4">
                            <a href="<%= request.getContextPath() %>/index.jsp"
                                class="hover:text-gray-200 transition">Home</a>
                            <a href="<%= request.getContextPath() %>/rooms?action=publicList"
                                class="hover:text-gray-200 transition">Rooms</a>
                            <a href="<%= request.getContextPath() %>/events?action=customerList"
                                class="hover:text-gray-200 transition">Events</a>
                            <a href="<%= request.getContextPath() %>/foods?action=customerList"
                                class="hover:text-gray-200 transition">Food Services</a>
                            <a href="<%= request.getContextPath() %>/customer/gallery.jsp"
                                class="hover:text-gray-200 transition">Gallery</a>
                            <a href="<%= request.getContextPath() %>/customer/blog.jsp"
                                class="hover:text-gray-200 transition">Blog</a>
                            <a href="<%= request.getContextPath() %>/customer/contact.jsp"
                                class="hover:text-gray-200 transition">Contact</a>
                            <a href="<%= request.getContextPath() %>/customer/help.jsp"
                                class="hover:text-gray-200 transition">Help & Report</a>
                        </nav>

                        <div class="flex items-center space-x-6">
                            <!-- New Reservation Button (Visible to all, Servlet handles login check) -->
                            <a href="<%= request.getContextPath() %>/reservation"
                                class="bg-yellow-500 hover:bg-yellow-600 text-white px-5 py-2 rounded-xl font-bold transition shadow-lg shadow-yellow-200/50 flex items-center gap-2">
                                <i class="fa-solid fa-calendar-plus"></i> New Reservation
                            </a>

                            <div class="flex items-center gap-3">
                                <c:choose>
                                    <c:when test="${not empty username}">
                                        <!-- Logged in user -->
                                        <div
                                            class="flex items-center gap-2 bg-green-700/50 px-3 py-1.5 rounded-lg border border-green-400/30">
                                            <i class="fa-solid fa-circle-user text-green-200"></i>
                                            <span class="font-bold text-sm">${username}</span>
                                        </div>
                                        <a href="<%= request.getContextPath() %>/logout.jsp"
                                            class="text-sm font-semibold hover:text-red-200 transition">Logout</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="<%= request.getContextPath() %>/login.jsp"
                                            class="bg-white/10 hover:bg-white/20 text-white px-5 py-2 rounded-xl font-bold border border-white/30 transition backdrop-blur-sm">
                                            Login
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Mobile menu button -->
                        <button id="mobile-menu-button" class="md:hidden text-white">
                            ☰
                        </button>
                    </div>

                    <!-- Mobile Nav -->
                    <div id="mobile-menu" class="hidden md:hidden bg-blue-700">
                        <a href="index.jsp" class="block px-4 py-2 hover:bg-blue-600">Home</a>
                        <a href="<%= request.getContextPath() %>/rooms?action=publicList"
                            class="block px-4 py-2 hover:bg-blue-600">Rooms</a>
                        <a href="<%= request.getContextPath() %>/events?action=customerList"
                            class="block px-4 py-2 hover:bg-blue-600">Events</a>
                        <a href="<%= request.getContextPath() %>/foods?action=customerList"
                            class="block px-4 py-2 hover:bg-blue-600">Food Services</a>
                        <a href="gallery.jsp" class="block px-4 py-2 hover:bg-blue-600">Gallery</a>
                        <a href="blog.jsp" class="block px-4 py-2 hover:bg-blue-600">Blog</a>
                        <a href="contact.jsp" class="block px-4 py-2 hover:bg-blue-600">Contact</a>
                        <c:choose>
                            <c:when test="${not empty username}">
                                <a href="reservation.jsp" class="block px-4 py-2 hover:bg-blue-600">New
                                    Reservation</a>
                                <a href="logout.jsp" class="block px-4 py-2 hover:bg-blue-600">Logout</a>
                            </c:when>
                            <c:otherwise>
                                <a href="register.jsp" class="block px-4 py-2 hover:bg-blue-600">Register</a>
                                <a href="login.jsp" class="block px-4 py-2 hover:bg-blue-600">Login</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </header>

                <script>
                    const btn = document.getElementById("mobile-menu-button");
                    const menu = document.getElementById("mobile-menu");
                    btn.addEventListener("click", () => {
                        menu.classList.toggle("hidden");
                    });
                </script>

            </body>

            </html>