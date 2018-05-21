package sau.project.employers.models;

import lombok.Data;

@Data
public class GroupCode {
    private Integer id;
    private Integer studentId;
    private Integer jobPositionId;
    private String judgeAppropriate;
}
