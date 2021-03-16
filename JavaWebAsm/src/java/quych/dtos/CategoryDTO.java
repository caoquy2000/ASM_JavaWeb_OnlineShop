/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quych.dtos;

import java.io.Serializable;

/**
 *
 * @author caoho
 */
public class CategoryDTO implements Serializable {
    private String categoryID;
    private String categoryName;
    private String cUrl;
    private int status;

    public CategoryDTO() {
    }

    public CategoryDTO(String categoryID, String categoryName, String cUrl, int status) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.cUrl = cUrl;
        this.status = status;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public int getStatus() {
        return status;
    }

    public String getcUrl() {
        return cUrl;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setcUrl(String cUrl) {
        this.cUrl = cUrl;
    }
    
}
