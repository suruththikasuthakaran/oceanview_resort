<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Login - Ocean View Resort</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="relative min-h-screen flex items-center justify-center">

        <!-- Background Image -->
        <img src="<%= request.getContextPath() %>/images/login-bg.jpg"
            class="absolute inset-0 w-full h-full object-cover" alt="Resort Background">

        <!-- Dark Overlay -->
        <div class="absolute inset-0 bg-black/50 backdrop-blur-sm"></div>

        <!-- Login Card -->
        <div class="relative z-10 w-full max-w-md animate-fade-up">
            <div class="bg-white/90 backdrop-blur-xl shadow-2xl rounded-2xl p-10 border border-white/30">

                <h2 class="text-3xl font-bold mb-6 text-center text-blue-600 tracking-wide">
                    Ocean View Resort
                </h2>
                <p class="text-center text-gray-500 mb-6 text-sm">
                    Users Login Portal
                </p>

                <% String error=(String) request.getAttribute("error"); String message=(String)
                    request.getAttribute("message"); %>

                    <% if(message !=null) { %>
                        <div
                            class="bg-green-100 text-green-700 px-4 py-2 rounded-lg mb-4 text-center font-medium shadow">
                            <%= message %>
                        </div>
                        <% } %>

                            <% if(error !=null) { %>
                                <div
                                    class="bg-red-100 text-red-700 px-4 py-2 rounded-lg mb-4 text-center font-medium shadow">
                                    <%= error %>
                                </div>
                                <% } %>

                                    <!-- Login Form -->
                                    <form action="userAuth" method="post" class="space-y-6">
                                        <input type="hidden" name="action" value="login">

                                        <input type="text" name="username" placeholder="Username" required
                                            class="input-field">

                                        <input type="password" name="password" placeholder="Password" required
                                            class="input-field">

                                        <button type="submit"
                                            class="w-full bg-gradient-to-r from-blue-500 to-cyan-400 text-white py-3 rounded-xl hover:scale-105 hover:shadow-lg transition duration-300 font-semibold">
                                            Login
                                        </button>
                                    </form>

                                    <p class="mt-6 text-center text-gray-700">
                                        Don't have an account?
                                        <a href="register.jsp"
                                            class="text-blue-600 font-semibold hover:underline hover:text-blue-800">
                                            Register here
                                        </a>
                                    </p>

            </div>
        </div>

        <!-- Styles -->
        <style>
            .input-field {
                width: 100%;
                padding: 0.9rem;
                border-radius: 0.75rem;
                border: 1.5px solid #d1d5db;
                background: rgba(255, 255, 255, 0.8);
                transition: all 0.3s ease;
            }

            .input-field:focus {
                border-color: #3b82f6;
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
                outline: none;
                background: white;
            }

            .animate-fade-up {
                animation: fadeUp 0.8s ease-in-out;
            }

            @keyframes fadeUp {
                0% {
                    opacity: 0;
                    transform: translateY(30px);
                }

                100% {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>

    </body>

    </html>