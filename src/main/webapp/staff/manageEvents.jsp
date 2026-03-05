<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Events - Ocean View Resort</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
            <style>
                .bg-ocean {
                    background: linear-gradient(135deg, #8b5cf6, #6d28d9);
                }
            </style>
        </head>

        <body class="bg-gray-50 flex min-h-screen text-gray-800 font-sans">

            <%@ include file="/staff/sidebar.jsp" %>

                <main class="flex-1 p-8 transition-all duration-300 flex flex-col items-center">
                    <div class="max-w-7xl w-full">

                        <div class="flex justify-between items-center mb-8">
                            <div>
                                <h1 class="text-3xl font-bold text-gray-800 tracking-tight">Manage Event Packages</h1>
                                <p class="text-gray-500 mt-1">View and manage all resort event packages.</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/events?action=addForm"
                                class="bg-purple-600 text-white px-5 py-2.5 rounded-lg hover:bg-purple-700 transition shadow flex items-center gap-2 font-medium">
                                <i class="fa-solid fa-plus"></i> Add New Event
                            </a>
                        </div>

                        <!-- Search Section -->
                        <div
                            class="bg-white p-5 rounded-xl shadow-sm mb-8 border border-gray-100 flex flex-wrap gap-4 items-end">
                            <form action="${pageContext.request.contextPath}/events" method="get"
                                class="flex-1 flex gap-4">
                                <input type="hidden" name="action" value="search" />
                                <div class="flex-1 relative">
                                    <i
                                        class="fa-solid fa-magnifying-glass absolute left-4 top-1/2 -translate-y-1/2 text-gray-400"></i>
                                    <input type="text" name="query" value="${param.query}"
                                        placeholder="Search events by name or description..."
                                        class="w-full pl-11 pr-4 py-2.5 border border-gray-200 rounded-xl focus:ring-2 focus:ring-purple-500 outline-none transition-all">
                                </div>
                                <button type="submit"
                                    class="bg-purple-600 text-white px-8 py-2.5 rounded-xl hover:bg-purple-700 transition font-bold tracking-wide shadow-lg shadow-purple-50">
                                    Search
                                </button>
                                <a href="${pageContext.request.contextPath}/events?action=list"
                                    class="px-6 py-2.5 rounded-xl border border-gray-200 text-gray-600 hover:bg-gray-50 transition font-bold">
                                    Reset
                                </a>
                            </form>
                        </div>

                        <!-- Cards Section -->
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                            <c:forEach var="event" items="${eventList}">
                                <div
                                    class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden hover:shadow-xl transition-all duration-300 group flex flex-col h-full">

                                    <!-- Event Image -->
                                    <div class="h-48 w-full bg-purple-50 relative overflow-hidden flex-shrink-0">
                                        <c:choose>
                                            <c:when test="${not empty event.image}">
                                                <img src="${pageContext.request.contextPath}/${event.image}"
                                                    alt="${event.name}"
                                                    class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500"
                                                    onerror="this.src='https://via.placeholder.com/400x300?text=Event+Package'" />
                                            </c:when>
                                            <c:otherwise>
                                                <div class="w-full h-full flex items-center justify-center">
                                                    <i class="fa-solid fa-gift text-purple-200 text-5xl"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Event Info -->
                                    <div class="p-5 flex-1 flex flex-col">
                                        <div class="flex justify-between items-start mb-3">
                                            <h3
                                                class="text-gray-900 font-bold text-lg leading-tight group-hover:text-purple-600 transition-colors">
                                                ${event.name}</h3>
                                            <div
                                                class="bg-purple-50 text-purple-600 px-2 py-1 rounded-lg text-xs font-bold">
                                                $${event.price}
                                            </div>
                                        </div>

                                        <p class="text-gray-500 text-sm mb-4 line-clamp-3 flex-grow">
                                            ${event.description}</p>

                                        <!-- Action Buttons -->
                                        <div class="flex gap-2 pt-4 border-t border-gray-50 mt-auto">
                                            <a href="${pageContext.request.contextPath}/events?action=editForm&eventId=${event.eventId}"
                                                class="flex-1 bg-purple-50 text-purple-700 hover:bg-purple-600 hover:text-white py-2.5 rounded-xl text-center font-bold text-sm transition flex items-center justify-center gap-2">
                                                <i class="fa-solid fa-pen text-xs"></i> Edit
                                            </a>
                                            <a href="${pageContext.request.contextPath}/events?action=delete&eventId=${event.eventId}"
                                                onclick="return confirm('Delete this event package?');"
                                                class="flex-1 bg-red-50 text-red-700 hover:bg-red-600 hover:text-white py-2.5 rounded-xl text-center font-bold text-sm transition flex items-center justify-center gap-2">
                                                <i class="fa-solid fa-trash-can text-xs"></i> Delete
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <c:if test="${empty eventList}">
                            <div class="bg-white p-12 rounded-xl border border-gray-100 shadow-sm text-center">
                                <div
                                    class="w-16 h-16 bg-purple-50 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="fa-solid fa-gift text-purple-400 text-2xl"></i>
                                </div>
                                <h3 class="text-lg font-medium text-gray-900">No event packages found</h3>
                                <p class="text-gray-500 mt-1">Click "Add New Event" to create your first event package.
                                </p>
                            </div>
                        </c:if>

                    </div>
                </main>
        </body>

        </html>