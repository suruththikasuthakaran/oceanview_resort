package controller;

import model.FoodPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;

@WebServlet("/foods")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 15   // 15 MB
)
public class FoodServlet extends HttpServlet {

    private FoodPackageController foodController = FoodPackageController.getInstance();
    private static final String UPLOAD_DIR = "uploads" + File.separator + "foods";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        
        if ("list".equalsIgnoreCase(action)) {
            List<FoodPackage> foodList = foodController.getAllFoodPackages();
            request.setAttribute("foodList", foodList);
            request.getRequestDispatcher("/staff/manageFoods.jsp").forward(request, response);
            
        } else if ("search".equalsIgnoreCase(action)) {
            String query = request.getParameter("query");
            List<FoodPackage> foodList = foodController.searchFoodPackages(query);
            request.setAttribute("foodList", foodList);
            request.getRequestDispatcher("/staff/manageFoods.jsp").forward(request, response);

        } else if ("addForm".equalsIgnoreCase(action)) {
            request.getRequestDispatcher("/staff/addFood.jsp").forward(request, response);
            
        } else if ("editForm".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("packageId");
            if (idStr != null) {
                int packageId = Integer.parseInt(idStr);
                FoodPackage food = foodController.getFoodPackageById(packageId);
                request.setAttribute("food", food);
                request.getRequestDispatcher("/staff/editFood.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/foods?action=list");
            }

        } else if ("delete".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("packageId");
            if (idStr != null) {
                int packageId = Integer.parseInt(idStr);
                foodController.deleteFoodPackage(packageId);
            }
            response.sendRedirect(request.getContextPath() + "/foods?action=list");

        } else if ("customerList".equalsIgnoreCase(action)) {
            List<FoodPackage> foodList = foodController.getAllFoodPackages();
            request.setAttribute("foodList", foodList);
            request.getRequestDispatcher("/customer/food.jsp").forward(request, response);

        } else {
            response.sendRedirect(request.getContextPath() + "/staff/dashboard.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String description = request.getParameter("description");
            
            String imagePath = handleFileUpload(request);

            try {
                double price = Double.parseDouble(priceStr);
                boolean success = foodController.addFoodPackage(name, price, description, imagePath);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/foods?action=list");
                } else {
                    request.setAttribute("error", "Failed to add food package. Validation failed or database error.");
                    request.getRequestDispatcher("/staff/addFood.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid price format. Please enter a valid number.");
                request.getRequestDispatcher("/staff/addFood.jsp").forward(request, response);
            }

        } else if ("update".equalsIgnoreCase(action)) {
            String idStr = request.getParameter("packageId");
            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String description = request.getParameter("description");
            String existingImage = request.getParameter("existingImage");

            String newImagePath = handleFileUpload(request);
            String finalImagePath = (newImagePath != null && !newImagePath.isEmpty()) ? newImagePath : existingImage;

            try {
                int packageId = Integer.parseInt(idStr);
                double price = Double.parseDouble(priceStr);
                
                boolean success = foodController.updateFoodPackage(packageId, name, price, description, finalImagePath);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/foods?action=list");
                } else {
                    request.setAttribute("error", "Failed to update food package.");
                    FoodPackage food = new FoodPackage(name, price, description, finalImagePath);
                    food.setPackageId(packageId);
                    request.setAttribute("food", food);
                    request.getRequestDispatcher("/staff/editFood.jsp").forward(request, response);
                }
            } catch (Exception e) {
                request.setAttribute("error", "Error: " + e.getMessage());
                request.getRequestDispatcher("/staff/editFood.jsp").forward(request, response);
            }

        } else {
            response.sendRedirect(request.getContextPath() + "/staff/dashboard.jsp");
        }
    }

    private String handleFileUpload(HttpServletRequest request) throws ServletException, IOException {
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        try {
            Part part = request.getPart("imageFile");
            if (part != null && part.getSize() > 0) {
                String fileName = getFileName(part);
                if (fileName != null && !fileName.isEmpty()) {
                    String filePath = uploadPath + File.separator + fileName;
                    part.write(filePath);
                    return UPLOAD_DIR + "/" + fileName;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return null;
    }
}
