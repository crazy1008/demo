package sau.project.employers.service.imp;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import sau.project.common.util.Constants;
import sau.project.employers.dao.EmployersDao;
import sau.project.employers.models.Employers;
import sau.project.employers.models.GroupCode;
import sau.project.employers.models.JobPosition;
import sau.project.employers.service.EmployersService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

public class EmployersServiceImpl implements EmployersService {

    @Autowired
    private EmployersDao employersDao;

    @Override
    public Employers searchEmployers(Employers employers) {
        Employers employers1 = employersDao.searchEmployers(employers);
        return employers1;
    }

    @Override
    public void insert(Employers employers) {
        employersDao.insert(employers);
    }

    @Override
    public PageInfo<Employers> search(Integer pageNum) {
        PageInfo<Employers>page=null;
        PageHelper.startPage(pageNum, Constants.PAGE_SIZE);
        List<Employers> employers = employersDao.search();
        page = new PageInfo<Employers>(employers);
        return page;
    }

    @Override
    public Employers selectByEmployersId(Integer id) {
        Employers employers = employersDao.selectByEmployersId(id);
        return employers;
    }

    @Override
    public void updateEmployers(Employers employers) {

        employersDao.updateEmployers(employers);
    }

    @Override
    public PageInfo<JobPosition> searchJobPosition(Integer pageNum) {
        PageInfo<JobPosition>page=null;
        PageHelper.startPage(pageNum, Constants.PAGE_SIZE);
        List<JobPosition> jobPosition = employersDao.searchJobPosition();
        page = new PageInfo<JobPosition>(jobPosition);
        return page;
    }

    @Override
    public PageInfo<JobPosition> searchJobPositionById(Integer pageNum, List<Integer> value,Integer studentId) {
        PageInfo<JobPosition>page=null;
        PageHelper.startPage(pageNum, Constants.PAGE_SIZE);
        List<JobPosition> jobPosition1 = employersDao.searchJobPositionById(value);
        for (JobPosition jo:jobPosition1
             ) {
            GroupCode groupCode = new GroupCode();
            groupCode.setStudentId(studentId);
            groupCode.setJobPositionId(jo.getJobPositionId());
            String va = employersDao.selectGroup(groupCode);
            if(va!=null){
                if(va.equals(Constants.APPROPRIATE)){
                    jo.setOpenF(Constants.APPROPRIATE);
                }else if(va.equals(Constants.INAPPROPRIATE)){
                    jo.setOpenF(Constants.INAPPROPRIATE);
                }else{
                }
            }
        }
        page = new PageInfo<JobPosition>(jobPosition1);
        return page;
    }

    @Override
    public JobPosition searchById(Integer jobId) {
        JobPosition jobPosition = employersDao.searchById(jobId);
        return jobPosition;
    }

    @Override
    public void deJobPosition(Integer jobId) {
        employersDao.deJobPosition(jobId);
    }

    @Override
    public void upJobPosition(JobPosition jobPosition) {
        employersDao.upJobPosition(jobPosition);
    }

    @Override
    public void addJobPosition(JobPosition jobPosition) {
        employersDao.addJobPosition(jobPosition);
    }

    @Override
    public void updateEmployersById(Employers employers) {
        employersDao.updateEmployersById(employers);
    }

    @Override
    public void insertGroupCode(GroupCode groupCode) {
        employersDao.insertGroupCode(groupCode);
    }

    @Override
    public String resultValue(Integer studentId, Integer jobId) {
        GroupCode groupCode = new GroupCode();
        groupCode.setJobPositionId(jobId);
        groupCode.setStudentId(studentId);
        String value = employersDao.selectGroup(groupCode);
        return value;
    }
}

