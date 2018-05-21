package sau.project.employers.dao;

import sau.project.employers.models.Employers;
import sau.project.employers.models.GroupCode;
import sau.project.employers.models.JobPosition;
import java.util.List;

public interface EmployersDao {
    Employers searchEmployers(Employers employers);

    void insert(Employers employers);

    List<Employers> search();

    Employers selectByEmployersId(Integer id);

    void updateEmployers(Employers employers);

    List<JobPosition> searchJobPosition();

    List<JobPosition> searchJobPositionById(List<Integer> value);

    JobPosition searchById(Integer jobId);

    void deJobPosition(Integer jobId);

    void upJobPosition(JobPosition jobPosition);

    void addJobPosition(JobPosition jobPosition);

    void updateEmployersById(Employers employers);

    void insertGroupCode(GroupCode groupCode);

    String selectGroup(GroupCode groupCode);
}
