package sau.project.user.dao;

public interface CodeDao {

    Integer searchEmploymentStatusId(String employmentStatusName);

    Integer searchMajorId(String majorName);

    Integer searchDepartmentId(String departmentName);

    Integer searchSchoolId(String schoolName);
}
