package sau.project.user.models;


import lombok.Data;

@Data
public class Code {
    private Integer schoolId;
    private String schoolName;
    private Integer departmentId;
    private String departmentName;
    private Integer majorId;
    private String majorName;
    private Integer employmentStatusId;
    private String employmentStatusName;
}
