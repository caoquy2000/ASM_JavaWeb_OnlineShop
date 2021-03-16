/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quych.controllers;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import quych.dtos.CategoryDTO;
import quych.models.CategoryDAO;

/**
 *
 * @author caoho
 */
@WebServlet(name = "CreateCategoryController", urlPatterns = {"/CreateCategoryController"})
public class CreateCategoryController extends HttpServlet {

    private static final String SUCCESS = "admin-category-page.jsp";
    private static final String FAILED = "admin-addcategory.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
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
                            String RealPath = getServletContext().getRealPath("/") + "img\\danhmuc\\" + fileName;
                            File saveFile = new File(RealPath);
                            item.write(saveFile);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
                String categoryID = (String) params.get("txtCategoryID");
                String categoryName = (String) params.get("txtCategoryName");
                String urlImg = fileName;
                String txtStatus = (String) params.get("txtStatus");
                int status = 0;
                if (txtStatus.equals("active")) 
                    status = 1;
                CategoryDTO dto = new CategoryDTO(categoryID, categoryName, urlImg, status);
                CategoryDAO dao = new CategoryDAO();
                boolean checkInsert = dao.insertCategory(dto);
                if (checkInsert) {
                    url = SUCCESS;
                    request.setAttribute("SUCCESS", "CATEGORY ADDED!");
                } else {
                    request.setAttribute("FAILED", "ADD CATEGORY FAILED");
                }
            }

        } catch (Exception e) {
            log("ERROR at CreateCategoryController: " + e.getMessage());
        } finally {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("USERNAME");
            if (username == null) {
                response.sendRedirect("login-page.jsp");
            } else {
                if (!username.equals("admin")) {
                    response.sendRedirect("LoadDataController");
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

    //file name of the upload file is included in content-dispostion header like this:
    //form-data; name = "dataFile"; filename = "XXX.JPG"
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
