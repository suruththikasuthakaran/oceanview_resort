<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.FoodPackage" %>

<%
    // STAFF LOGIN CHECK
    if(session.getAttribute("user") == null ||
       !"staff".equals(session.getAttribute("role"))){
        response.sendRedirect("../login.jsp");
        return;
    }

    List<FoodPackage> foodList =
        (List<FoodPackage>) request.getAttribute("foodList");

    String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Staff - Food Package Management</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #00c6ff, #0072ff);
        }

        .card-box {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0px 15px 40px rgba(0,0,0,0.2);
            margin-top: 40px;
        }

        .btn-primary {
            background-color: #0072ff;
            border: none;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        .btn-warning {
            background-color: #ffc107;
            border: none;
        }

        .table th {
            background-color: #0072ff;
            color: white;
        }
    </style>
</head>

<body>

<div class="container">
    <div class="card-box">

        <h2 class="text-center mb-4">Food Package Management</h2>

        <% if(message != null){ %>
            <div class="alert alert-success">
                <%= message %>
            </div>
        <% } %>

        <!-- ================= ADD FOOD PACKAGE ================= -->
        <h4>Add New Package</h4>

        <form action="../foodPackage" method="post" class="row g-3 mb-4">

            <input type="hidden" name="action" value="add">

            <div class="col-md-4">
                <input type="text" name="name"
                       class="form-control" placeholder="Package Name" required>
            </div>

            <div class="col-md-3">
                <input type="number" step="0.01" name="price"
                       class="form-control" placeholder="Price" required>
            </div>

            <div class="col-md-4">
                <input type="text" name="description"
                       class="form-control" placeholder="Description" required>
            </div>

            <div class="col-md-1">
                <button type="submit" class="btn btn-primary w-100">
                    Add
                </button>
            </div>
        </form>

        <!-- ================= SEARCH ================= -->
        <form action="../foodPackage" method="get" class="row mb-3">

            <div class="col-md-10">
                <input type="text" name="search"
                       class="form-control"
                       placeholder="Search by package name">
            </div>

            <div class="col-md-2">
                <button type="submit"
                        class="btn btn-primary w-100">
                    Search
                </button>
            </div>
        </form>

        <!-- ================= PACKAGE TABLE ================= -->
        <table class="table table-bordered table-hover text-center">

            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Price ($)</th>
                <th>Description</th>
                <th width="200">Actions</th>
            </tr>
            </thead>

            <tbody>
            <% if(foodList != null && !foodList.isEmpty()){
                for(FoodPackage f : foodList){ %>

                <tr>
                    <form action="../foodPackage" method="post">
                        <td>
                            <%= f.getPackageId() %>
                            <input type="hidden" name="id"
                                   value="<%= f.getPackageId() %>">
                        </td>

                        <td>
                            <input type="text" name="name"
                                   value="<%= f.getName() %>"
                                   class="form-control">
                        </td>

                        <td>
                            <input type="number" step="0.01"
                                   name="price"
                                   value="<%= f.getPrice() %>"
                                   class="form-control">
                        </td>

                        <td>
                            <input type="text" name="description"
                                   value="<%= f.getDescription() %>"
                                   class="form-control">
                        </td>

                        <td>
                            <button type="submit"
                                    name="action"
                                    value="update"
                                    class="btn btn-warning btn-sm">
                                Update
                            </button>

                            <button type="submit"
                                    name="action"
                                    value="delete"
                                    class="btn btn-danger btn-sm"
                                    onclick="return confirm('Delete this package?')">
                                Delete
                            </button>
                        </td>
                    </form>
                </tr>

            <% }} else { %>
                <tr>
                    <td colspan="5">No Food Packages Found</td>
                </tr>
            <% } %>
            </tbody>
        </table>

        <!-- ================= PAGINATION ================= -->
        <div class="text-center mt-3">
            <a href="../foodPackage?page=1"
               class="btn btn-outline-primary btn-sm">1</a>

            <a href="../foodPackage?page=2"
               class="btn btn-outline-primary btn-sm">2</a>

            <a href="../foodPackage?page=3"
               class="btn btn-outline-primary btn-sm">3</a>
        </div>

    </div>
</div>

</body>
</html>