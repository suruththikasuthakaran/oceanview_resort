<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <jsp:include page="header.jsp" />

    <section class="pt-28 pb-20">
        <div class="container mx-auto px-4">

            <!-- Page Title -->
            <div class="text-center mb-12">
                <h1 class="text-3xl md:text-4xl font-bold text-gray-800 mb-2">
                    Contact Us
                </h1>
                <p class="text-gray-500">
                    We'd love to hear from you
                </p>
            </div>

            <div class="grid lg:grid-cols-2 gap-12 max-w-5xl mx-auto">

                <!-- Contact Info -->
                <div class="space-y-6">
                    <h2 class="text-2xl font-semibold text-gray-800">
                        Get in Touch
                    </h2>

                    <div class="space-y-4">

                        <!-- Address -->
                        <div class="flex items-start gap-4 p-4 rounded-xl bg-white shadow-md">
                            <div class="w-10 h-10 rounded-lg bg-blue-100 flex items-center justify-center">
                                📍
                            </div>
                            <div>
                                <p class="text-sm font-semibold text-gray-800">Address</p>
                                <p class="text-sm text-gray-500">
                                    123 Beach Road, Unawatuna, Galle, Sri Lanka
                                </p>
                            </div>
                        </div>

                        <!-- Phone -->
                        <div class="flex items-start gap-4 p-4 rounded-xl bg-white shadow-md">
                            <div class="w-10 h-10 rounded-lg bg-blue-100 flex items-center justify-center">
                                📞
                            </div>
                            <div>
                                <p class="text-sm font-semibold text-gray-800">Phone</p>
                                <p class="text-sm text-gray-500">
                                    +94 77 234 5678
                                </p>
                            </div>
                        </div>

                        <!-- Email -->
                        <div class="flex items-start gap-4 p-4 rounded-xl bg-white shadow-md">
                            <div class="w-10 h-10 rounded-lg bg-blue-100 flex items-center justify-center">
                                ✉️
                            </div>
                            <div>
                                <p class="text-sm font-semibold text-gray-800">Email</p>
                                <p class="text-sm text-gray-500">
                                    sparkleoceanview@oceanviewgalle.com
                                </p>
                            </div>
                        </div>

                        <!-- Front Desk -->
                        <div class="flex items-start gap-4 p-4 rounded-xl bg-white shadow-md">
                            <div class="w-10 h-10 rounded-lg bg-blue-100 flex items-center justify-center">
                                ⏰
                            </div>
                            <div>
                                <p class="text-sm font-semibold text-gray-800">Front Desk</p>
                                <p class="text-sm text-gray-500">
                                    Open 24/7
                                </p>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Contact Form -->
                <div>
                    <% String message=(String) request.getAttribute("message"); String error=(String)
                        request.getAttribute("error"); if (message !=null) { %>
                        <div
                            class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-xl mb-4 text-center font-medium animate-fade-in">
                            <i class="fas fa-check-circle mr-2"></i>
                            <%= message %>
                        </div>
                        <% } %>
                            <% if (error !=null) { %>
                                <div
                                    class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-xl mb-4 text-center font-medium animate-fade-in">
                                    <i class="fas fa-exclamation-circle mr-2"></i>
                                    <%= error %>
                                </div>
                                <% } %>

                                    <form action="<%= request.getContextPath() %>/sendMessageServlet" method="post"
                                        class="bg-white rounded-2xl p-8 shadow-md space-y-5">

                                        <h2 class="text-2xl font-semibold text-gray-800">
                                            Send a Message
                                        </h2>

                                        <div class="grid sm:grid-cols-2 gap-4">
                                            <div class="space-y-2">
                                                <label class="block text-sm font-medium">Name</label>
                                                <input type="text" name="name" class="w-full border rounded-lg p-2"
                                                    placeholder="Your name" required>
                                            </div>

                                            <div class="space-y-2">
                                                <label class="block text-sm font-medium">Email</label>
                                                <input type="email" name="email" class="w-full border rounded-lg p-2"
                                                    placeholder="your@email.com" required>
                                            </div>
                                        </div>

                                        <div class="space-y-2">
                                            <label class="block text-sm font-medium">Subject</label>
                                            <input type="text" name="subject" class="w-full border rounded-lg p-2"
                                                placeholder="How can we help?" required>
                                        </div>

                                        <div class="space-y-2">
                                            <label class="block text-sm font-medium">Message</label>
                                            <textarea name="message" rows="4" class="w-full border rounded-lg p-2"
                                                placeholder="Your message..." required></textarea>
                                        </div>

                                        <button type="submit"
                                            class="w-full bg-blue-600 text-white rounded-lg p-3 hover:bg-blue-700 transition">
                                            Send Message
                                        </button>

                                    </form>
                </div>

            </div>
        </div>
    </section>

    <jsp:include page="footer.jsp" />