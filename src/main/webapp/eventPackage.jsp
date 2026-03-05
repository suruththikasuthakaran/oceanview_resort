<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.EventPackageController, model.EventPackage, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Event Packages</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }
        .container {
            width: 80%;
            margin: 40px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #333;
        }
        .event-package {
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .event-info {
            flex: 1;
        }
        .event-info p {
            margin: 5px 0;
        }
        .total {
            font-size: 18px;
            margin-top: 20px;
            font-weight: bold;
        }
        .btn-submit {
            background-color: #007bff;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            float: right;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Select Event Packages (Optional)</h2>

    <form action="ReservationPage.jsp" method="post" id="eventForm">
        <%
            EventPackageController controller = EventPackageController.getInstance();
            List<EventPackage> events = controller.getAllEventPackages();

            if (events != null && !events.isEmpty()) {
                for (EventPackage event : events) {
        %>
        <div class="event-package">
            <div class="event-info">
                <p><strong><%= event.getName() %></strong></p>
                <p>Price: $<span class="price"><%= event.getPrice() %></span></p>
                <p>Description: <%= event.getDescription() %></p>
            </div>
            <div>
                <input type="checkbox" name="selectedEvents" value="<%= event.getEventId() %>" data-price="<%= event.getPrice() %>" onchange="updateTotal()">
            </div>
        </div>
        <%
                }
            } else {
        %>
        <p>No event packages available.</p>
        <%
            }
        %>

        <div class="total">
            Total Event Price: $<span id="totalPrice">0</span>
        </div>

        <button type="submit" class="btn-submit">Continue to Reservation</button>
    </form>
</div>

<script>
    function updateTotal() {
        let checkboxes = document.querySelectorAll('input[name="selectedEvents"]:checked');
        let total = 0;
        checkboxes.forEach(function(cb){
            total += parseFloat(cb.getAttribute('data-price'));
        });
        document.getElementById('totalPrice').innerText = total.toFixed(2);
    }
</script>
</body>
</html>