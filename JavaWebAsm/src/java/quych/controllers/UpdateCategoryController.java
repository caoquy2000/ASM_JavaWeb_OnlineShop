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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import quych.dtos.CategoryDTO;
import quych.models.CategoryDAO;

/**
 *
 * @author caoho
 */
@WebServlet(name = "UpdateCategoryController", urlPatterns = {"/UpdateCategoryController"})
public class UpdateCategoryController extends HttpServlet {

    private static final String FAILED = "admin-addcategory.jsp";
    private static final String SUCCESS = "admin-category-page.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = FAILED;
        String categoryID;
        String categoryName;
        String urlImg;
        String txtStatus;
        CategoryDAO dao = new CategoryDAO();
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
                            //neu nguoi dung ko nhap file moi vao thi se goi db de lay lai file cu~
                            //khi nao nguoi dung them 1 hinh moi vao thi moi luu hinh
            
                            if (fileName.isEmpty()) {

                            } else {
                                String RealPath = getServletContext().getRealPath("/") + "img\\danhmuc\\" + fileName;
                                File saveFile = new File(RealPath);
                                item.write(saveFile);
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
                categoryID = (String) params.get("txtCategoryID");
                categoryName = (String) params.get("txtCategoryName");
                if (fileName.isEmpty()) {
                    urlImg = dao.getImgByID(categoryID);
                } else {
                    urlImg = fileName;
                }
                txtStatus = (String) params.get("txtStatus");
                int status = 0;
                if (txtStatus.equals("active")) {
                    status = 1;
                }
                CategoryDTO dto = new CategoryDTO(categoryID, categoryName, urlImg, status);

                boolean checkUpdate = dao.updateCategory(dto);
                if (checkUpdate) {
                    url = SUCCESS;
                    request.setAttribute("SUCCESS", "CATEGORY UPDATE SUCCESS!");
                } else {
                    request.setAttribute("FAILED", "UPDATE CATEGORY FAILED");
                }
            }
        } catch (Exception e) {
            log("ERROR at UpdateCategoryController: " + e.getMessage());
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
