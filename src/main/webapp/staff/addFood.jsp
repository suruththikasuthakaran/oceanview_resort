<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Add Food Package - Ocean View Resort</title>
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
                    <div class="max-w-4xl w-full bg-white rounded-2xl shadow-xl overflow-hidden border border-gray-100">
                        <div class="bg-ocean p-8 text-white">
                            <div class="flex items-center justify-center gap-4">
                                <div
                                    class="w-12 h-12 bg-white/20 rounded-lg flex items-center justify-center backdrop-blur-sm">
                                    <i class="fa-solid fa-utensils text-2xl"></i>
                                </div>
                                <div>
                                    <h2 class="text-3xl font-bold tracking-tight">Add Food Package</h2>
                                    <p class="text-orange-100 mt-1">Create a new gourmet menu for your guests.</p>
                                </div>
                            </div>
                        </div>

                        <div class="p-10">
                            <c:if test="${not empty error}">
                                <div class="bg-red-50 border-l-4 border-red-500 text-red-700 p-4 rounded-lg mb-8 flex items-center gap-3 animate-pulse"
                                    role="alert">
                                    <i class="fa-solid fa-circle-exclamation text-xl"></i>
                                    <span class="font-medium">${error}</span>
                                </div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/foods" method="post"
                                enctype="multipart/form-data" class="space-y-8">
                                <input type="hidden" name="action" value="add" />

                                <div>
                                    <h3
                                        class="text-xl font-bold text-gray-800 border-b pb-2 flex items-center gap-2 mb-6">
                                        <i class="fa-solid fa-burger text-orange-600"></i>
                                        Food Package Details
                                    </h3>

                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                        <div>
                                            <label
                                                class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">Package
                                                Name</label>
                                            <input name="name" required type="text"
                                                placeholder="e.g., Seafood Deluxe Platter"
                                                class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all shadow-sm bg-gray-50 focus:bg-white" />
                                        </div>

                                        <div>
                                            <label
                                                class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">Price
                                                ($)</label>
                                            <div class="relative">
                                                <span
                                                    class="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400">$</span>
                                                <input type="number" step="0.01" name="price" required min="0"
                                                    placeholder="0.00"
                                                    class="w-full pl-8 pr-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all shadow-sm bg-gray-50 focus:bg-white" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-6">
                                        <label
                                            class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">
                                            Food Image
                                        </label>
                                        <input type="file" name="imageFile" accept="image/*" required
                                            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-orange-500 outline-none transition-all bg-gray-50 bg-white" />
                                        <p class="text-xs text-gray-500 mt-2">Recommended size: 800x600px. Max size:
                                            5MB. Accepted formats: JPG, PNG.</p>
                                    </div>

                                    <div>
                                        <label
                                            class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">Package
                                            Description</label>
                                        <textarea name="description" rows="5" required
                                            placeholder="List the items included in this food package..."
                                            class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-orange-500 focus:border-transparent outline-none transition-all shadow-sm bg-gray-50 focus:bg-white resize-none"></textarea>
                                    </div>
                                </div>

                                <div class="flex justify-end gap-5 pt-8 border-t border-gray-100">
                                    <a href="${pageContext.request.contextPath}/foods?action=list"
                                        class="px-8 py-3.5 rounded-xl border border-gray-200 text-gray-600 hover:bg-gray-50 hover:text-gray-900 transition-all font-bold tracking-wide">
                                        Discard Changes
                                    </a>
                                    <button type="submit"
                                        class="px-12 py-3.5 rounded-xl bg-orange-600 text-white hover:bg-orange-700 focus:outline-none focus:ring-4 focus:ring-orange-200 transition-all shadow-lg shadow-orange-100 font-bold tracking-tight flex items-center gap-2">
                                        <i class="fa-solid fa-save"></i>
                                        Save Food Package
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </main>

        </body>

        </html>