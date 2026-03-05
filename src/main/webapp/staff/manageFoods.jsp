<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Foods - Ocean View Resort</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
            <style>
                .bg-ocean {
                    background: linear-gradient(135deg, #f97316, #ea580c);
                }
            </style>
        </head>

        <body class="bg-gray-50 flex min-h-screen text-gray-800 font-sans">

            <%@ include file="/staff/sidebar.jsp" %>

                <main class="flex-1 p-8 transition-all duration-300 flex flex-col items-center">
                    <div class="max-w-7xl w-full">

                        <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
                            <div>
                                <h1 class="text-3xl font-bold text-gray-800 tracking-tight">Manage Food Packages</h1>
                                <p class="text-gray-500 mt-1">View and manage all gourmet food menus.</p>
                            </div>

                            <div class="flex flex-col sm:flex-row gap-4 w-full md:w-auto">
                                <!-- Search Bar -->
                                <form action="${pageContext.request.contextPath}/foods" method="get"
                                    class="relative group">
                                    <input type="hidden" name="action" value="search" />
                                    <i
                                        class="fa-solid fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-orange-500 transition-colors"></i>
                                    <input type="text" name="query" placeholder="Search foods..."
                                        class="pl-11 pr-4 py-2.5 bg-white border border-gray-200 rounded-xl focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all w-72" />
                                </form>

                                <a href="${pageContext.request.contextPath}/foods?action=addForm"
                                    class="bg-orange-600 text-white px-6 py-2.5 rounded-xl hover:bg-orange-700 transition shadow-lg shadow-orange-100 flex items-center justify-center gap-2 font-bold whitespace-nowrap">
                                    <i class="fa-solid fa-plus text-sm"></i> Add New Package
                                </a>
                            </div>
                        </div>

                        <!-- Cards Section -->
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                            <c:forEach var="food" items="${foodList}">
                                <div
                                    class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden hover:shadow-xl transition-all duration-300 group flex flex-col h-full transform hover:-translate-y-1">

                                    <!-- Food Image -->
                                    <div class="h-52 overflow-hidden relative">
                                        <c:choose>
                                            <c:when test="${not empty food.image}">
                                                <img src="${pageContext.request.contextPath}/${food.image}"
                                                    alt="${food.name}"
                                                    class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                                            </c:when>
                                            <c:otherwise>
                                                <div
                                                    class="w-full h-full bg-orange-50 flex items-center justify-center">
                                                    <i class="fas fa-utensils text-4xl text-orange-200"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- Price Badge -->
                                        <div
                                            class="absolute top-4 right-4 bg-white/95 backdrop-blur-sm text-gray-900 px-4 py-2 rounded-xl font-black shadow-lg text-lg border border-white/20">
                                            $${food.price}
                                        </div>
                                    </div>

                                    <!-- Food Info -->
                                    <div class="p-6 flex-1 flex flex-col">
                                        <h3
                                            class="text-gray-900 font-bold text-xl mb-2 group-hover:text-orange-600 transition-colors">
                                            ${food.name}</h3>
                                        <p
                                            class="text-gray-500 text-sm mb-6 line-clamp-3 leading-relaxed flex-grow italic">
                                            "${food.description}"
                                        </p>

                                        <div
                                            class="flex justify-between items-center mt-auto pt-6 border-t border-gray-50 gap-3">
                                            <a href="${pageContext.request.contextPath}/foods?action=editForm&packageId=${food.packageId}"
                                                class="flex-1 bg-blue-50 text-blue-600 px-4 py-2.5 rounded-xl text-sm font-bold hover:bg-blue-600 hover:text-white transition-all flex items-center justify-center gap-2 border border-blue-100">
                                                <i class="fa-solid fa-edit"></i> Edit
                                            </a>
                                            <button onclick="confirmDelete('${food.packageId}', '${food.name}')"
                                                class="flex-1 bg-red-50 text-red-600 px-4 py-2.5 rounded-xl text-sm font-bold hover:bg-red-600 hover:text-white transition-all flex items-center justify-center gap-2 border border-red-100">
                                                <i class="fa-solid fa-trash"></i> Delete
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <c:if test="${empty foodList}">
                            <div
                                class="bg-white p-16 rounded-3xl border border-dashed border-gray-300 shadow-sm text-center max-w-2xl mx-auto">
                                <div
                                    class="w-20 h-20 bg-orange-50 rounded-full flex items-center justify-center mx-auto mb-6">
                                    <i class="fa-solid fa-plate-wheat text-orange-400 text-3xl"></i>
                                </div>
                                <h3 class="text-2xl font-bold text-gray-900">No food packages found</h3>
                                <p class="text-gray-500 mt-2 text-lg">We couldn't find any packages matching your
                                    search. Create one to get started!</p>
                                <a href="${pageContext.request.contextPath}/foods?action=addForm"
                                    class="inline-block mt-8 bg-orange-600 text-white px-8 py-3 rounded-xl font-bold hover:bg-orange-700 transition shadow-lg">
                                    Add New Food Package
                                </a>
                            </div>
                        </c:if>

                    </div>
                </main>

                <!-- Delete Confirmation Script -->
                <script>
                    function confirmDelete(id, name) {
                        if (confirm('Are you sure you want to delete the food package "' + name + '"? This action cannot be undone.')) {
                            window.location.href = '${pageContext.request.contextPath}/foods?action=delete&packageId=' + id;
                        }
                    }
                </script>
        </body>

        </html>