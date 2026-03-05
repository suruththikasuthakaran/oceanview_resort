<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.io.File" %>
        <jsp:include page="header.jsp" />

        <!-- Hero Section -->
        <section class="pt-28 pb-20">
            <div class="container mx-auto px-4">
                <div class="text-center mb-12">
                    <h1 class="text-3xl md:text-4xl font-bold text-gray-800 mb-2">Gallery</h1>
                    <p class="text-gray-500">Explore our resort through images</p>
                </div>

                <!-- Gallery Grid -->
                <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                    <% // Dynamically load images from the images directory String
                        imagePath=application.getRealPath("/images"); File folder=new File(imagePath); File[]
                        listOfFiles=folder.listFiles(); if (listOfFiles !=null) { for (File file : listOfFiles) { if
                        (file.isFile()) { String fileName=file.getName(); // Exclude logos and background images if
                        needed, but the user asked for "all images" // Filter by common image extensions String
                        lowerName=fileName.toLowerCase(); if (lowerName.endsWith(".jpg") || lowerName.endsWith(".png")
                        || lowerName.endsWith(".webp") || lowerName.endsWith(".jpeg") || lowerName.endsWith(".avif")) {
                        String title=fileName.replace("-", " " ).replace("_", " " ); // Remove extension from title int
                        lastDot=title.lastIndexOf('.'); if (lastDot> 0) title = title.substring(0, lastDot);
                        // Capitalize first letters
                        if (title.length() > 0) title = title.substring(0, 1).toUpperCase() + title.substring(1);
                        %>
                        <div class="relative rounded-xl overflow-hidden cursor-pointer group aspect-[4/3] shadow-md hover:shadow-xl transition-all duration-300"
                            onclick="openLightbox('<%= request.getContextPath() %>/images/<%= fileName %>','<%= title %>')">
                            <img src="<%= request.getContextPath() %>/images/<%= fileName %>" alt="<%= title %>"
                                class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                            <div
                                class="absolute inset-0 bg-gradient-to-t from-black/60 via-black/0 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end">
                                <p class="p-4 text-white text-sm font-bold truncate w-full">
                                    <%= title %>
                                </p>
                            </div>
                        </div>
                        <% } } } } %>
                </div>
            </div>
        </section>

        <!-- Lightbox Modal -->
        <div id="lightbox"
            class="fixed inset-0 z-[100] bg-black/95 hidden items-center justify-center p-4 backdrop-blur-sm">
            <button onclick="closeLightbox()"
                class="absolute top-6 right-6 text-white hover:text-red-500 text-4xl font-light transition-colors">&times;</button>
            <div class="max-w-5xl w-full flex flex-col items-center">
                <img id="lightbox-img" src="" alt=""
                    class="max-w-full max-h-[80vh] rounded-lg shadow-2xl object-contain animate-fade-in">
                <p id="lightbox-title" class="text-white mt-6 text-xl font-semibold tracking-wide"></p>
            </div>
        </div>

        <style>
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: scale(0.95);
                }

                to {
                    opacity: 1;
                    transform: scale(1);
                }
            }

            .animate-fade-in {
                animation: fadeIn 0.3s ease-out forwards;
            }
        </style>

        <script>
            function openLightbox(src, title) {
                const lightbox = document.getElementById('lightbox');
                const img = document.getElementById('lightbox-img');
                const imgTitle = document.getElementById('lightbox-title');
                img.src = src;
                imgTitle.textContent = title;
                lightbox.classList.remove('hidden');
                lightbox.classList.add('flex');
                document.body.style.overflow = 'hidden'; // Prevent scrolling
            }
            function closeLightbox() {
                const lightbox = document.getElementById('lightbox');
                lightbox.classList.add('hidden');
                lightbox.classList.remove('flex');
                document.body.style.overflow = ''; // Restore scrolling
            }
            // Close lightbox when clicking outside image
            document.getElementById('lightbox').addEventListener('click', function (e) {
                if (e.target.id === 'lightbox' || e.target.parentElement.id === 'lightbox') closeLightbox();
            });
        </script>

        <jsp:include page="footer.jsp" />