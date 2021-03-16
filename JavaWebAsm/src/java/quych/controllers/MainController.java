/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quych.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class MainController extends HttpServlet {
    
    
    private static final String LOAD = "LoadDataController";
    private static final String LOGIN = "LoginController";
    private static final String ERROR = "404.jsp";
    private static final String CHANGESTATUSPRODUCT = "ChangeStatusProductController";
    private static final String CHANGESTATUSCATEGORY = "ChangeStatusCategoryController";
    private static final String ADDCATEGORY = "CreateCategoryController";
    private static final String LOGOUT = "LogoutController";
    private static final String LOADADDPRODUCT = "LoadAddProductController";
    private static final String ADDPRODUCT = "CreateProductController";
    private static final String EDITCATEGORY = "EditCategoryController";
    private static final String UPDATECATEGORY = "UpdateCategoryController";
    private static final String EDITPRODUCT = "EditProductController";
    private static final String UPDATEPRODUCT = "UpdateProductController";
    private static final String SEARCHPRODUCT = "SearchProductController";
    private static final String SEARCHCATEGORY = "SearchCategoryController";
    private static final String SIGNUPPAGE = "signup-page.jsp";
    private static final String LOGINPAGE = "login-page.jsp";
    private static final String CREATEACCOUNT = "CreateAccountController";
    private static final String ADDTOCART = "AddToCartController";
    private static final String VIEWSHOPPINGCART = "shoppingcart-page.jsp";
    private static final String REMOVECART = "RemoveCartController";
    private static final String ORDER = "OrderController";
    private static final String HISTORYORDER = "LoadHistoryController";
    private static final String MANAGEORDER = "LoadOrderController";
    private static final String CHANGESTATUSORDER = "ChangeStatusOrderController";
    private static final String LOADMYORDER = "LoadUserOrderController";
    private static final String CANCELORDER = "CancelOrderController";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String url = ERROR;
        try {
            String action = request.getParameter("action");
            if (action == null ){
                url = LOAD;
            } else if (action.equals("CancelOrder")) {
                url = CANCELORDER;
            } else if (action.equals("LoadMyOrder")) {
                url = LOADMYORDER;
            } else if (action.equals("ConfirmOrder")) {
                url = CHANGESTATUSORDER;
            } else if (action.equals("ManageOrderPage")) {
                url = MANAGEORDER;
            } else if(action.equals("HistoryPage")) {
                url = HISTORYORDER;
            } else if (action.equals("Order")) {
                url = ORDER;
            } else if (action.equals("RemoveAProductInCart")) {
                url = REMOVECART;
            } else if (action.equals("ViewShoppingCart")) {
                url = VIEWSHOPPINGCART;
            } else if (action.equals("AddToCart")) {
                url = ADDTOCART;
            } else if (action.equals("CreateAccount")) {
                url = CREATEACCOUNT;
            } else if (action.equals("LoginPage")) {
                url = LOGINPAGE;
            } else if (action.equals("CreateNewAccount")) {
                url = SIGNUPPAGE;
            } else if (action.equals("SearchCategory")) {
                url = SEARCHCATEGORY;
            } else if (action.equals("SearchProduct")) {
                url = SEARCHPRODUCT;
            } else if (action.equals("UpdateProduct")) {
                url = UPDATEPRODUCT;
            } else if (action.equals("EditProduct")) {
                url = EDITPRODUCT;
            } else if (action.equals("UpdateCategory")) {
                url = UPDATECATEGORY;
            } else if (action.equals("EditCategory")) {
                url = EDITCATEGORY;
            } else if (action.equals("AddProduct")) {
                url = ADDPRODUCT;
            } else if (action.equals("LoadAddProduct")) {
                url = LOADADDPRODUCT;
            } else if (action.equals("AddCategory")) {
                url = ADDCATEGORY;
            } else if (action.equals("ChangeStatusCategory")) {
                url = CHANGESTATUSCATEGORY;
            } else if (action.equals("ChangeStatusProduct")) {
                url = CHANGESTATUSPRODUCT;
            } else if (action.equals("Logout")) {
                url = LOGOUT;
            } else if (action.equals("Login")) {
                url = LOGIN;
            }
        } catch (Exception e) {
            log("Error at MainController " + e.getMessage());
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
