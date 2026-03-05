<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Rooms - Ocean View Resort</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
            <style>
                .bg-ocean {
                    background: linear-gradient(135deg, #0ea5e9, #0284c7);
                }
            </style>
        </head>

        <body class="bg-gray-50 flex min-h-screen text-gray-800 font-sans">

            <%@ include file="/staff/sidebar.jsp" %>

                <main class="flex-1 p-8 transition-all duration-300 flex flex-col items-center">
                    <div class="max-w-7xl w-full">

                        <div class="flex justify-between items-center mb-8">
                            <div>
                                <h1 class="text-3xl font-bold text-gray-800 tracking-tight">Manage Rooms</h1>
                                <p class="text-gray-500 mt-1">View, search, and manage all resort rooms.</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/rooms?action=addForm"
                                class="bg-sky-600 text-white px-5 py-2.5 rounded-lg hover:bg-sky-700 transition shadow flex items-center gap-2 font-medium">
                                <i class="fa-solid fa-plus"></i> Add New Room
                            </a>
                        </div>

                        <!-- Search Section -->
                        <div class="bg-white p-5 rounded-xl shadow-sm mb-6 border border-gray-100">
                            <form action="${pageContext.request.contextPath}/rooms" method="get"
                                class="flex flex-wrap gap-4 items-end">
                                <input type="hidden" name="action" value="search" />

                                <div class="flex-1 min-w-[150px]">
                                    <label class="block text-sm font-medium text-gray-600 mb-1">Room Number</label>
                                    <input type="text" name="roomNumber" placeholder="e.g. 101"
                                        value="${param.roomNumber}"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-sky-500 focus:border-sky-500 outline-none" />
                                </div>

                                <div class="flex-1 min-w-[200px]">
                                    <label class="block text-sm font-medium text-gray-600 mb-1">Room Type</label>
                                    <input type="text" name="roomType" placeholder="e.g. DELUXE"
                                        value="${param.roomType}"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-sky-500 focus:border-sky-500 outline-none" />
                                </div>

                                <div class="flex-1 min-w-[200px]">
                                    <label class="block text-sm font-medium text-gray-600 mb-1">Status</label>
                                    <select name="status"
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-sky-500 focus:border-sky-500 outline-none bg-white">
                                        <option value="">All Statuses</option>
                                        <option value="AVAILABLE" ${param.status=='AVAILABLE' ? 'selected' : '' }>
                                            Available
                                        </option>
                                        <option value="BOOKED" ${param.status=='BOOKED' ? 'selected' : '' }>Booked
                                        </option>
                                        <option value="MAINTENANCE" ${param.status=='MAINTENANCE' ? 'selected' : '' }>
                                            Maintenance</option>
                                    </select>
                                </div>

                                <button type="submit"
                                    class="bg-gray-800 text-white px-6 py-2.5 rounded-lg hover:bg-gray-900 transition font-medium border border-transparent flex items-center gap-2">
                                    <i class="fa-solid fa-magnifying-glass"></i> Search
                                </button>
                                <a href="${pageContext.request.contextPath}/rooms?action=list"
                                    class="px-6 py-2.5 rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition font-medium">
                                    Reset
                                </a>
                            </form>
                        </div>

                        <!-- Cards Section -->
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                            <c:forEach var="room" items="${roomsList}">
                                <div
                                    class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-md transition-shadow group relative flex flex-col h-full">
                                    <!-- Status Badge Overlay -->
                                    <div class="absolute top-4 right-4 z-10">
                                        <c:choose>
                                            <c:when test="${room.status == 'AVAILABLE'}">
                                                <span
                                                    class="px-2.5 py-1 bg-green-500 text-white text-xs rounded-full font-bold shadow-sm">
                                                    AVAILABLE
                                                </span>
                                            </c:when>
                                            <c:when test="${room.status == 'BOOKED'}">
                                                <span
                                                    class="px-2.5 py-1 bg-blue-500 text-white text-xs rounded-full font-bold shadow-sm">
                                                    BOOKED
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span
                                                    class="px-2.5 py-1 bg-red-500 text-white text-xs rounded-full font-bold shadow-sm">
                                                    MAINTENANCE
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Room Image -->
                                    <div class="h-48 w-full bg-gray-200 relative overflow-hidden flex-shrink-0">
                                        <c:choose>
                                            <c:when test="${not empty room.image}">
                                                <img src="${pageContext.request.contextPath}/${room.image}"
                                                    alt="Room ${room.roomNumber}"
                                                    class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500"
                                                    onerror="this.src='https://via.placeholder.com/400x300?text=No+Image'" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://via.placeholder.com/400x300?text=No+Image"
                                                    alt="No image" class="w-full h-full object-cover" />
                                            </c:otherwise>
                                        </c:choose>
                                        <div
                                            class="absolute bottom-0 left-0 w-full bg-gradient-to-t from-black/70 to-transparent p-4">
                                            <h3
                                                class="text-white text-xl font-bold border-b border-white/20 pb-1 inline-block">
                                                Room ${room.roomNumber}</h3>
                                        </div>
                                    </div>

                                    <!-- Room Info -->
                                    <div class="p-5 flex-1 flex flex-col">
                                        <div class="flex justify-between items-start mb-4">
                                            <div>
                                                <span
                                                    class="text-sky-600 font-bold text-sm uppercase tracking-wider block">${room.roomType}</span>
                                                <span class="text-gray-900 font-bold text-lg block mt-1">$${room.price}
                                                    <span class="text-gray-500 text-sm font-normal">/
                                                        night</span></span>
                                            </div>
                                            <div
                                                class="bg-gray-100 rounded px-2 py-1 flex items-center text-gray-600 text-sm">
                                                <i class="fa-solid fa-user-group mr-1.5 text-xs"></i> ${room.capacity}
                                            </div>
                                        </div>

                                        <div class="text-gray-600 text-sm mb-4 line-clamp-2 flex-grow">
                                            <i class="fa-solid fa-bed text-gray-400 mr-2"></i> ${room.bedType}
                                        </div>

                                        <!-- Action Buttons -->
                                        <div class="flex gap-2 pt-4 border-t border-gray-100 mt-auto">
                                            <a href="${pageContext.request.contextPath}/rooms?action=editForm&roomId=${room.roomId}"
                                                class="flex-1 bg-yellow-50 text-yellow-700 hover:bg-yellow-500 hover:text-white py-2 rounded-lg text-center font-medium transition flex items-center justify-center gap-2">
                                                <i class="fa-solid fa-pen text-sm"></i> Edit
                                            </a>
                                            <a href="${pageContext.request.contextPath}/rooms?action=delete&roomId=${room.roomId}"
                                                onclick="return confirm('Are you sure you want to delete room ${room.roomNumber}?');"
                                                class="flex-1 bg-red-50 text-red-700 hover:bg-red-500 hover:text-white py-2 rounded-lg text-center font-medium transition flex items-center justify-center gap-2">
                                                <i class="fa-solid fa-trash-can text-sm"></i> Delete
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <c:if test="${empty roomsList}">
                            <div class="bg-white p-12 rounded-xl border border-gray-100 shadow-sm text-center">
                                <div
                                    class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                                    <i class="fa-solid fa-bed text-gray-400 text-2xl"></i>
                                </div>
                                <h3 class="text-lg font-medium text-gray-900">No rooms found</h3>
                                <p class="text-gray-500 mt-1">There are no rooms matching your search criteria.</p>
                            </div>
                        </c:if>

                    </div>
                </main>
        </body>

        </html>