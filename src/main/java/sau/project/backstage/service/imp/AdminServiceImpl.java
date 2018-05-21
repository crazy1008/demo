package sau.project.backstage.service.imp;

import sau.project.backstage.dao.AdminDao;
import sau.project.backstage.models.Admin;
import sau.project.backstage.models.Department;
import sau.project.backstage.models.Major;
import sau.project.backstage.models.SchoolName;
import sau.project.backstage.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;

public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminDao adminDao;
    @Override
    public Admin searchAdmin(Admin admin) {
        Admin admin1 = adminDao.searchAdmin(admin);
        return admin1;
    }

    @Override
    public SchoolName searchSchoolName(SchoolName schoolName) {
        SchoolName schoolName1 = adminDao.searchSchoolName(schoolName);
        return schoolName1;
    }

    @Override
    public Department searchDepartment(Department department) {
        Department department1 = adminDao.searchDepartment(department);
        return department1;
    }

    @Override
    public Major searchMajor(Major major) {
        Major major1 = adminDao.searchMajor(major);
        return major1;
    }

    @Override
    public void insertSchoolName(SchoolName schoolName) {
        adminDao.insertSchoolName(schoolName);
    }

    @Override
    public void insertDepartment(Department department) {
        adminDao.insertDepartment(department);
    }

    @Override
    public void insertMajor(Major major) {
        adminDao.insertMajor(major);
    }

    @Override
    public void delete(Integer id) {
        adminDao.delete(id);
    }

    @Override
    public void deleteUser(Integer id) {
        adminDao.deleteUser(id);
    }

    @Override
    public void deleteEmployers(Integer id) {
        adminDao.deleteEmployers(id);
    }
}
