<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="model.User" %>
        <%@ page import="model.Role" %>
            <%@ page import="model.EventPackage" %>
                <%@ page import="controller.EventPackageController" %>
                    <%@ page import="java.util.List" %>
                        <%@ taglib prefix="c" uri="jakarta.tags.core" %>

                            <% /* Authentication Check */ User currentUser=(User) session.getAttribute("currentUser");
                                if (currentUser==null) { request.setAttribute("error", "Please login to book an event."
                                ); request.getRequestDispatcher("../login.jsp?redirect=eventBooking").forward(request,
                                response); return; } /* Check if user is a customer */ if (currentUser.getRole()
                                !=Role.CUSTOMER) {
                                request.setAttribute("error", "Only customers can book event packages." );
                                request.getRequestDispatcher("../login.jsp").forward(request, response); return; } /*
                                Fetch event packages for dropdown */ EventPackageController
                                eventController=EventPackageController.getInstance(); List<EventPackage> eventPackages =
                                eventController.getAllEventPackages();

                                /* Check for pre-selected event */
                                String preSelectedId = request.getParameter("eventId");
                                %>

                                <jsp:include page="header.jsp" />

                                <section
                                    class="pt-28 pb-20 bg-gray-50 bg-[url('${pageContext.request.contextPath}/images/bg-pattern.png')] bg-fixed">
                                    <div class="container mx-auto px-4 max-w-6xl">

                                        <div class="text-center mb-12">
                                            <h1 class="text-5xl font-extrabold text-gray-900 mb-4 tracking-tight">Book
                                                Your Escape</h1>
                                            <p class="text-gray-500 text-lg">Indulge in luxury with our curated event
                                                packages tailored to your desires.</p>
                                        </div>

                                        <div class="grid lg:grid-cols-3 gap-12 items-start">

                                            <!-- Left Side: Package Highlights -->
                                            <div class="lg:col-span-1 space-y-6">
                                                <div
                                                    class="bg-gradient-to-br from-purple-600 to-blue-700 text-white rounded-3xl p-8 shadow-2xl shadow-purple-200">
                                                    <h2 class="text-3xl font-bold mb-6 flex items-center gap-3">
                                                        <i class="fa-solid fa-star text-yellow-300"></i> Why Choose Us?
                                                    </h2>

                                                    <div class="space-y-6">
                                                        <div class="flex gap-4">
                                                            <i class="fa-solid fa-hotel text-2xl text-purple-200"></i>
                                                            <div>
                                                                <h4 class="font-bold text-lg">Stunning Venues</h4>
                                                                <p class="text-purple-100 text-sm">Breathtaking
                                                                    beachfront and indoor settings.</p>
                                                            </div>
                                                        </div>
                                                        <div class="flex gap-4">
                                                            <i
                                                                class="fa-solid fa-utensils text-2xl text-purple-200"></i>
                                                            <div>
                                                                <h4 class="font-bold text-lg">World-Class Catering</h4>
                                                                <p class="text-purple-100 text-sm">Gourmet menus crafted
                                                                    by master chefs.</p>
                                                            </div>
                                                        </div>
                                                        <div class="flex gap-4">
                                                            <i
                                                                class="fa-solid fa-shield-heart text-2xl text-purple-200"></i>
                                                            <div>
                                                                <h4 class="font-bold text-lg">Seamless Planning</h4>
                                                                <p class="text-purple-100 text-sm">Dedicated event
                                                                    managers for every detail.</p>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="mt-10 pt-8 border-t border-white/20">
                                                        <p class="text-sm opacity-80 mb-2 italic">Need immediate
                                                            assistance?</p>
                                                        <p class="font-bold flex items-center gap-2"><i
                                                                class="fa-solid fa-phone"></i> +94 91 234 5678</p>
                                                    </div>
                                                </div>

                                                <div class="bg-white rounded-3xl p-6 shadow-sm border border-gray-100">
                                                    <h3 class="font-bold text-gray-800 mb-4">Secure Booking</h3>
                                                    <p class="text-gray-500 text-sm flex items-center gap-2">
                                                        <i class="fa-solid fa-lock text-green-500"></i> Your data is
                                                        protected by industry standard encryption.
                                                    </p>
                                                </div>
                                            </div>

                                            <!-- Right Side: Booking Form -->
                                            <div class="lg:col-span-2">
                                                <form action="${pageContext.request.contextPath}/eventBooking"
                                                    method="post"
                                                    class="bg-white rounded-3xl p-10 shadow-xl border border-gray-50 space-y-8">

                                                    <div class="grid md:grid-cols-2 gap-6">
                                                        <!-- Name (Pre-filled) -->
                                                        <div class="space-y-2">
                                                            <label for="name"
                                                                class="block text-sm font-bold text-gray-700 ml-1">Full
                                                                Name</label>
                                                            <input type="text" id="name" name="name"
                                                                value="<%= currentUser.getUsername() %>"
                                                                class="w-full border border-gray-200 rounded-2xl px-5 py-3.5 focus:ring-4 focus:ring-purple-500/10 focus:border-purple-500 outline-none transition-all bg-gray-50 text-gray-500 cursor-not-allowed"
                                                                readonly required />
                                                        </div>

                                                        <!-- Phone -->
                                                        <div class="space-y-2">
                                                            <label for="phone"
                                                                class="block text-sm font-bold text-gray-700 ml-1">Phone
                                                                Number</label>
                                                            <input type="tel" id="phone" name="phone"
                                                                placeholder="+94 7X XXX XXXX"
                                                                class="w-full border border-gray-200 rounded-2xl px-5 py-3.5 focus:ring-4 focus:ring-purple-500/10 focus:border-purple-500 outline-none transition-all"
                                                                required />
                                                        </div>
                                                    </div>

                                                    <!-- Event Type Dropdown (Dynamic) -->
                                                    <div class="space-y-2">
                                                        <label for="eventType"
                                                            class="block text-sm font-bold text-gray-700 ml-1">Select
                                                            Event Package</label>
                                                        <select id="eventType" name="eventType"
                                                            class="w-full border border-gray-200 rounded-2xl px-5 py-3.5 focus:ring-4 focus:ring-purple-500/10 focus:border-purple-500 outline-none transition-all bg-white appearance-none cursor-pointer"
                                                            required>
                                                            <option value="">Choose a package...</option>
                                                            <% for (EventPackage pkg : eventPackages) { %>
                                                                <option value="<%= pkg.getEventId() %>"
                                                                    <%=(preSelectedId !=null &&
                                                                    preSelectedId.equals(String.valueOf(pkg.getEventId())))
                                                                    ? "selected" : "" %>>
                                                                    <%= pkg.getName() %> - starting from $<%=
                                                                            pkg.getPrice() %>
                                                                </option>
                                                                <% } %>
                                                        </select>
                                                    </div>

                                                    <div class="grid md:grid-cols-2 gap-6">
                                                        <!-- Number of Guests -->
                                                        <div class="space-y-2">
                                                            <label for="guests"
                                                                class="block text-sm font-bold text-gray-700 ml-1">Estimated
                                                                Guests</label>
                                                            <div class="relative">
                                                                <input type="number" id="guests" name="guests"
                                                                    placeholder="0" min="1"
                                                                    class="w-full border border-gray-200 rounded-2xl px-5 py-3.5 focus:ring-4 focus:ring-purple-500/10 focus:border-purple-500 outline-none transition-all"
                                                                    required />
                                                                <i
                                                                    class="fa-solid fa-users absolute right-5 top-1/2 -translate-y-1/2 text-gray-300"></i>
                                                            </div>
                                                        </div>

                                                        <!-- Event Date -->
                                                        <div class="space-y-2">
                                                            <label for="date"
                                                                class="block text-sm font-bold text-gray-700 ml-1">Preferred
                                                                Date</label>
                                                            <div class="relative">
                                                                <input type="date" id="date" name="date"
                                                                    class="w-full border border-gray-200 rounded-2xl px-5 py-3.5 focus:ring-4 focus:ring-purple-500/10 focus:border-purple-500 outline-none transition-all bg-white"
                                                                    required />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Special Requests -->
                                                    <div class="space-y-2">
                                                        <label for="requests"
                                                            class="block text-sm font-bold text-gray-700 ml-1">Personal
                                                            Requests & Notes</label>
                                                        <textarea id="requests" name="requests" rows="4"
                                                            placeholder="Tell us about your dream event..."
                                                            class="w-full border border-gray-200 rounded-2xl px-5 py-3.5 focus:ring-4 focus:ring-purple-500/10 focus:border-purple-500 outline-none transition-all"></textarea>
                                                    </div>

                                                    <!-- Submit Button -->
                                                    <button type="submit"
                                                        class="w-full bg-gradient-to-r from-purple-600 to-blue-600 text-white px-8 py-5 rounded-2xl hover:opacity-90 transition-all font-extrabold text-lg shadow-xl shadow-purple-100 flex items-center justify-center gap-3">
                                                        <i class="fa-solid fa-calendar-check"></i> Request Reservation
                                                    </button>

                                                    <p class="text-center text-xs text-gray-400">By submitting, you
                                                        agree to our terms and conditions. A representative will contact
                                                        you within 24 hours.</p>
                                                </form>
                                            </div>

                                        </div>
                                    </div>
                                </section>

                                <jsp:include page="footer.jsp" />