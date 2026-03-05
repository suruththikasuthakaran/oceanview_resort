<%@ page import="controller.FoodPackageController" %>
    <%@ page import="model.FoodPackage" %>
        <%@ page import="java.util.List" %>
            <%@ taglib uri="jakarta.tags.core" prefix="c" %>
                <jsp:include page="header.jsp" />

                <% /* Ensure foodList is available (fallback if accessed directly) */ List<FoodPackage> foodList = (List
                    <FoodPackage>) request.getAttribute("foodList");
                        if (foodList == null) {
                        FoodPackageController foodController = FoodPackageController.getInstance();
                        foodList = foodController.getAllFoodPackages();
                        }
                        %>

                        <!-- Hero Section -->
                        <section class="relative h-72 md:h-96 flex items-center justify-center overflow-hidden">
                            <img src="<%= request.getContextPath() %>/images/food-dinner.jpg" alt="Food"
                                class="absolute inset-0 w-full h-full object-cover">
                            <div class="absolute inset-0 bg-gradient-to-b from-black/40 to-black/20"></div>
                            <div class="relative z-10 text-center">
                                <h1 class="text-4xl md:text-5xl font-bold text-white mb-2">Food & Dining</h1>
                                <p class="text-white/80">Culinary excellence with ocean views</p>
                            </div>
                        </section>

                        <!-- Packages Section -->
                        <section class="py-20 bg-gray-50">
                            <div class="container mx-auto px-4">

                                <div class="text-center mb-16">
                                    <h2 class="text-3xl font-bold text-gray-800">Gourmet Packages</h2>
                                    <p class="text-gray-500 mt-2">Explore our curated menus prepared by master chefs</p>
                                </div>

                                <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">

                                    <c:forEach var="food" items="<%= foodList %>">
                                        <div
                                            class="bg-white rounded-2xl overflow-hidden shadow-sm hover:shadow-xl transition-all duration-300 group flex flex-col h-full border border-gray-100">
                                            <div class="relative h-64 overflow-hidden">
                                                <c:choose>
                                                    <c:when test="${not empty food.image}">
                                                        <img src="<%= request.getContextPath() %>/${food.image}"
                                                            alt="${food.name}"
                                                            class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="<%= request.getContextPath() %>/images/food-dinner.jpg"
                                                            alt="Default Food"
                                                            class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700">
                                                    </c:otherwise>
                                                </c:choose>

                                                <div
                                                    class="absolute top-4 right-4 bg-orange-600 text-white px-4 py-2 rounded-xl font-bold shadow-lg border border-orange-500/30">
                                                    $${food.price}
                                                </div>
                                            </div>

                                            <div class="p-8 flex flex-col flex-1">
                                                <h3
                                                    class="text-2xl font-bold text-gray-800 mb-3 group-hover:text-orange-600 transition-colors">
                                                    ${food.name}</h3>
                                                <p class="text-gray-500 text-sm mb-6 leading-relaxed flex-grow italic">
                                                    "${food.description}"
                                                </p>

                                                <a href="<%= request.getContextPath() %>/reservation?foodPackage=${food.name}"
                                                    class="w-full bg-orange-600 text-white text-center rounded-xl py-3.5 font-bold hover:bg-orange-700 transition-all shadow-lg shadow-orange-100 flex items-center justify-center gap-2">
                                                    <i class="fa-solid fa-calendar-check"></i> Book Now
                                                </a>
                                            </div>
                                        </div>
                                    </c:forEach>

                                </div>

                                <c:if test="${empty foodList}">
                                    <div
                                        class="text-center py-20 bg-white rounded-3xl border border-dashed border-gray-200">
                                        <i class="fa-solid fa-utensils text-gray-200 text-6xl mb-4"></i>
                                        <h3 class="text-xl font-medium text-gray-400">No food packages available at the
                                            moment.</h3>
                                    </div>
                                </c:if>

                            </div>
                        </section>

                        <jsp:include page="footer.jsp" />