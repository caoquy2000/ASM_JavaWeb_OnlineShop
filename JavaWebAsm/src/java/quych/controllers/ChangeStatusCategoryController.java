/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quych.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import quych.models.CategoryDAO;
import quych.models.ProductDAO;

/**
 *
 * @author caoho
 */
@WebServlet(name = "ChangeStatusCategoryController", urlPatterns = {"/ChangeStatusCategoryController"})
public class ChangeStatusCategoryController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "ManageCategoryController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR;
        try {
            String id = request.getParameter("id");
            int status = Integer.parseInt(request.getParameter("status"));
            CategoryDAO dao = new CategoryDAO();
            
            if (dao.changStatus(status, id)) {             
                url = SUCCESS;
            } else {
                request.setAttribute("INVALID", "CHANGE FAILED");
            }
        } catch (Exception e) {
            log("ERROR at ChangeStatusCategoryController: " + e.getMessage());
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
    }// </editor-fold>

}
