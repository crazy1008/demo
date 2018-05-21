package sau.project.user.service;

public interface CodeService {

    Integer searchEmploymentStatusId(String employmentStatusName);

    Integer searchMajorId(String majorName);

    Integer searchDepartmentId(String departmentName);

    Integer searchSchoolId(String schoolName);
}
