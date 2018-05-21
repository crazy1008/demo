package sau.project.user.controller;

import com.github.pagehelper.PageInfo;
import sau.project.common.util.Constants;
import sau.project.common.util.Method;
import sau.project.employers.models.JobPosition;
import sau.project.employers.service.EmployersService;
import sau.project.school.models.*;
import sau.project.school.service.StudentService;
import sau.project.user.models.User;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import sau.project.user.service.UserService;
import sau.project.user.service.CodeService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private CodeService codeService;
    @Autowired
    private StudentService studentService;
    @Autowired
    private EmployersService employersService;

    @RequestMapping("checkUser")
    public ModelAndView checkUser(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        HttpSession session = request.getSession();
        User user =(User)session.getAttribute("user");
        if(user!=null){
            modelAndView.setViewName("project/user/index");
        }else{
            modelAndView.setViewName("project/user/userList");
        }
        return modelAndView;
    }
    @RequestMapping("jumpUser")
    public ModelAndView jumpUser(HttpServletRequest request,Integer pageNum){
        HttpSession session = request.getSession();
        ModelAndView modelAndView = new ModelAndView();
        User user = (User)session.getAttribute("user");
        List<Integer> delivery = null;
        if(user.getDeliveryNumber()!=null){
            delivery = Method.transformation(user.getDeliveryNumber());
        }
        if(user.getStudentId()!=null){
            Student student = studentService.searchByStudentId(user.getStudentId());
            modelAndView.addObject("student",student);
            if(student.getEmploymentStatusName().equals(Constants.EMPLOYERS)){
                session.setAttribute("openG",1);
            }else if(student.getEmploymentStatusName().equals(Constants.POSTGRADUATE)){
                session.setAttribute("openG",2);
            }else if(student.getEmploymentStatusName().equals(Constants.JOIN_ARMY)){
                session.setAttribute("openG",3);
            }else if(student.getEmploymentStatusName().equals(Constants.CIVIL_SERVANT)){
                session.setAttribute("openG",4);
            }else{
                session.setAttribute("openG",5);
            }
        }
        if (pageNum == null) {
            pageNum = 1;
        }
        PageInfo<JobPosition> jobPosition = employersService.searchJobPosition(pageNum);
        modelAndView.addObject("lists", jobPosition);
        modelAndView.addObject("delivery", delivery);
        modelAndView.setViewName("project/user/index");
        return modelAndView;
    }
    @RequestMapping("user")
    @ResponseBody
    public Map<String,String> user(User user,HttpSession session){
        Map<String,String> map = new HashMap<String,String>();
        User user1 = userService.searchUser(user);
        if(user1==null){
            map.put("tip","error");
        }else{
            if(user1.getPassword().equals(user.getPassword())){
                session.setAttribute("user",user1);
                session.setAttribute("studentId",user1.getStudentId());
                map.put("tip","success");
            }
            else{
                map.put("tip","notPassword");
            }
        }
        return map;
    }
    @RequestMapping("userQuit")
    public void userQuit(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("user");
        request.getRequestDispatcher("/user.jsp").forward(request,response);
    }
    @RequestMapping("addUser")
    @ResponseBody
    public Map<String,Object> addUser(Student student,HttpServletRequest request){
        Map<String,Object> map = new HashMap<>();
        HttpSession session = request.getSession();
        String openG = student.getEmploymentStatusName();
        if(openG.equals(Constants.EMPLOYERS)){
                session.setAttribute("openG",1);
        }else if(openG.equals(Constants.POSTGRADUATE)){
            session.setAttribute("openG",2);
        }else if(openG.equals(Constants.JOIN_ARMY)){
            session.setAttribute("openG",3);
        }else if(openG.equals(Constants.CIVIL_SERVANT)){
            session.setAttribute("openG",4);
        }else{
            session.setAttribute("openG",5);
        }
        Integer schoolId = codeService.searchSchoolId(student.getSchoolName());
        Integer departmentId = codeService.searchDepartmentId(student.getDepartmentName());
        Integer majorId = codeService.searchMajorId(student.getMajorName());
        Integer employmentStatusId = codeService.searchEmploymentStatusId(student.getEmploymentStatusName());
        student.setDepartmentId(departmentId);
        student.setMajorId(majorId);
        student.setSchoolId(schoolId);
        student.setEmploymentStatusId(employmentStatusId);
        studentService.insertStudent(student);
        User user = (User)session.getAttribute("user");
        user.setStudentId(student.getStudentId());
        userService.update(user);
        session.setAttribute("studentId",student.getStudentId());
        map.put("tip","success");
        return map;
    }
    @RequestMapping("seeInformation")
    public ModelAndView seeInformation(Integer studentId){
        ModelAndView modelAndView = new ModelAndView();
        Student student = studentService.searchByStudentId(studentId);
        modelAndView.addObject("student",student);
        modelAndView.setViewName("project/user/seeInformation");
        return modelAndView;
    }
    @RequestMapping("updateStudent")
    @ResponseBody
    public Map<String,Student> updateStudent(Integer studentId){
        Map<String,Student> map = new HashMap<>();
        Student student = studentService.searchByStudentId(studentId);
        map.put("tip",student);
        return map;
    }
    @RequestMapping("updateUser")
    @ResponseBody
    public Map<String,String> updateUse(Student student){
        Map<String,String> map = new HashMap<>();
        Integer schoolId = codeService.searchSchoolId(student.getSchoolName());
        Integer departmentId = codeService.searchDepartmentId(student.getDepartmentName());
        Integer majorId = codeService.searchMajorId(student.getMajorName());
        Integer employmentStatusId = codeService.searchEmploymentStatusId(student.getEmploymentStatusName());
        student.setDepartmentId(departmentId);
        student.setMajorId(majorId);
        student.setSchoolId(schoolId);
        student.setEmploymentStatusId(employmentStatusId);
        studentService.updateUser(student);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addPostGraduate")
    @ResponseBody
    public Map<String,String> addPostGraduate(Postgraduate postgraduate){
        Map<String,String> map = new HashMap<>();
        studentService.insertPostgraduate(postgraduate);
        studentService.updateStudentPostgraduateById(postgraduate);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addJoinArmy")
    @ResponseBody
    public Map<String,String> addJoinArmy(JoinArmy joinArmy){
        Map<String,String> map = new HashMap<>();
        studentService.insertJoinArmy(joinArmy);
        studentService.updateStudentJoinArmyById(joinArmy);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addCivilServant")
    @ResponseBody
    public Map<String,String> addCivilServant(CivilServant civilServant){
        Map<String,String> map = new HashMap<>();
        studentService.insertCivilServant(civilServant);
        studentService.updateStudentCivilServantById(civilServant);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addEntrepreneurship")
    @ResponseBody
    public Map<String,String> addEntrepreneurship(Entrepreneurship entrepreneurship){
        Map<String,String> map = new HashMap<>();
        studentService.insertEntrepreneurship(entrepreneurship);
        studentService.updateStudentEntrepreneurshipById(entrepreneurship);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addCompany")
    @ResponseBody
    public Map<String,String> addCompany(Company company){
        Map<String,String> map = new HashMap<>();
        studentService.insertCompany(company);
        studentService.updateStudentById(company);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("delivery")
    @ResponseBody
    public Map<String,String> delivery(Integer jobId,Integer studentId,HttpSession session){
        Map<String,String> map = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if(user.getDeliveryNumber()==null){
            user.setDeliveryNumber(jobId+",");
        }
        else{
            user.setDeliveryNumber(user.getDeliveryNumber()+jobId+",");
        }
        userService.updateById(user);
        JobPosition jobPosition = new JobPosition();
        jobPosition.setJobPositionId(jobId);
        JobPosition jobPosition1 = employersService.searchById(jobId);
        if(jobPosition1.getDelivery()==null){
            jobPosition.setDelivery(studentId+",");
        }
        else {
            jobPosition.setDelivery(jobPosition1.getDelivery()+studentId+",");
        }
        employersService.upJobPosition(jobPosition);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addTwoCompany")
    @ResponseBody
    public Map<String,String> addTwoCompany(Company company){
        Map<String,String> map = new HashMap<>();
        studentService.insertTwoCompany(company);
        studentService.updateTwoStudentById(company);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addThreeCompany")
    @ResponseBody
    public Map<String,String> addThreeCompany(Company company){
        Map<String,String> map = new HashMap<>();
        studentService.insertThreeCompany(company);
        studentService.updateThreeStudentById(company);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addFourCompany")
    @ResponseBody
    public Map<String,String> addFourCompany(Company company){
        Map<String,String> map = new HashMap<>();
        studentService.insertFourCompany(company);
        studentService.updateFourStudentById(company);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addFiveCompany")
    @ResponseBody
    public Map<String,String> addFiveCompany(Company company){
        Map<String,String> map = new HashMap<>();
        studentService.insertFiveCompany(company);
        studentService.updateFiveStudentById(company);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addSixCompany")
    @ResponseBody
    public Map<String,String> addSixCompany(Company company){
        Map<String,String> map = new HashMap<>();
        studentService.insertSixCompany(company);
        studentService.updateSixStudentById(company);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("resultModal")
    @ResponseBody
    public Map<String,String> resultModal(Integer studentId,Integer jobId){
        Map<String,String> map = new HashMap<>();
        String value = employersService.resultValue(studentId,jobId);
        if(value!=null){
            if(value.equals(Constants.APPROPRIATE)){
                map.put("tip",Constants.APPROPRIATE);
            }
            else if(value.equals(Constants.INAPPROPRIATE)){
                map.put("tip",Constants.INAPPROPRIATE);
            }
        }
        else{
            map.put("tip",Constants.UNDETERMINED);
        }
        return map;
    }
 }
