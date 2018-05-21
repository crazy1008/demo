package sau.project.employers.service;

import com.github.pagehelper.PageInfo;
import sau.project.employers.models.Employers;
import sau.project.employers.models.GroupCode;
import sau.project.employers.models.JobPosition;
import java.util.List;

public interface EmployersService {
    Employers searchEmployers(Employers employers);

    void insert(Employers employers);

    PageInfo<Employers> search(Integer pageNum);

    Employers selectByEmployersId(Integer id);

    void updateEmployers(Employers employers);

    PageInfo<JobPosition> searchJobPosition(Integer pageNum);

    PageInfo<JobPosition> searchJobPositionById(Integer pageNum, List<Integer> value, Integer studentId);

    JobPosition searchById(Integer jobId);

    void deJobPosition(Integer jobId);

    void upJobPosition(JobPosition jobPosition);

    void addJobPosition(JobPosition jobPosition);

    void updateEmployersById(Employers employers);

    void insertGroupCode(GroupCode groupCode);

    String resultValue(Integer studentId, Integer jobId);
}
