<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Add Event Package - Ocean View Resort</title>
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
                    <div class="max-w-4xl w-full bg-white rounded-2xl shadow-xl overflow-hidden border border-gray-100">
                        <div class="bg-ocean p-8 text-white">
                            <div class="flex items-center justify-center gap-4">
                                <div
                                    class="w-12 h-12 bg-white/20 rounded-lg flex items-center justify-center backdrop-blur-sm">
                                    <i class="fa-solid fa-gift text-2xl"></i>
                                </div>
                                <div>
                                    <h2 class="text-3xl font-bold tracking-tight">Add Event Package</h2>
                                    <p class="text-purple-100 mt-1">Configure a new event package for your guests.</p>
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

                            <form action="${pageContext.request.contextPath}/events" method="post"
                                enctype="multipart/form-data" class="space-y-8">
                                <input type="hidden" name="action" value="add" />

                                <div class="grid grid-cols-1 lg:grid-cols-2 gap-10">
                                    <div class="space-y-6">
                                        <h3
                                            class="text-xl font-bold text-gray-800 border-b pb-2 flex items-center gap-2">
                                            <i class="fa-solid fa-info-circle text-purple-600"></i>
                                            Package Details
                                        </h3>

                                        <div>
                                            <label
                                                class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">Event
                                                Name</label>
                                            <input name="name" required type="text"
                                                placeholder="e.g., Beach Wedding Package"
                                                class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all shadow-sm bg-gray-50 focus:bg-white" />
                                        </div>

                                        <div>
                                            <label
                                                class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">Base
                                                Price ($)</label>
                                            <div class="relative">
                                                <span
                                                    class="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400">$</span>
                                                <input type="number" step="0.01" name="price" required min="0"
                                                    placeholder="0.00"
                                                    class="w-full pl-8 pr-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all shadow-sm bg-gray-50 focus:bg-white" />
                                            </div>
                                        </div>

                                        <div>
                                            <label
                                                class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">Detailed
                                                Description</label>
                                            <textarea name="description" rows="5" required
                                                placeholder="Describe what is included in this event package..."
                                                class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-all shadow-sm bg-gray-50 focus:bg-white resize-none"></textarea>
                                        </div>
                                    </div>

                                    <div class="space-y-6">
                                        <h3
                                            class="text-xl font-bold text-gray-800 border-b pb-2 flex items-center gap-2">
                                            <i class="fa-solid fa-camera text-purple-600"></i>
                                            Media Asset
                                        </h3>

                                        <div>
                                            <label
                                                class="block text-sm font-bold text-gray-700 mb-3 uppercase tracking-wide">Event
                                                Image</label>
                                            <label for="imageFile"
                                                class="group relative flex flex-col items-center justify-center w-full h-64 border-2 border-gray-200 border-dashed rounded-2xl cursor-pointer bg-gray-50 hover:bg-purple-50 hover:border-purple-400 transition-all">
                                                <div class="flex flex-col items-center justify-center pt-5 pb-6">
                                                    <div
                                                        class="w-16 h-16 bg-white rounded-full shadow-sm flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
                                                        <i
                                                            class="fa-solid fa-cloud-arrow-up text-3xl text-purple-600"></i>
                                                    </div>
                                                    <p class="mb-2 text-sm text-gray-700 font-semibold"><span
                                                            class="text-purple-600">Click to upload</span> or drag and
                                                        drop</p>
                                                    <p class="text-xs text-gray-500">Event promo photo (PNG, JPG, max
                                                        10MB)</p>
                                                </div>
                                                <input id="imageFile" name="imageFile" type="file" class="sr-only"
                                                    accept="image/*" onchange="previewImage(this)">
                                                <div id="imagePreview"
                                                    class="absolute inset-0 hidden rounded-2xl overflow-hidden pointer-events-none">
                                                    <img src="" class="w-full h-full object-cover">
                                                    <div
                                                        class="absolute inset-0 bg-black/20 flex items-center justify-center opacity-0 hover:opacity-100 transition-opacity">
                                                        <p class="text-white text-sm font-bold">Change Image</p>
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex justify-end gap-5 pt-8 border-t border-gray-100">
                                    <a href="${pageContext.request.contextPath}/events?action=list"
                                        class="px-8 py-3.5 rounded-xl border border-gray-200 text-gray-600 hover:bg-gray-50 hover:text-gray-900 transition-all font-bold tracking-wide">
                                        Discard Changes
                                    </a>
                                    <button type="submit"
                                        class="px-12 py-3.5 rounded-xl bg-purple-600 text-white hover:bg-purple-700 focus:outline-none focus:ring-4 focus:ring-purple-200 transition-all shadow-lg shadow-purple-100 font-bold tracking-tight flex items-center gap-2">
                                        <i class="fa-solid fa-save"></i>
                                        Save Package
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </main>

                <script>
                    function previewImage(input) {
                        const preview = document.getElementById('imagePreview');
                        const file = input.files[0];
                        const reader = new FileReader();

                        reader.onloadend = function () {
                            preview.querySelector('img').src = reader.result;
                            preview.classList.remove('hidden');
                        }

                        if (file) {
                            reader.readAsDataURL(file);
                        } else {
                            preview.querySelector('img').src = "";
                            preview.classList.add('hidden');
                        }
                    }
                </script>
                </div>
                </div>
                </main>

        </body>

        </html>