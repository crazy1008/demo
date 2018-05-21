package sau.project.employers.controller;

import com.github.pagehelper.PageInfo;
import sau.project.common.util.Method;
import sau.project.employers.models.Employers;
import sau.project.employers.models.GroupCode;
import sau.project.employers.models.JobPosition;
import sau.project.employers.service.EmployersService;
import sau.project.school.models.Student;
import sau.project.school.service.StudentService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class EmployersController {

    @Autowired
    private EmployersService employersService;
    @Autowired
    private StudentService studentService;

    @RequestMapping("checkEmployers")
    public ModelAndView checkEmployers(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        HttpSession session = request.getSession();
        Employers employers = (Employers) session.getAttribute("employers");
        if(employers==null){
            modelAndView.setViewName("project/employers/login");
        }else{
            modelAndView.setViewName("project/employers/index");
        }
        return modelAndView;
    }
    @RequestMapping("employers")
    @ResponseBody
    public Map<String,String> employers(Employers employers,HttpSession session){
        Map<String,String> map = new HashMap<String,String>();
        Employers employers1 = employersService.searchEmployers(employers);
        if(employers1==null){
            map.put("tip","error");
        }else{
            if(employers1.getPassword().equals(employers.getPassword())){
                session.setAttribute("employers",employers1);
                map.put("tip","success");
            }
            else{
                map.put("tip","notPassword");
            }
        }
        return map;
    }
    @RequestMapping("jumpEmployers")
    public ModelAndView jumpEmployers(Integer pageNum,HttpServletRequest request){
        Integer jobId =null;
        HttpSession session = request.getSession();
        if (pageNum == null) {
            pageNum = 1;
        }
        ModelAndView mvAndView = new ModelAndView();
        Employers employers = (Employers)session.getAttribute("employers");
        PageInfo<JobPosition> jobPosition1 = null;
        if(employers.getJobId()!=null){
            List<Integer> value = Method.transformation(employers.getJobId());
            jobPosition1 = employersService.searchJobPositionById(pageNum,value,jobId);
        }
        mvAndView.addObject("lists", jobPosition1);
        mvAndView.setViewName("project/employers/index");
        return mvAndView;
    }
    @RequestMapping("quitJobPosition")
    public ModelAndView quitJobPosition(HttpServletRequest request){
        HttpSession session = request.getSession();
        ModelAndView modelAndView = new ModelAndView();
        session.removeAttribute("employers");
        modelAndView.setViewName("project/employers/login");
        return modelAndView;
    }
    @RequestMapping("searchJobPositionById")
    @ResponseBody
    public Map<String,JobPosition> searchJobPositionById(Integer jobId){
        Map<String,JobPosition> map = new HashMap<String,JobPosition>();
        JobPosition jobPosition = employersService.searchById(jobId);
        map.put("tip",jobPosition);
        return map;
    }
    @RequestMapping("deJobPosition")
    @ResponseBody
    public Map<String,String> deJobPosition(Integer jobId,HttpSession session){
        Employers employers1 = (Employers)session.getAttribute("employers");
        String value =Method.removeValue(employers1.getJobId(),jobId);
        employers1.setJobId(value);
        Employers employers = employersService.selectByEmployersId(employers1.getId());
        String data = Method.removeValue(employers.getJobId(),jobId);
        employers.setJobId(data);
        employersService.updateEmployersById(employers);
        Map<String,String> map = new HashMap<String,String>();
        employersService.deJobPosition(jobId);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("upJobPosition")
    @ResponseBody
    public Map<String,String> upJobPosition(JobPosition jobPosition){
        Map<String,String> map = new HashMap<String,String>();
        employersService.upJobPosition(jobPosition);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addJobPosition")
    @ResponseBody
    public Map<String,String> addJobPosition(JobPosition jobPosition,HttpServletRequest request){
        Map<String,String> map = new HashMap<>();
        HttpSession session = request.getSession();
        employersService.addJobPosition(jobPosition);
        Employers employers1 = (Employers)session.getAttribute("employers");

        Employers employers = employersService.selectByEmployersId(employers1.getId());
        String jobId = "";
        if(employers.getJobId()==null){
            employers1.setJobId(jobPosition.getJobPositionId()+",");
            jobId = jobPosition.getJobPositionId()+",";
        }else {
            employers1.setJobId(employers.getJobId()+jobPosition.getJobPositionId()+",");
            jobId = employers.getJobId()+jobPosition.getJobPositionId()+",";
        }
        employers.setJobId(jobId);
        employersService.updateEmployersById(employers);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("seJobPosition")
    public ModelAndView seJobPosition(JobPosition jobPosition){
        Integer pageNum =null;
        if (pageNum == null) {
            pageNum = 1;
        }
        ModelAndView modelAndView = new ModelAndView();
        Integer jobId = jobPosition.getJobPositionId();
        JobPosition jobPosition1 = employersService.searchById(jobId);
        PageInfo<Student> student = null;
        if(jobPosition1.getDelivery()!=null){
            List<Integer> value = Method.transformation(jobPosition1.getDelivery());
            student = studentService.searchListById(pageNum,value,jobId);
        }
        modelAndView.addObject("jobId",jobPosition.getJobPositionId());
        modelAndView.addObject("lists", student);
        modelAndView.setViewName("project/employers/studentInfo");
        return modelAndView;
    }
    @RequestMapping("seJobPositionEr")
    public ModelAndView seJobPositionEr(Integer pageNum,Integer jobId){
        if (pageNum == null) {
            pageNum = 1;
        }
        ModelAndView modelAndView = new ModelAndView();
        JobPosition jobPosition1 = employersService.searchById(jobId);
        PageInfo<Student> student = null;
        if(jobPosition1.getDelivery()!=null){
            List<Integer> value = Method.transformation(jobPosition1.getDelivery());
            student = studentService.searchListById(pageNum,value,jobId);
        }
        modelAndView.addObject("lists", student);
        modelAndView.setViewName("project/employers/studentInfo");
        return modelAndView;
    }
    @RequestMapping("judgeAppropriate.do")
    @ResponseBody
    public Map<String,String> judgeAppropriate(GroupCode groupCode){
        Map<String,String> map = new HashMap<>();
        employersService.insertGroupCode(groupCode);
        map.put("tip","success");
        return map;
    }
}
