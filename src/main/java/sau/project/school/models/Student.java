package sau.project.school.models;

import lombok.Data;

@Data
public class Student {

	private Integer studentId;
	private Integer studentSchoolId;
	private Integer studentDepartmentId;
	private Integer studentMajorId;
	private Integer schoolId;
	private Integer departmentId;
	private Integer majorId;
	private String schoolName;
	private String departmentName;
	private String majorName;
	private String studentNo;
	private String studentName;
	private String studentSex;
	private String studentClass;
	private String studentOpenDate;
	private String studentExpireDate;
	private String employmentStatusName;
	private String studentEmploymentStatusId;
	private Integer employmentStatusId;
	private Integer stateId;
    private Integer twoStateId;
    private Integer threeStateId;
    private Integer fourStateId;
    private Integer fiveStateId;
    private Integer sixStateId;
    private Integer judgeId;
}
