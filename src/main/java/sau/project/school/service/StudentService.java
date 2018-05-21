package sau.project.school.service;

import com.github.pagehelper.PageInfo;
import sau.project.school.models.*;
import java.util.List;
import sau.project.school.models.*;

public interface StudentService {

	PageInfo<Student> searchAll(Integer pageNum);

	PageInfo<Student> search(Student student, Integer pageNum);

	Company obtainEmployment(Integer stateId);

    JoinArmy joinArmy(Integer stateId);

    CivilServant civilServant(Integer stateId);

    Postgraduate postgraduate(Integer stateId);

    Entrepreneurship entrepreneurship(Integer stateId);

    void insertStudent(Student student);

    Student searchByStudentId(Integer studentId);

    void updateUser(Student student);

    void insertCompany(Company company);

    void updateStudentById(Company company);

    void insertPostgraduate(Postgraduate postgraduate);

    void updateStudentPostgraduateById(Postgraduate postgraduate);

    void insertJoinArmy(JoinArmy joinArmy);

    void updateStudentJoinArmyById(JoinArmy joinArmy);

    void insertCivilServant(CivilServant civilServant);

    void updateStudentCivilServantById(CivilServant civilServant);

    void insertEntrepreneurship(Entrepreneurship entrepreneurship);

    void updateStudentEntrepreneurshipById(Entrepreneurship entrepreneurship);

    PageInfo<Student> searchListById(Integer pageNum, List<Integer> value, Integer jobId);

    void insertTwoCompany(Company company);

    void insertThreeCompany(Company company);

    void insertFourCompany(Company company);

    void insertFiveCompany(Company company);

    void insertSixCompany(Company company);

    void updateTwoStudentById(Company company);

    void updateThreeStudentById(Company company);

    void updateFourStudentById(Company company);

    void updateFiveStudentById(Company company);

    void updateSixStudentById(Company company);

    Company obtainTwoEmployment(Integer twoStateId);

    Company obtainThreeEmployment(Integer threeStateId);

    Company obtainFourEmployment(Integer fourStateId);

    Company obtainFiveEmployment(Integer fiveStateId);

    Company obtainSixEmployment(Integer sixStateId);

    void updateJudgeId(Integer studentId);
}

	
