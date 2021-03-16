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
public class UserDTO implements Serializable {
    private String username;
    private String password;
    private String fullname;
    private String roleID;

    public UserDTO() {
    }

    public UserDTO(String username, String password, String fullname, String roleID) {
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.roleID = roleID;
    }

   

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getFullname() {
        return fullname;
    }

    

    public String getRoleID() {
        return roleID;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

   

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }
    
}
