package sau.project.user.models;

import lombok.Data;

@Data
public class User{
    private Integer id;
    private String username;
    private String password;
    private Integer studentId;
    private String deliveryNumber;
}
