<%@ page contentType="text/html;charset=UTF-8" %>
       <%@ page import="model.RoomsType" %>
              <%@ page import="service.RoomsService" %>
                     <%@ taglib uri="jakarta.tags.core" prefix="c" %>
                            <!DOCTYPE html>
                            <html lang="en">

                            <head>
                                   <meta charset="UTF-8">
                                   <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                   <title>Add Room - Ocean View Resort</title>
                                   <script src="https://cdn.tailwindcss.com"></script>
                                   <link rel="stylesheet"
                                          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
                                   <style>
                                          .bg-ocean {
                                                 background: linear-gradient(135deg, #0ea5e9, #0284c7);
                                          }
                                   </style>
                            </head>

                            <body class="bg-gray-50 flex min-h-screen text-gray-800 font-sans">

                                   <%@ include file="/staff/sidebar.jsp" %>

                                          <main
                                                 class="flex-1 p-8 transition-all duration-300 flex flex-col items-center">
                                                 <div
                                                        class="max-w-5xl w-full bg-white rounded-2xl shadow-xl overflow-hidden border border-gray-100">
                                                        <div class="bg-ocean p-8 text-white">
                                                               <div class="flex items-center justify-center gap-4">
                                                                      <div
                                                                             class="w-12 h-12 bg-white/20 rounded-lg flex items-center justify-center backdrop-blur-sm">
                                                                             <i class="fa-solid fa-plus text-2xl"></i>
                                                                      </div>
                                                                      <div>
                                                                             <h2
                                                                                    class="text-3xl font-bold tracking-tight">
                                                                                    Add New Room</h2>
                                                                             <p class="text-sky-100 mt-1">Configure a
                                                                                    new luxury space for your guests.
                                                                             </p>
                                                                      </div>
                                                               </div>
                                                        </div>

                                                        <div class="p-10">
                                                               <c:if test="${not empty errorMessage}">
                                                                      <div class="bg-red-50 border-l-4 border-red-500 text-red-700 p-4 rounded-lg mb-8 flex items-center gap-3 animate-pulse"
                                                                             role="alert">
                                                                             <i
                                                                                    class="fa-solid fa-circle-exclamation text-xl"></i>
                                                                             <span
                                                                                    class="font-medium">${errorMessage}</span>
                                                                      </div>
                                                               </c:if>

                                                               <% RoomsService roomsService=RoomsService.getInstance();
                                                                      String latest=roomsService.getLatestRoomNumber();
                                                                      String nextNum="101" ; try {
                                                                      nextNum=String.valueOf(Integer.parseInt(latest) +
                                                                      1); } catch (Exception e) {} %>

                                                                      <form action="${pageContext.request.contextPath}/rooms"
                                                                             method="post" enctype="multipart/form-data"
                                                                             class="space-y-10">
                                                                             <input type="hidden" name="action"
                                                                                    value="add" />

                                                                             <div
                                                                                    class="grid grid-cols-1 lg:grid-cols-2 gap-12">
                                                                                    <!-- Left Column: Basic Info -->
                                                                                    <div class="space-y-8">
                                                                                           <h3
                                                                                                  class="text-xl font-bold text-gray-800 border-b pb-2 flex items-center gap-2">
                                                                                                  <i
                                                                                                         class="fa-solid fa-info-circle text-sky-600"></i>
                                                                                                  Basic Information
                                                                                           </h3>

                                                                                           <div
                                                                                                  class="grid grid-cols-2 gap-6">
                                                                                                  <div>
                                                                                                         <label
                                                                                                                class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">Room
                                                                                                                Number</label>
                                                                                                         <input name="roomNumber"
                                                                                                                required
                                                                                                                type="text"
                                                                                                                value="<%= nextNum %>"
                                                                                                                placeholder="e.g., 101"
                                                                                                                class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-sky-500 focus:border-transparent outline-none transition-all shadow-sm bg-gray-50 focus:bg-white" />
                                                                                                  </div>
                                                                                                  <div>
                                                                                                         <label
                                                                                                                class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">Room
                                                                                                                Type</label>
                                                                                                         <div
                                                                                                                class="relative">
                                                                                                                <select name="roomType"
                                                                                                                       required
                                                                                                                       class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-sky-500 focus:border-transparent outline-none transition-all shadow-sm bg-gray-50 focus:bg-white appearance-none">
                                                                                                                       <% for(RoomsType
                                                                                                                              type
                                                                                                                              :
                                                                                                                              RoomsType.values())
                                                                                                                              {
                                                                                                                              %>
                                                                                                                              <option
                                                                                                                                     value="<%= type.name() %>">
                                                                                                                                     <%= type.name()
                                                                                                                                            %>
                                                                                                                              </option>
                                                                                                                              <% }
                                                                                                                                     %>
                                                                                                                </select>
                                                                                                                <div
                                                                                                                       class="absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none text-gray-400">
                                                                                                                       <i
                                                                                                                              class="fa-solid fa-chevron-down text-xs"></i>
                                                                                                                </div>
                                                                                                         </div>
                                                                                                  </div>
                                                                                           </div>

                                                                                           <div
                                                                                                  class="grid grid-cols-2 gap-6">
                                                                                                  <div>
                                                                                                         <label
                                                                                                                class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">Price
                                                                                                                / Night
                                                                                                                ($)</label>
                                                                                                         <div
                                                                                                                class="relative">
                                                                                                                <span
                                                                                                                       class="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400">$</span>
                                                                                                                <input type="number"
                                                                                                                       step="0.01"
                                                                                                                       name="price"
                                                                                                                       required
                                                                                                                       min="0"
                                                                                                                       placeholder="0.00"
                                                                                                                       class="w-full pl-8 pr-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-sky-500 focus:border-transparent outline-none transition-all shadow-sm bg-gray-50 focus:bg-white" />
                                                                                                         </div>
                                                                                                  </div>
                                                                                                  <div>
                                                                                                         <label
                                                                                                                class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">Capacity</label>
                                                                                                         <div
                                                                                                                class="relative">
                                                                                                                <span
                                                                                                                       class="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400">
                                                                                                                       <i
                                                                                                                              class="fa-solid fa-users text-xs"></i>
                                                                                                                </span>
                                                                                                                <input type="number"
                                                                                                                       name="capacity"
                                                                                                                       required
                                                                                                                       min="1"
                                                                                                                       placeholder="2"
                                                                                                                       class="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-sky-500 focus:border-transparent outline-none transition-all shadow-sm bg-gray-50 focus:bg-white" />
                                                                                                         </div>
                                                                                                  </div>
                                                                                           </div>

                                                                                           <div>
                                                                                                  <label
                                                                                                         class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">Bed
                                                                                                         Configuration</label>
                                                                                                  <input name="bedType"
                                                                                                         required
                                                                                                         type="text"
                                                                                                         placeholder="e.g., King Size, 2 Queens"
                                                                                                         class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-sky-500 focus:border-transparent outline-none transition-all shadow-sm bg-gray-50 focus:bg-white" />
                                                                                           </div>

                                                                                           <div>
                                                                                                  <label
                                                                                                         class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">Current
                                                                                                         Status</label>
                                                                                                  <div class="relative">
                                                                                                         <select name="status"
                                                                                                                class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-sky-500 focus:border-transparent outline-none transition-all shadow-sm bg-gray-50 focus:bg-white appearance-none">
                                                                                                                <option value="AVAILABLE"
                                                                                                                       class="text-green-600 font-medium">
                                                                                                                       Available
                                                                                                                </option>
                                                                                                                <option value="BOOKED"
                                                                                                                       class="text-blue-600 font-medium">
                                                                                                                       Booked
                                                                                                                </option>
                                                                                                                <option value="MAINTENANCE"
                                                                                                                       class="text-red-600 font-medium">
                                                                                                                       Maintenance
                                                                                                                </option>
                                                                                                         </select>
                                                                                                         <div
                                                                                                                class="absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none text-gray-400">
                                                                                                                <i
                                                                                                                       class="fa-solid fa-chevron-down text-xs"></i>
                                                                                                         </div>
                                                                                                  </div>
                                                                                           </div>
                                                                                    </div>

                                                                                    <!-- Right Column: Media and Description -->
                                                                                    <div class="space-y-8">
                                                                                           <h3
                                                                                                  class="text-xl font-bold text-gray-800 border-b pb-2 flex items-center gap-2">
                                                                                                  <i
                                                                                                         class="fa-solid fa-camera text-sky-600"></i>
                                                                                                  Media & Details
                                                                                           </h3>

                                                                                           <div>
                                                                                                  <label
                                                                                                         class="block text-sm font-bold text-gray-700 mb-3 uppercase tracking-wide">Room
                                                                                                         Image
                                                                                                         Asset</label>
                                                                                                  <label for="imageFile"
                                                                                                         class="group relative flex flex-col items-center justify-center w-full h-56 border-2 border-gray-200 border-dashed rounded-2xl cursor-pointer bg-gray-50 hover:bg-sky-50 hover:border-sky-400 transition-all focus-within:ring-2 focus-within:ring-sky-500">
                                                                                                         <div
                                                                                                                class="flex flex-col items-center justify-center pt-5 pb-6">
                                                                                                                <div
                                                                                                                       class="w-16 h-16 bg-white rounded-full shadow-sm flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
                                                                                                                       <i
                                                                                                                              class="fa-solid fa-cloud-arrow-up text-3xl text-sky-600"></i>
                                                                                                                </div>
                                                                                                                <p
                                                                                                                       class="mb-2 text-sm text-gray-700 font-semibold">
                                                                                                                       <span
                                                                                                                              class="text-sky-600">Click
                                                                                                                              to
                                                                                                                              upload</span>
                                                                                                                       or
                                                                                                                       drag
                                                                                                                       and
                                                                                                                       drop
                                                                                                                </p>
                                                                                                                <p
                                                                                                                       class="text-xs text-gray-500">
                                                                                                                       Professional
                                                                                                                       room
                                                                                                                       photos
                                                                                                                       (PNG,
                                                                                                                       JPG,
                                                                                                                       max
                                                                                                                       10MB)
                                                                                                                </p>
                                                                                                         </div>
                                                                                                         <input id="imageFile"
                                                                                                                name="imageFile"
                                                                                                                type="file"
                                                                                                                class="sr-only"
                                                                                                                accept="image/*"
                                                                                                                onchange="previewImage(this)">
                                                                                                         <div id="imagePreview"
                                                                                                                class="absolute inset-0 hidden rounded-2xl overflow-hidden pointer-events-none">
                                                                                                                <img src=""
                                                                                                                       class="w-full h-full object-cover">
                                                                                                                <div
                                                                                                                       class="absolute inset-0 bg-black/20 flex items-center justify-center opacity-0 hover:opacity-100 transition-opacity">
                                                                                                                       <p
                                                                                                                              class="text-white text-sm font-bold">
                                                                                                                              Change
                                                                                                                              Image
                                                                                                                       </p>
                                                                                                                </div>
                                                                                                         </div>
                                                                                                  </label>
                                                                                           </div>

                                                                                           <div>
                                                                                                  <label
                                                                                                         class="block text-sm font-bold text-gray-700 mb-2 uppercase tracking-wide">Detailed
                                                                                                         Description</label>
                                                                                                  <textarea
                                                                                                         name="description"
                                                                                                         rows="6"
                                                                                                         placeholder="Describe the view, special features, and premium amenities..."
                                                                                                         class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-sky-500 focus:border-transparent outline-none transition-all shadow-sm bg-gray-50 focus:bg-white resize-none"></textarea>
                                                                                           </div>
                                                                                    </div>
                                                                             </div>

                                                                             <div
                                                                                    class="flex justify-end gap-5 pt-10 border-t border-gray-100">
                                                                                    <a href="${pageContext.request.contextPath}/rooms?action=list"
                                                                                           class="px-8 py-3.5 rounded-xl border border-gray-200 text-gray-600 hover:bg-gray-50 hover:text-gray-900 transition-all font-bold tracking-wide">
                                                                                           Discard Changes
                                                                                    </a>
                                                                                    <button type="submit"
                                                                                           class="px-12 py-3.5 rounded-xl bg-sky-600 text-white hover:bg-sky-700 focus:outline-none focus:ring-4 focus:ring-sky-200 transition-all shadow-lg shadow-sky-100 font-bold tracking-tight flex items-center gap-2">
                                                                                           <i
                                                                                                  class="fa-solid fa-save"></i>
                                                                                           Register Room
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
                            </body>

                            </html>