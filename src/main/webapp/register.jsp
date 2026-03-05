<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>User Registration - Ocean View Resort</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="relative min-h-screen flex items-center justify-center">

        <!-- Background -->
        <img src="<%= request.getContextPath() %>/images/login-bg.jpg"
            class="absolute inset-0 w-full h-full object-cover" alt="Resort Background">

        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm"></div>

        <!-- Register Card -->
        <div class="relative z-10 w-full max-w-4xl animate-fade-up">
            <div class="bg-white/90 backdrop-blur-xl shadow-2xl rounded-2xl p-10 border border-white/30">

                <h2 class="text-3xl font-bold text-center text-blue-600 mb-2">
                    Ocean View Resort
                </h2>
                <p class="text-center text-gray-500 mb-8 text-sm">
                    Create Your Account
                </p>

                <% String message=(String) request.getAttribute("message"); String error=(String)
                    request.getAttribute("error"); %>

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

                                    <form action="userAuth" method="post" class="space-y-6">
                                        <input type="hidden" name="action" value="register">

                                        <!-- Two Column Grid -->
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                                            <div>
                                                <label class="form-label">Username</label>
                                                <input type="text" name="username" required class="form-input">
                                            </div>

                                            <div>
                                                <label class="form-label">Password</label>
                                                <input type="password" name="password" required class="form-input">
                                            </div>

                                            <div>
                                                <label class="form-label">Contact Number</label>
                                                <input type="text" name="contact" class="form-input">
                                            </div>

                                            <div>
                                                <label class="form-label">Email</label>
                                                <input type="email" name="email" class="form-input">
                                            </div>

                                            <div>
                                                <label class="form-label">Address</label>
                                                <input type="text" name="address" class="form-input">
                                            </div>

                                            <div>
                                                <label class="form-label">NIC / Passport</label>
                                                <input type="text" name="nic" class="form-input">
                                            </div>

                                            <div class="md:col-span-2">
                                                <label class="form-label">Role</label>
                                                <select name="role" required class="form-input">
                                                    <option value="">Select Role</option>
                                                    <option value="ADMIN">Admin</option>
                                                    <option value="STAFF">Staff</option>
                                                    <option value="CUSTOMER">Customer</option>
                                                </select>
                                            </div>

                                        </div>

                                        <button type="submit"
                                            class="w-full bg-gradient-to-r from-blue-500 to-cyan-400 text-white py-3 rounded-xl hover:scale-105 hover:shadow-lg transition duration-300 font-semibold">
                                            Register
                                        </button>
                                    </form>

            </div>
        </div>

        <style>
            .form-label {
                display: block;
                margin-bottom: 6px;
                font-weight: 600;
                color: #374151;
            }

            .form-input {
                width: 100%;
                padding: 0.9rem;
                border-radius: 0.75rem;
                border: 1.5px solid #d1d5db;
                background: rgba(255, 255, 255, 0.9);
                transition: all 0.3s ease;
            }

            .form-input:focus {
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