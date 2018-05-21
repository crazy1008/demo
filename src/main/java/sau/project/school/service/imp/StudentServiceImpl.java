package sau.project.school.service.imp;

import sau.project.employers.dao.EmployersDao;
import sau.project.employers.models.GroupCode;
import java.util.List;

import sau.project.school.models.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import sau.project.school.dao.StudentDao;
import sau.project.school.models.*;
import sau.project.school.service.StudentService;
import sau.project.common.util.Constants;

public class StudentServiceImpl implements StudentService {
    @Autowired
    private StudentDao studentDao;
    @Autowired
    private EmployersDao employersDao;

    @Override
    public CivilServant civilServant(Integer stateId) {
        CivilServant civilServant = studentDao.civilServant(stateId);
        return civilServant;
    }

    @Override
    public Postgraduate postgraduate(Integer stateId) {
        Postgraduate postgraduate = studentDao.postgraduate(stateId);
        return postgraduate;
    }

    @Override
    public Entrepreneurship entrepreneurship(Integer stateId) {
        Entrepreneurship entrepreneurship = studentDao.entrepreneurship(stateId);
        return entrepreneurship;
    }

    @Override
    public PageInfo<Student> searchAll(Integer pageNum) {
        PageInfo<Student> page = null;
        PageHelper.startPage(pageNum, Constants.PAGE_SIZE);
        List<Student> student = studentDao.searchAll();
        page = new PageInfo<Student>(student);
        return page;
    }

    @Override
    public PageInfo<Student> search(Student student, Integer pageNum) {
        PageInfo<Student> page = null;
        PageHelper.startPage(pageNum, Constants.PAGE_SIZE);
        List<Student> students = studentDao.search(student);
        page = new PageInfo<Student>(students);
        return page;
    }

    @Override
    public void insertStudent(Student student) {
        studentDao.insertStudent(student);
    }

    @Override
    public JoinArmy joinArmy(Integer stateId) {
        JoinArmy joinArmy = studentDao.joinArmy(stateId);
        return joinArmy;
    }

    @Override
    public Company obtainEmployment(Integer stateId) {
        Company company = studentDao.obtainEmployment(stateId);
        return company;
    }

    @Override
    public Student searchByStudentId(Integer studentId) {
        Student student = studentDao.seeInformation(studentId);
        return student;
    }

    @Override
    public void updateUser(Student student) {
        studentDao.updateUser(student);
    }

    @Override
    public void insertCompany(Company company) {
        studentDao.insertCompany(company);
    }

    @Override
    public void updateStudentById(Company company) {
        studentDao.updateStudentById(company);
    }

    @Override
    public void insertPostgraduate(Postgraduate postgraduate) {
        studentDao.insertPostgraduate(postgraduate);
    }

    @Override
    public void updateStudentPostgraduateById(Postgraduate postgraduate) {
        studentDao.updateStudentPostgraduateById(postgraduate);
    }

    @Override
    public void insertJoinArmy(JoinArmy joinArmy) {
        studentDao.insertJoinArmy(joinArmy);
    }

    @Override
    public void updateStudentJoinArmyById(JoinArmy joinArmy) {
        studentDao.updateStudentJoinArmyById(joinArmy);
    }

    @Override
    public void insertCivilServant(CivilServant civilServant) {
        studentDao.insertCivilServant(civilServant);
    }

    @Override
    public void updateStudentCivilServantById(CivilServant civilServant) {
        studentDao.updateStudentCivilServantById(civilServant);
    }

    @Override
    public void insertEntrepreneurship(Entrepreneurship entrepreneurship) {
        studentDao.insertEntrepreneurship(entrepreneurship);
    }

    @Override
    public void updateStudentEntrepreneurshipById(Entrepreneurship entrepreneurship) {
        studentDao.updateStudentEntrepreneurshipById(entrepreneurship);
    }

    @Override
    public PageInfo<Student> searchListById(Integer pageNum, List<Integer> value,Integer jobId) {
        GroupCode groupCode = new GroupCode();
        PageInfo<Student> page = null;
        PageHelper.startPage(pageNum, Constants.PAGE_SIZE);
        List<Student> students = studentDao.searchListById(value);
        if(jobId!=null){
            for (Student st:
                 students) {
                groupCode.setJobPositionId(jobId);
                groupCode.setStudentId(st.getStudentId());
                String va = employersDao.selectGroup(groupCode);
                if(va != null){
                        st.setJudgeId(1);
                }

            }
        }
        page = new PageInfo<Student>(students);
        return page;
    }

    @Override
    public void insertTwoCompany(Company company) {
        studentDao.insertTwoCompany(company);
    }

    @Override
    public void insertThreeCompany(Company company) {
        studentDao.insertThreeCompany(company);
    }

    @Override
    public void insertFourCompany(Company company) {
        studentDao.insertFourCompany(company);
    }

    @Override
    public void insertFiveCompany(Company company) {
        studentDao.insertFiveCompany(company);
    }

    @Override
    public void insertSixCompany(Company company) {
        studentDao.insertSixCompany(company);
    }

    @Override
    public void updateTwoStudentById(Company company) {
        studentDao.updateTwoStudentById(company);
    }

    @Override
    public void updateThreeStudentById(Company company) {
        studentDao.updateThreeStudentById(company);
    }

    @Override
    public void updateFourStudentById(Company company) {
        studentDao.updateFourStudentById(company);
    }

    @Override
    public void updateFiveStudentById(Company company) {
        studentDao.updateFiveStudentById(company);
    }

    @Override
    public void updateSixStudentById(Company company) {
        studentDao.updateSixStudentById(company);
    }

    @Override
    public Company obtainTwoEmployment(Integer twoStateId) {
        Company company = studentDao.obtainTwoEmployment(twoStateId);
        return company;
    }

    @Override
    public Company obtainThreeEmployment(Integer threeStateId) {
        Company company = studentDao.obtainThreeEmployment(threeStateId);
        return company;
    }

    @Override
    public Company obtainFourEmployment(Integer fourStateId) {
        Company company = studentDao.obtainFourEmployment(fourStateId);
        return company;
    }

    @Override
    public Company obtainFiveEmployment(Integer fiveStateId) {
        Company company = studentDao.obtainFiveEmployment(fiveStateId);
        return company;
    }

    @Override
    public Company obtainSixEmployment(Integer sixStateId) {
        Company company = studentDao.obtainSixEmployment(sixStateId);
        return company;
    }

    @Override
    public void updateJudgeId(Integer studentId) {
        studentDao.updateJudgeId(studentId);
    }
}
