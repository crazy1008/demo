package sau.project.backstage.service;

import sau.project.backstage.models.Admin;
import sau.project.backstage.models.Department;
import sau.project.backstage.models.Major;
import sau.project.backstage.models.SchoolName;

public interface AdminService {
    Admin searchAdmin(Admin admin);

    SchoolName searchSchoolName(SchoolName schoolName);

    Department searchDepartment(Department department);

    Major searchMajor(Major major);

    void insertSchoolName(SchoolName schoolName);

    void insertDepartment(Department department);

    void insertMajor(Major major);

    void delete(Integer id);

    void deleteUser(Integer id);

    void deleteEmployers(Integer id);
}
