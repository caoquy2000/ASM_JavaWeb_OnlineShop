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
import quych.dtos.UserDTO;
import quych.models.UserDAO;

/**
 *
 * @author caoho
 */
@WebServlet(name = "CreateAccountController", urlPatterns = {"/CreateAccountController"})
public class CreateAccountController extends HttpServlet {

    private static final String SUCCESS = "login-page.jsp";
    private static final String FAILED = "signup-page.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = FAILED;
        try {
            String username = request.getParameter("txtUsername");
            String password = request.getParameter("txtPassword");
            String fullname = request.getParameter("txtFullname");
            UserDTO dto = new UserDTO(username, password, fullname, "R002");
            UserDAO dao = new UserDAO();
            if (dao.createNewUser(dto)) {
                url = SUCCESS;
                request.setAttribute("USERNAME", username);
                request.setAttribute("PASSWORD", password);
            }
        } catch (Exception e) {
            log("ERROR at CreateAccountController: " + e.getMessage());
            if (e.getMessage().contains("duplicate")) {
                url = FAILED;
                request.setAttribute("INVALID", "Username is exist");
            }
        } finally {
            HttpSession session = request.getSession();
            String user = (String) session.getAttribute("USERNAME");
            if (user == null) {
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                if (user.equals("admin")) {
                    response.sendRedirect("admin-product-page.jsp");
                } else {
                    response.sendRedirect("home-page.jsp");
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
