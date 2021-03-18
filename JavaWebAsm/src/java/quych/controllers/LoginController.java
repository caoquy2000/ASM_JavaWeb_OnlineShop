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
import javax.servlet.http.Cookie;
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
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {
   
    private final static String FAILED = "login-page.jsp";
    private final static String SUCCESS = "LoadDataController";
    private final static String ADMIN = "StatictisController";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = FAILED;
        try {
            String username = request.getParameter("txtUsername");
            String password = request.getParameter("txtPassword");
            UserDAO dao = new UserDAO();
            UserDTO dto = dao.getAnUser(username, password);
            String role = dao.getRoleName(dto.getRoleID());
            if (role != null) {
                if (role.equals("admin")) {
                    url = ADMIN;
       
                    HttpSession session = request.getSession();
                    session.setAttribute("USERNAME", username);
                } else if (role.equals("customer")) {
                    url = SUCCESS;
                    HttpSession session = request.getSession();
                    session.setAttribute("USERNAME", username);
                }
            } else {
                request.setAttribute("INVAID", "Error Username or Password");
            }
        } catch (Exception e) {
            log("ERROR at LoginController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
