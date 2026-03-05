<%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <jsp:include page="header.jsp" />

    <!-- Hero Section -->
    <section class="relative h-72 md:h-96 flex items-center justify-center overflow-hidden">
        <img src="${pageContext.request.contextPath}/images/event-wedding.jpg" alt="Events"
            class="absolute inset-0 w-full h-full object-cover" />
        <div class="absolute inset-0 bg-gradient-to-b from-black/40 via-black/20 to-black/40"></div>
        <div class="relative z-10 text-center">
            <h1 class="text-4xl md:text-5xl font-bold text-white mb-2">Events & Packages</h1>
            <p class="text-white/80">Make your special moments unforgettable</p>
        </div>
    </section>

    <!-- Events Section -->
    <section class="py-20">
        <div class="container mx-auto px-4 space-y-16">

            <c:choose>
                <c:when test="${not empty eventList}">
                    <c:forEach var="event" items="${eventList}" varStatus="status">
                        <!-- Dynamic Event Card -->
                        <div
                            class="flex flex-col ${status.index % 2 == 0 ? 'lg:flex-row' : 'lg:flex-row-reverse'} gap-8 items-center">
                            <div class="lg:w-1/2 rounded-2xl overflow-hidden shadow-xl border border-gray-100">
                                <c:choose>
                                    <c:when test="${not empty event.image}">
                                        <img src="${pageContext.request.contextPath}/${event.image}" alt="${event.name}"
                                            class="w-full h-72 md:h-[450px] object-cover hover:scale-110 transition-transform duration-700"
                                            onerror="this.src='${pageContext.request.contextPath}/images/event-fallback.jpg'" />
                                    </c:when>
                                    <c:otherwise>
                                        <div
                                            class="w-full h-72 md:h-[450px] bg-purple-50 flex items-center justify-center">
                                            <i class="fa-solid fa-gift text-purple-200 text-8xl"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="lg:w-1/2 space-y-6">
                                <span
                                    class="inline-block bg-purple-100 text-purple-700 px-4 py-1.5 rounded-full text-sm font-bold tracking-wide">
                                    From $${event.price}
                                </span>
                                <h2 class="text-4xl font-extrabold text-gray-900 leading-tight">${event.name}</h2>
                                <p class="text-gray-600 leading-relaxed text-lg">
                                    ${event.description}
                                </p>
                                <div class="flex flex-wrap gap-2 py-2">
                                    <span
                                        class="bg-gray-50 border border-gray-100 px-3 py-1.5 rounded-xl text-sm text-gray-700 flex items-center gap-2">
                                        <i class="fa-solid fa-check text-green-500"></i> Premium Venue
                                    </span>
                                    <span
                                        class="bg-gray-50 border border-gray-100 px-3 py-1.5 rounded-xl text-sm text-gray-700 flex items-center gap-2">
                                        <i class="fa-solid fa-check text-green-500"></i> Expert Planning
                                    </span>
                                    <span
                                        class="bg-gray-50 border border-gray-100 px-3 py-1.5 rounded-xl text-sm text-gray-700 flex items-center gap-2">
                                        <i class="fa-solid fa-check text-green-500"></i> Catering Options
                                    </span>
                                </div>
                                <a href="${pageContext.request.contextPath}/customer/eventBooking.jsp?eventId=${event.eventId}"
                                    class="inline-flex items-center gap-3 bg-purple-600 text-white px-8 py-4 rounded-2xl hover:bg-purple-700 hover:shadow-xl hover:shadow-purple-100 transition-all font-bold">
                                    Book This Event <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Pagination Controls -->
                    <div class="pt-16 flex justify-center items-center gap-4">
                        <c:if test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/events?action=customerList&page=${currentPage - 1}"
                                class="flex items-center gap-2 px-6 py-3 bg-white border border-gray-200 rounded-xl text-gray-700 hover:bg-gray-50 transition font-bold shadow-sm">
                                <i class="fa-solid fa-chevron-left"></i> Previous
                            </a>
                        </c:if>

                        <div class="flex items-center gap-2">
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <a href="${pageContext.request.contextPath}/events?action=customerList&page=${i}"
                                    class="w-12 h-12 flex items-center justify-center rounded-xl font-bold transition-all ${i == currentPage ? 'bg-purple-600 text-white shadow-lg shadow-purple-100' : 'bg-white border border-gray-200 text-gray-600 hover:bg-gray-50'}">
                                    ${i}
                                </a>
                            </c:forEach>
                        </div>

                        <c:if test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/events?action=customerList&page=${currentPage + 1}"
                                class="flex items-center gap-2 px-6 py-3 bg-white border border-gray-200 rounded-xl text-gray-700 hover:bg-gray-50 transition font-bold shadow-sm">
                                Next <i class="fa-solid fa-chevron-right"></i>
                            </a>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-20 bg-white rounded-3xl border border-dashed border-gray-200">
                        <div class="w-20 h-20 bg-purple-50 rounded-full flex items-center justify-center mx-auto mb-6">
                            <i class="fa-solid fa-calendar-xmark text-purple-300 text-3xl"></i>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900 mb-2">No event packages available</h3>
                        <p class="text-gray-500">We are currently curating new experiences for you. Please check back
                            soon!</p>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </section>

    <jsp:include page="footer.jsp" />