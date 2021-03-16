package quych.controllers;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import quych.dtos.CartObj;
import quych.dtos.OrderDTO;
import quych.dtos.OrderDetailDTO;
import quych.dtos.ProductDTO;
import quych.models.OrderDAO;
import quych.models.OrderDetailDAO;
import quych.models.ProductDAO;

@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class OrderController extends HttpServlet {

    private static final String FAILED = "shoppingcart-page.jsp";
    private static final String SUCCESS = "LoadUserOrderController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = FAILED;
        try {
            //lay parameter cua order
            String fullName = request.getParameter("txtUsernameOrder");
            String address = request.getParameter("txtAddressOrder");
            String phone = request.getParameter("txtPhoneOrder");
            String email = request.getParameter("txtEmailOrder");
            Date date = new Date();
            Timestamp timeOfCreate = new Timestamp(date.getTime());
            int status = 1;
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("USERNAME");
            CartObj shoppingCart = (CartObj) session.getAttribute("CART");
            float total = shoppingCart.getTotal();
            OrderDAO dao = new OrderDAO();
            int currentOrderID = dao.countOrder() + 1;
            String orderID = "OD-" + username + "-" + currentOrderID;
            OrderDTO dto = new OrderDTO(orderID, fullName, address, phone, email, total, timeOfCreate, status, username);
            //check quantity cua cart
            boolean check = true;
            ProductDAO productDAO = new ProductDAO();
            for (ProductDTO dtoProduct : shoppingCart.getCart().values()) {
                if (!productDAO.checkQuantity(dtoProduct.getProductID(), dtoProduct.getpQuantity())) {
                    check = false;
                }
            }
            if (!check) {
                request.setAttribute("NOTENOUGNT", "Không đủ sản phẩm cho đơn hàng của bạn, Kiểm tra lại.");
            } else {
                List<OrderDetailDTO> listOrderDetail = new ArrayList<>();
                OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
                int currentOrderDetailID = orderDetailDAO.countOrderDetail();
                int count = 1;
                for (ProductDTO dtoProduct : shoppingCart.getCart().values()) {
                    int id = currentOrderDetailID + count;
                    String orderDetailID = orderID + "-detail-" + id;
                    float price = dtoProduct.getpPrice();
                    int quantity = dtoProduct.getpQuantity();
                    int statusDetail = 1;
                    String productID = dtoProduct.getProductID();
                    OrderDetailDTO orderDetailDTO = new OrderDetailDTO(orderDetailID, price, quantity, statusDetail, orderID, productID);
                    listOrderDetail.add(orderDetailDTO);
                    count++;
                }
                //goi dao de them order vao database

                if (dao.insertOrder(dto) && orderDetailDAO.insertMultiRow(listOrderDetail)) {
                    url = SUCCESS;
                    request.setAttribute("MAKEORDERSUCCESS", "Đặt Hàng Thành Công");
                    session.removeAttribute("CART");

                }
            }
        } catch (Exception e) {
//            log("ERROR at OrderController: " + e.getMessage());
            e.printStackTrace();
        } finally {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("USERNAME");
            if (username == null) {
                response.sendRedirect("login-page.jsp");
            } else {
                if (username.equals("admin")) {
                    response.sendRedirect("admin-product-page.jsp");
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
