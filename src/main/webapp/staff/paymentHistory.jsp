<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List, model.Payment, model.User, model.Role" %>
        <% /* Staff/Admin access guard */ User currentUser=(User) session.getAttribute("currentUser"); if
            (currentUser==null || (currentUser.getRole() !=Role.STAFF && currentUser.getRole() !=Role.ADMIN)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp" ); return; } List<Payment> paymentList = (List
            <Payment>) request.getAttribute("paymentList");
                if (paymentList == null) {
                response.sendRedirect(request.getContextPath() + "/payment?action=history");
                return;
                }
                String searchQuery = (String) request.getAttribute("searchQuery");
                String searchStatus = (String) request.getAttribute("searchStatus");
                String searchStart = (String) request.getAttribute("searchStart");
                String searchEnd = (String) request.getAttribute("searchEnd");
                searchQuery = (searchQuery != null) ? searchQuery : "";
                searchStatus = (searchStatus != null) ? searchStatus : "ALL";
                searchStart = (searchStart != null) ? searchStart : "";
                searchEnd = (searchEnd != null) ? searchEnd : "";
                %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Payment History - Ocean View Resort</title>
                    <script src="https://cdn.tailwindcss.com"></script>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                </head>

                <body class="bg-gray-50">
                    <div class="flex min-h-screen">
                        <%@ include file="/staff/sidebar.jsp" %>

                            <main class="flex-1 p-6 lg:p-10">
                                <div class="max-w-7xl mx-auto">

                                    <div
                                        class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
                                        <div>
                                            <h1 class="text-3xl font-bold text-gray-800 tracking-tight">Payment History
                                            </h1>
                                            <p class="text-gray-500 text-sm mt-1">View and search all completed and
                                                pending payments</p>
                                        </div>
                                        <div
                                            class="bg-blue-600 text-white px-4 py-2 rounded-xl text-sm font-bold shadow-lg shadow-blue-200">
                                            Total: <%= paymentList.size() %>
                                        </div>
                                    </div>

                                    <!-- Search & Filters -->
                                    <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100 mb-8">
                                        <form action="<%= request.getContextPath() %>/payment" method="get"
                                            class="grid grid-cols-1 md:grid-cols-4 gap-4 items-end">
                                            <input type="hidden" name="action" value="search">

                                            <div class="space-y-2">
                                                <label
                                                    class="text-xs font-semibold text-gray-500 uppercase">Search</label>
                                                <input type="text" name="query" value="<%= searchQuery %>"
                                                    placeholder="Name, Res. No, or ID"
                                                    class="w-full px-4 py-2 rounded-lg border border-gray-200 focus:ring-2 focus:ring-blue-500 outline-none">
                                            </div>

                                            <div class="space-y-2">
                                                <label
                                                    class="text-xs font-semibold text-gray-500 uppercase">Status</label>
                                                <select name="status"
                                                    class="w-full px-4 py-2 rounded-lg border border-gray-200 focus:ring-2 focus:ring-blue-500 outline-none">
                                                    <option value="ALL" <%="ALL" .equals(searchStatus) ? "selected" : ""
                                                        %>>All Statuses</option>
                                                    <option value="SUCCESS" <%="SUCCESS" .equals(searchStatus)
                                                        ? "selected" : "" %>>SUCCESS</option>
                                                    <option value="PENDING" <%="PENDING" .equals(searchStatus)
                                                        ? "selected" : "" %>>PENDING</option>
                                                    <option value="FAILED" <%="FAILED" .equals(searchStatus)
                                                        ? "selected" : "" %>>FAILED</option>
                                                </select>
                                            </div>

                                            <div class="space-y-2">
                                                <label class="text-xs font-semibold text-gray-500 uppercase">Date
                                                    From</label>
                                                <input type="date" name="checkIn" value="<%= searchStart %>"
                                                    class="w-full px-4 py-2 rounded-lg border border-gray-200 focus:ring-2 focus:ring-blue-500 outline-none">
                                            </div>

                                            <div class="space-y-2">
                                                <label class="text-xs font-semibold text-gray-500 uppercase">Date
                                                    To</label>
                                                <input type="date" name="checkOut" value="<%= searchEnd %>"
                                                    class="w-full px-4 py-2 rounded-lg border border-gray-200 focus:ring-2 focus:ring-blue-500 outline-none">
                                            </div>

                                            <div class="md:col-span-4 flex justify-end gap-3 mt-2">
                                                <% if (!searchQuery.isEmpty() || !"ALL".equals(searchStatus) ||
                                                    !searchStart.isEmpty() || !searchEnd.isEmpty()) { %>
                                                    <a href="<%= request.getContextPath() %>/payment?action=history"
                                                        class="px-6 py-2 text-gray-500 hover:text-gray-700 font-medium">Clear
                                                        All</a>
                                                    <% } %>
                                                        <button type="submit"
                                                            class="bg-blue-600 text-white px-8 py-2 rounded-lg font-bold hover:bg-blue-700 transition shadow-lg shadow-blue-200">
                                                            <i class="fas fa-filter mr-2"></i>Apply Filters
                                                        </button>
                                            </div>
                                        </form>
                                    </div>

                                    <!-- Payments Table -->
                                    <div class="bg-white shadow-xl rounded-2xl overflow-hidden border border-gray-100">
                                        <div class="overflow-x-auto">
                                            <table class="min-w-full divide-y divide-gray-200">
                                                <thead class="bg-gray-50">
                                                    <tr>
                                                        <th
                                                            class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                            Payment ID</th>
                                                        <th
                                                            class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                            Guest & Res. No</th>
                                                        <th
                                                            class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                            Method</th>
                                                        <th
                                                            class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                            Amount</th>
                                                        <th
                                                            class="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                            Date</th>
                                                        <th
                                                            class="px-6 py-4 text-center text-xs font-bold text-gray-500 uppercase tracking-wider">
                                                            Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="bg-white divide-y divide-gray-100">
                                                    <% if (paymentList.isEmpty()) { %>
                                                        <tr>
                                                            <td colspan="6"
                                                                class="px-6 py-12 text-center text-gray-400">
                                                                <div class="text-5xl mb-3 opacity-30"><i
                                                                        class="fas fa-receipt"></i></div>
                                                                No payment records found.
                                                            </td>
                                                        </tr>
                                                        <% } else { for (Payment p : paymentList) { String
                                                            sName=(p.getStatus() !=null) ? p.getStatus().name()
                                                            : "PENDING" ; String sClass="bg-yellow-100 text-yellow-700"
                                                            ; if ("SUCCESS".equals(sName))
                                                            sClass="bg-green-100 text-green-700" ; else if
                                                            ("FAILED".equals(sName)) sClass="bg-red-100 text-red-700" ;
                                                            %>
                                                            <tr class="hover:bg-gray-50/80 transition-colors">
                                                                <td class="px-6 py-4 text-sm font-medium text-gray-900">
                                                                    #PAY-<%= p.getPaymentId() %>
                                                                </td>
                                                                <td class="px-6 py-4">
                                                                    <% if (p.getReservation() !=null) { %>
                                                                        <div class="text-sm font-bold text-gray-800">
                                                                            <%= p.getReservation().getFullName() %>
                                                                        </div>
                                                                        <div class="text-xs text-blue-600 font-medium">
                                                                            <%= p.getReservation().getReservationNo() %>
                                                                        </div>
                                                                        <% } else { %>
                                                                            <div class="text-sm text-gray-400 italic">
                                                                                N/A</div>
                                                                            <% } %>
                                                                </td>
                                                                <td class="px-6 py-4">
                                                                    <span
                                                                        class="text-xs font-bold text-gray-500 bg-gray-100 px-2 py-1 rounded">
                                                                        <%= p.getPaymentMethod() %>
                                                                    </span>
                                                                </td>
                                                                <td class="px-6 py-4 text-sm font-bold text-green-600">
                                                                    $<%= String.format("%.2f", p.getAmount()) %>
                                                                </td>
                                                                <td class="px-6 py-4 text-xs text-gray-500">
                                                                    <%= p.getPaymentDate() %>
                                                                </td>
                                                                <td class="px-6 py-4 text-center">
                                                                    <span
                                                                        class="px-3 py-1 rounded-full text-[10px] font-bold uppercase <%= sClass %>">
                                                                        <%= sName %>
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                            <% }} %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </main>
                    </div>
                </body>

                </html>