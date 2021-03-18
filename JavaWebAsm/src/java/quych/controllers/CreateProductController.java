package quych.controllers;

import java.io.File;
import java.io.IOException;

import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import quych.dtos.ProductDTO;
import quych.models.ProductDAO;

@WebServlet(name = "CreateProductController", urlPatterns = {"/CreateProductController"})
public class CreateProductController extends HttpServlet {

    private static final String SUCCESS = "admin-product-page.jsp";
    private static final String FAILED = "admin-addproduct.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         response.setContentType("text/html;charset=UTF-8");
        String url = FAILED;

        try {
            boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
            if (!isMultiPart) {

            } else {
                List items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                Iterator iter = items.iterator();
                Hashtable params = new Hashtable();
                String fileName = null;
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.isFormField()) {

                        params.put(item.getFieldName(), item.getString("utf-8"));
                    } else {

                        try {

                            String itemName = item.getName();
                            fileName = itemName;
                            String RealPath = getServletContext().getRealPath("/") + "img\\sanpham\\" + fileName;
                            File saveFile = new File(RealPath);
                            item.write(saveFile);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }

                String productID = (String) params.get("txtProductID");
                String productName = (String) params.get("txtProductName");
                float price = Float.parseFloat((String) params.get("txtProductPrice"));
                int quantity = Integer.parseInt((String) params.get("txtProductQuantity"));
                String description = (String) params.get("txtDescription");
                int status = Integer.parseInt((String) params.get("txtStatusProduct"));
                String urlImg = fileName;
                String categoryID = (String) params.get("txtCategoryName");
                ProductDAO dao = new ProductDAO();

                ProductDTO dto = new ProductDTO(productID, productName, price, quantity, description, status, urlImg, categoryID);
                if (dao.insertProduct(dto)) {
                    url = SUCCESS;
//                    request.setAttribute("SUCCESS", "CATEGORY ADDED!");
                    request.setAttribute("ADDPRODUCTSUCCESS", "Add category success");
                } else {
                    request.setAttribute("FAILED", "ADD CATEGORY FAILED");
                }

            }

        } catch (Exception e) {
            log("ERROR at CreateProductController: " + e.getMessage());
        } finally {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("USERNAME");
            if (username == null) {
//                response.sendRedirect("login-page.jsp");
                request.getRequestDispatcher("login-page.jsp").forward(request, response);
            } else {
                if (!username.equals("admin")) {
//                    response.sendRedirect("LoadDataController");
                    request.getRequestDispatcher("LoadDataController").forward(request, response);
                } else {
                    request.getRequestDispatcher(url).forward(request, response);
                }
            }
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
