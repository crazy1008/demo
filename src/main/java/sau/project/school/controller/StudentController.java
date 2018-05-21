package sau.project.school.controller;


import sau.project.common.util.Constants;
import sau.project.common.util.Method;
import sau.project.employers.models.JobPosition;
import sau.project.employers.service.EmployersService;
import sau.project.school.models.*;
import sau.project.user.service.UserService;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import com.github.pagehelper.PageInfo;
import sau.project.school.service.StudentService;
import sau.project.school.models.*;

import javax.servlet.http.HttpSession;

@Controller
public class StudentController {

    @Autowired
    private StudentService studentService;
    @Autowired
    private UserService userService;
    @Autowired
    private EmployersService employersService;

    @RequestMapping("check")
    public ModelAndView check(HttpServletRequest request, Integer pageNum) {
        HttpSession session = request.getSession();
        session.getAttribute("school");
        ModelAndView mvAndView = new ModelAndView();
        School school = (School) session.getAttribute("school");
        if (school != null) {
            if (pageNum == null) {
                pageNum = 1;
            }
            PageInfo<Student> student = studentService.searchAll(pageNum);
            mvAndView.addObject("lists", student);
            mvAndView.setViewName("project/school/index");
        } else {
            mvAndView.setViewName("project/school/login");
        }

        return mvAndView;
    }

    @RequestMapping("jump")
    public ModelAndView jump(Integer pageNum) {
        if (pageNum == null) {
            pageNum = 1;
        }
        ModelAndView mvAndView = new ModelAndView();
        PageInfo<Student> student = studentService.searchAll(pageNum);
        mvAndView.addObject("lists", student);
        mvAndView.setViewName("project/school/index");
        return mvAndView;
    }

    @RequestMapping("search")
    public ModelAndView search(Student student, Integer pageNum) {
        if (pageNum == null || pageNum > 1) {
            pageNum = 1;
        }
        ModelAndView mvAndView = new ModelAndView();
        PageInfo<Student> student1 = studentService.search(student, pageNum);
        mvAndView.addObject("st", student);
        mvAndView.addObject("lists", student1);
        mvAndView.setViewName("project/school/index");
        return mvAndView;
    }

    @RequestMapping("searcher")
    public ModelAndView searcher(Student student, Integer pageNum) {
        if (pageNum == null) {
            pageNum = 1;
        }
        ModelAndView mvAndView = new ModelAndView();
        PageInfo<Student> student1 = studentService.search(student, pageNum);
        mvAndView.addObject("st", student);
        mvAndView.addObject("lists", student1);
        mvAndView.setViewName("project/school/index");
        return mvAndView;
    }

    @RequestMapping("obtainEmployment")
    public ModelAndView obtainEmployment(Integer studentId) {
        ModelAndView mView = new ModelAndView();
        Student student = studentService.searchByStudentId(studentId);
        List<Company> companyList= new ArrayList<Company>();
        if(student.getStateId()!=null){
            Company company = studentService.obtainEmployment(student.getStateId());
            company.setTerm(Constants.TERM_ONE);
            companyList.add(company);
        }
        if(student.getTwoStateId()!=null){
            Company company1 = studentService.obtainTwoEmployment(student.getTwoStateId());
            company1.setTerm(Constants.TERM_TWO);
            companyList.add(company1);
        }
        if(student.getThreeStateId()!=null){
            Company company2 = studentService.obtainThreeEmployment(student.getThreeStateId());
            company2.setTerm(Constants.TERM_THREE);
            companyList.add(company2);
        }
        if(student.getFourStateId()!=null){
            Company company3 = studentService.obtainFourEmployment(student.getFourStateId());
            company3.setTerm(Constants.TERM_FOUR);
            companyList.add(company3);
        }
        if(student.getFiveStateId()!=null){
            Company company4 = studentService.obtainFiveEmployment(student.getFiveStateId());
            company4.setTerm(Constants.TERM_FIVE);
            companyList.add(company4);
        }
        if(student.getSixStateId()!=null){
            Company company5 = studentService.obtainSixEmployment(student.getSixStateId());
            company5.setTerm(Constants.TERM_SIX);
            companyList.add(company5);
        }
        mView.addObject("companyList", companyList);
        mView.setViewName("project/school/obtainEmployment");
        return mView;
    }

    @RequestMapping("joinArmy")
    public ModelAndView joinArmy(Integer stateId) {
        ModelAndView mView = new ModelAndView();
        JoinArmy joinArmy = studentService.joinArmy(stateId);
        mView.addObject("joinArmy", joinArmy);
        mView.setViewName("project/school/joinArmy");
        return mView;
    }

    @RequestMapping("civilServant")
    public ModelAndView civilServant(Integer stateId) {
        ModelAndView mView = new ModelAndView();
        CivilServant civilServant = studentService.civilServant(stateId);
        mView.addObject("civilServant", civilServant);
        mView.setViewName("project/school/civilServant");
        return mView;
    }

    @RequestMapping("postgraduate")
    public ModelAndView postgraduate(Integer stateId) {
        ModelAndView mView = new ModelAndView();
        Postgraduate postgraduate = studentService.postgraduate(stateId);
        mView.addObject("postgraduate", postgraduate);
        mView.setViewName("project/school/postgraduate");
        return mView;
    }
    @RequestMapping("entrepreneurship")
    public ModelAndView entrepreneurship(Integer stateId) {
        ModelAndView mView = new ModelAndView();
        Entrepreneurship entrepreneurship = studentService.entrepreneurship(stateId);
        mView.addObject("entrepreneurship", entrepreneurship);
        mView.setViewName("project/school/entrepreneurship");
        return mView;
    }
    @RequestMapping("jobInformationById")
    public ModelAndView jobInformationById(Student student){
        Integer pageNum =null;
        Integer jobId =null;
        if(pageNum == null){
            pageNum = 1;
        }
        ModelAndView modelAndView = new ModelAndView();
        PageInfo<JobPosition> jobPosition = null;
        String deliveryValue = userService.selectByStudentId(student.getStudentId());
        if(deliveryValue!=null){
            List<Integer> deliveryVa = Method.transformation(deliveryValue);
            jobPosition = employersService.searchJobPositionById(pageNum,deliveryVa,student.getStudentId());
        }
        modelAndView.addObject("lists",jobPosition);
        modelAndView.setViewName("project/school/jobInformation");
        return modelAndView;
    }
}
