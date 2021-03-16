
package quych.dtos;

import java.io.Serializable;
import java.util.HashMap;

public class CartObj implements Serializable {
    private String oustomerName;
    private HashMap<String, ProductDTO> cart;
    
    public CartObj(String customerName) {
        this.oustomerName = customerName;
        this.cart = new HashMap<>();
    }
    
    public void addToCart(ProductDTO dto) throws Exception {
        if (this.cart.containsKey(dto.getProductID())) {
            int quantity = this.cart.get(dto.getProductID()).getpQuantity() + 1;
            dto.setpQuantity(quantity);
        }
        this.cart.put(dto.getProductID(), dto);
    }

    public String getOustomerName() {
        return oustomerName;
    }

    public HashMap<String, ProductDTO> getCart() {
        return cart;
    }

    public void setOustomerName(String oustomerName) {
        this.oustomerName = oustomerName;
    }
    public float getTotal() throws Exception {
        float result = 0;
        for(ProductDTO dto : this.cart.values()) {
            result += dto.getpQuantity() * dto.getpPrice();
        }
        return result;
    }
    public void remove(String id) throws Exception {
        if (this.cart.containsKey(id)) {
            this.cart.remove(id);
        }
    }
    public void update(String id, int quantity) throws Exception {
        if (this.cart.containsKey(id)) {
            this.cart.get(id).setpQuantity(quantity);
        }
    }
}
