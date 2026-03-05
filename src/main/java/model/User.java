package model;

public class User {

    private int userId;
    private String username;
    private String password;
    private String contactNo;
    private String address;
    private String email;
    private String nicOrPassport;
    private Role role;

    public User() {}

    public User(String username, String password, String contactNo,
                String address, String email, String nicOrPassport, Role role) {
        this.username = username;
        this.password = password;
        this.contactNo = contactNo;
        this.address = address;
        this.email = email;
        this.nicOrPassport = nicOrPassport;
        this.role = role;
    }

    public User(int userId, String username, String password, String contactNo,
                String address, String email, String nicOrPassport, Role role) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.contactNo = contactNo;
        this.address = address;
        this.email = email;
        this.nicOrPassport = nicOrPassport;
        this.role = role;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getContactNo() { return contactNo; }
    public void setContactNo(String contactNo) { this.contactNo = contactNo; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getNicOrPassport() { return nicOrPassport; }
    public void setNicOrPassport(String nicOrPassport) { this.nicOrPassport = nicOrPassport; }
    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
}