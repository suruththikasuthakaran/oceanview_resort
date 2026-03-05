<%@ page import="model.Rooms" %>
    <%@ page import="java.util.List" %>
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>
            <%@ page contentType="text/html;charset=UTF-8" language="java" %>

                <% /** Mandatory check to prevent direct access */ if (request.getAttribute("roomsList")==null) {
                    response.sendRedirect(request.getContextPath() + "/rooms?action=publicList" ); return; } %>

                    <jsp:include page="header.jsp" />

                    <!-- Hero Section -->
                    <section class="relative h-72 md:h-96 flex items-center justify-center overflow-hidden">
                        <img src="<%= request.getContextPath() %>/images/room-deluxe.jpg" alt="Rooms"
                            class="absolute inset-0 w-full h-full object-cover">
                        <div class="absolute inset-0 bg-gradient-to-b from-black/40 to-black/20"></div>
                        <div class="relative z-10 text-center">
                            <h1 class="text-4xl md:text-5xl font-bold text-white mb-2">Our Rooms & Suites</h1>
                            <p class="text-white/80">Comfort meets luxury at every turn</p>
                        </div>
                    </section>

                    <!-- Rooms Section -->
                    <section class="py-20 bg-gray-50">
                        <div class="container mx-auto px-4 space-y-16">
                            <c:forEach var="room" items="${roomsList}" varStatus="loop">
                                <div
                                    class="flex flex-col ${loop.index % 2 != 0 ? 'lg:flex-row-reverse' : 'lg:flex-row'} gap-8 items-center">
                                    <!-- Image -->
                                    <div class="lg:w-1/2 w-full">
                                        <div class="rounded-xl overflow-hidden shadow-lg h-72 md:h-96 relative">
                                            <c:choose>
                                                <c:when test="${not empty room.image}">
                                                    <img src="${pageContext.request.contextPath}/${room.image}"
                                                        alt="Room ${room.roomNumber}"
                                                        class="w-full h-full object-cover hover:scale-105 transition-transform duration-500"
                                                        onerror="this.src='https://via.placeholder.com/600x400?text=No+Image'" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://via.placeholder.com/600x400?text=Ocean+View+Resort"
                                                        alt="Ocean View Resort" class="w-full h-full object-cover" />
                                                </c:otherwise>
                                            </c:choose>

                                            <c:if test="${room.status != 'AVAILABLE'}">
                                                <div
                                                    class="absolute inset-0 bg-black/50 flex items-center justify-center">
                                                    <span
                                                        class="bg-red-600 text-white px-6 py-2 rounded-full font-bold shadow-lg transform -rotate-12 outline outline-2 outline-white text-xl">
                                                        CURRENTLY UNAVAILABLE
                                                    </span>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>

                                    <!-- Details -->
                                    <div class="lg:w-1/2 space-y-4">
                                        <div
                                            class="inline-block bg-sky-100 text-sky-800 px-3 py-1 rounded-full text-sm font-semibold uppercase tracking-wider">
                                            ${room.roomType}
                                        </div>
                                        <div
                                            class="inline-block bg-yellow-300 text-yellow-900 px-3 py-1 rounded-full text-sm font-semibold ml-2">
                                            $${room.price} / night
                                        </div>

                                        <h2 class="text-3xl font-bold text-gray-800">Room ${room.roomNumber}</h2>
                                        <p class="text-gray-600 leading-relaxed max-w-lg">${room.description}</p>

                                        <div class="flex flex-wrap gap-3 pt-2">
                                            <span
                                                class="flex items-center gap-2 text-sm text-gray-700 bg-gray-200 px-4 py-2 rounded-lg font-medium">
                                                <i class="fa-solid fa-user-group text-sky-600"></i> Up to
                                                ${room.capacity} Guests
                                            </span>
                                            <span
                                                class="flex items-center gap-2 text-sm text-gray-700 bg-gray-200 px-4 py-2 rounded-lg font-medium">
                                                <i class="fa-solid fa-bed text-sky-600"></i> ${room.bedType}
                                            </span>
                                        </div>

                                        <div class="pt-4">
                                            <c:choose>
                                                <c:when test="${room.status == 'AVAILABLE'}">
                                                    <a
                                                        href="${pageContext.request.contextPath}/reservation?action=form&roomType=${room.roomType}">
                                                        <button
                                                            class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors shadow-md flex items-center gap-2 font-medium">
                                                            Book This Room <i class="fa-solid fa-arrow-right"></i>
                                                        </button>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <button disabled
                                                        class="bg-gray-400 text-white px-6 py-3 rounded-lg cursor-not-allowed flex items-center gap-2 font-medium">
                                                        Not Available For Booking
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <c:if test="${empty roomsList}">
                                <div class="text-center py-20">
                                    <i class="fa-solid fa-bed text-6xl text-gray-300 mb-4"></i>
                                    <h3 class="text-2xl font-semibold text-gray-700">No Rooms Found</h3>
                                    <p class="text-gray-500 mt-2">Check back later or contact support.</p>
                                </div>
                            </c:if>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="flex justify-center items-center mt-16 gap-2">
                                <c:if test="${currentPage > 1}">
                                    <a href="${pageContext.request.contextPath}/rooms?action=publicList&page=${currentPage - 1}"
                                        class="px-4 py-2 rounded-lg border border-gray-300 bg-white text-gray-700 hover:bg-gray-50 transition">
                                        Previous
                                    </a>
                                </c:if>

                                <c:forEach begin="1" end="${totalPages}" var="p">
                                    <a href="${pageContext.request.contextPath}/rooms?action=publicList&page=${p}"
                                        class="px-4 py-2 rounded-lg border ${p == currentPage ? 'bg-sky-600 border-sky-600 text-white shadow' : 'border-gray-300 bg-white text-gray-700 hover:bg-gray-50'} transition">
                                        ${p}
                                    </a>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <a href="${pageContext.request.contextPath}/rooms?action=publicList&page=${currentPage + 1}"
                                        class="px-4 py-2 rounded-lg border border-gray-300 bg-white text-gray-700 hover:bg-gray-50 transition">
                                        Next
                                    </a>
                                </c:if>
                            </div>
                        </c:if>
                    </section>

                    <!-- FontAwesome Injection for icons if not in header -->
                    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

                    <jsp:include page="footer.jsp" />