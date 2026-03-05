<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking Successful - Ocean View Resort</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
        <style>
            body {
                font-family: 'Outfit', sans-serif;
            }
        </style>
    </head>

    <body
        class="bg-gray-50 flex items-center justify-center min-h-screen p-4 bg-[url('${pageContext.request.contextPath}/images/bg-pattern.png')] bg-fixed">

        <div
            class="max-w-md w-full bg-white rounded-[2.5rem] p-12 shadow-2xl shadow-purple-200/50 text-center border border-purple-50">
            <div
                class="w-24 h-24 bg-green-100 text-green-600 rounded-full flex items-center justify-center mx-auto mb-8 animate-bounce">
                <i class="fa-solid fa-check text-4xl"></i>
            </div>

            <h1 class="text-3xl font-extrabold text-gray-900 mb-4">Request Received!</h1>
            <p class="text-gray-500 mb-10 leading-relaxed">
                Thank you for choosing Ocean View Resort. Your event reservation request has been submitted
                successfully.
                Our planning team will contact you within 24 hours to finalize the details.
            </p>

            <div class="space-y-4">
                <a href="${pageContext.request.contextPath}/customer/events.jsp"
                    class="block w-full bg-gradient-to-r from-purple-600 to-blue-600 text-white font-bold py-4 rounded-2xl shadow-lg shadow-purple-200 hover:opacity-90 transition-all">
                    Browse More Events
                </a>
                <a href="${pageContext.request.contextPath}/index.jsp"
                    class="block w-full bg-gray-100 text-gray-600 font-bold py-4 rounded-2xl hover:bg-gray-200 transition-all">
                    Return Home
                </a>
            </div>

            <div class="mt-12 pt-8 border-t border-gray-100">
                <p class="text-sm text-gray-400">Questions? Call us at <span class="font-bold text-gray-600">+94 91 234
                        5678</span></p>
            </div>
        </div>

    </body>

    </html>