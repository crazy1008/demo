package sau.project.user.service.imp;

import sau.project.user.service.CodeService;
import org.springframework.beans.factory.annotation.Autowired;
import sau.project.user.dao.CodeDao;


public class CodeServiceImpl implements CodeService {

    @Autowired
    private CodeDao codeDao;

    @Override
    public Integer searchEmploymentStatusId(String employmentStatusName) {
        Integer employmentStatus = codeDao.searchEmploymentStatusId(employmentStatusName);
        return employmentStatus;
    }

    @Override
    public Integer searchMajorId(String majorName) {
        Integer majorId = codeDao.searchMajorId(majorName);
        return majorId;
    }

    @Override
    public Integer searchDepartmentId(String departmentName) {
        Integer departmentId = codeDao.searchDepartmentId(departmentName);
        return departmentId;
    }

    @Override
    public Integer searchSchoolId(String schoolName) {
        Integer schoolId = codeDao.searchSchoolId(schoolName);
        return schoolId;
    }
}
