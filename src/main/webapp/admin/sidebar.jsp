<!-- staff/sidebar.jsp -->
<div class="flex min-h-screen">

    <!-- Sidebar -->
    <aside class="w-64 relative text-white flex flex-col shadow-lg">
        <!-- Background Image -->
        <img src="<%= request.getContextPath() %>/images/sidebar-bg.jpg"
            class="absolute inset-0 w-full h-full object-cover opacity-80" alt="Sidebar Background">
        <div class="absolute inset-0 bg-blue-700/60 backdrop-blur-sm"></div>

        <!-- Logo -->
        <div class="relative flex items-center justify-center h-20 border-b border-blue-500">
            <img src="<%= request.getContextPath() %>/images/logo2.png" alt="Ocean View Resort Logo"
                class="h-12 w-12 rounded-full object-cover mr-2 shadow-md">
            <span class="text-xl font-bold">Ocean View Resort</span>
        </div>

        <!-- Navigation Links -->
        <nav class="relative flex-1 px-4 py-6 space-y-2">
            <a href="<%= request.getContextPath() %>/admin/dashboard.jsp"
                class="flex items-center px-3 py-2 rounded-lg hover:bg-blue-500 transition">
                <i class="fas fa-tachometer-alt mr-2"></i> Dashboard
            </a>
            <a href="<%= request.getContextPath() %>/staff/manageReservation.jsp"
                class="flex items-center px-3 py-2 rounded-lg hover:bg-blue-500 transition">
                <i class="fas fa-calendar-check mr-2"></i> Manage Reservations
            </a>
            <a href="<%= request.getContextPath() %>/staff/manageEventPackages.jsp"
                class="flex items-center px-3 py-2 rounded-lg hover:bg-blue-500 transition">
                <i class="fas fa-gift mr-2"></i> Manage Event Packages
            </a>
            <a href="<%= request.getContextPath() %>/staff/manageFoodPackages.jsp"
                class="flex items-center px-3 py-2 rounded-lg hover:bg-blue-500 transition">
                <i class="fas fa-utensils mr-2"></i> Manage Food Packages
            </a>

            <!-- Manage Rooms Dropdown -->
            <div x-data="{ open: false }">
                <button @click="open = !open"
                    class="w-full flex items-center justify-between px-3 py-2 rounded-lg hover:bg-blue-500 transition focus:outline-none">
                    <span class="flex items-center">
                        <i class="fas fa-bed mr-2 w-5"></i> Manage Rooms
                    </span>
                    <i class="fas fa-chevron-down text-xs transition-transform duration-200"
                        :class="{'rotate-180': open}"></i>
                </button>
                <div x-show="open" x-collapse class="mt-1 pl-8 space-y-1">
                    <a href="<%= request.getContextPath() %>/rooms?action=addForm"
                        class="block px-3 py-2 text-sm rounded-lg hover:bg-blue-600 transition text-blue-100 hover:text-white flex items-center">
                        <i class="fas fa-plus mr-2 text-xs"></i> Add Room
                    </a>
                    <a href="<%= request.getContextPath() %>/rooms?action=list"
                        class="block px-3 py-2 text-sm rounded-lg hover:bg-blue-600 transition text-blue-100 hover:text-white flex items-center">
                        <i class="fas fa-list mr-2 text-xs"></i> All Rooms
                    </a>
                </div>
            </div>

            <a href="<%= request.getContextPath() %>/admin/viewUsers.jsp"
                class="flex items-center px-3 py-2 rounded-lg hover:bg-blue-500 transition">
                <i class="fas fa-user mr-2"></i> Manage Users
            </a>
            <a href="<%= request.getContextPath() %>/staff/paymentHistory.jsp"
                class="flex items-center px-3 py-2 rounded-lg hover:bg-blue-500 transition">
                <i class="fas fa-file-invoice-dollar mr-2"></i> Payment History
            </a>
        </nav>

        <!-- Logout Button -->
        <a href="<%= request.getContextPath() %>/login.jsp"
            class="relative flex items-center justify-center mx-4 mb-6 py-3 rounded-xl bg-red-600 hover:bg-red-700 transition text-white font-semibold shadow-lg">
            <i class="fas fa-sign-out-alt mr-3"></i> Logout
        </a>
    </aside>

    <!-- Main content area -->
    <main class="flex-1 p-6 bg-gray-50 min-h-screen">
        <!-- Staff page content goes here -->
    </main>

</div>

<!-- Tailwind, FontAwesome + Alpine.js for dropdown -->
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>