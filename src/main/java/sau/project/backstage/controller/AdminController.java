package sau.project.backstage.controller;

import com.github.pagehelper.PageInfo;
import sau.project.backstage.models.Admin;
import sau.project.backstage.models.Department;
import sau.project.backstage.models.Major;
import sau.project.backstage.models.SchoolName;
import sau.project.backstage.service.AdminService;
import sau.project.common.util.Constants;
import sau.project.employers.models.Employers;
import sau.project.employers.service.EmployersService;
import sau.project.school.models.School;
import sau.project.school.service.UserLoginService;
import sau.project.user.models.User;
import sau.project.user.service.UserService;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class AdminController {

    @Autowired
    private AdminService adminService;
    @Autowired
    private UserService userService;
    @Autowired
    private UserLoginService userLoginService;
    @Autowired
    private EmployersService employersService;


    @RequestMapping("checkAdmin")
    public ModelAndView checkAdmin(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        if(admin==null){
            modelAndView.setViewName("project/backstage/login");
        }
        else{
            modelAndView.setViewName("project/backstage/index");
        }
        return modelAndView;
    }
    @RequestMapping("admin")
    @ResponseBody
    public Map<String,String> admin(Admin admin,HttpSession session){
        Map<String,String> map = new HashMap<>();
        Admin admin1 = adminService.searchAdmin(admin);
        if(admin1==null){
            map.put("tip","error");
        }else{
            if(admin1.getPassword().equals(admin.getPassword())){
                session.setAttribute("admin",admin1);
                map.put("tip","success");
            }
            else{
                map.put("tip","notPassword");
            }
        }
        return map;
    }
    @RequestMapping("jumpAdmin")
    public ModelAndView jumpAdmin(Integer pageNum){
        if (pageNum == null) {
            pageNum = 1;
        }
        ModelAndView modelAndView = new ModelAndView();
        PageInfo<User> user = userService.search(pageNum);
        modelAndView.addObject("openFlg", Constants.OPEN_FLG_ONE);
        modelAndView.addObject("lists",user);
        modelAndView.setViewName("project/backstage/index");
        return modelAndView;
    }
    @RequestMapping("quitAdmin")
    public void quitAdmin(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("admin");
        request.getRequestDispatcher("/backstage.jsp").forward(request,response);
    }
    @RequestMapping("checkExists")
    @ResponseBody
    public Map<String,String> checkExists(User user){
        Map<String,String> map = new HashMap<>();
        User user1 = userService.searchUser(user);
        if(user1 == null){
            map.put("tip","success");
        }
        else{
            map.put("tip","error");
        }
        return map;
    }
    @RequestMapping("checkExistsUser")
    @ResponseBody
    public Map<String,String> checkExistsUser(School school){
        Map<String,String> map = new HashMap<>();
        School school1 = userLoginService.searchUser(school.getUsername());
        if(school1 == null){
            map.put("tip","success");
        }
        else{
            map.put("tip","error");
        }
        return map;
    }
    @RequestMapping("checkExistsEmployers")
    @ResponseBody
    public Map<String,String> checkExistsEmployers(Employers employers){
        Map<String,String> map = new HashMap<>();
        Employers employers1 = employersService.searchEmployers(employers);
        if(employers1 == null){
            map.put("tip","success");
        }
        else{
            map.put("tip","error");
        }
        return map;
    }
    @RequestMapping("checkExistsSchoolName")
    @ResponseBody
    public Map<String,String> checkExistsSchoolName(SchoolName schoolName){
        Map<String,String> map = new HashMap<>();
        SchoolName schoolName1 = adminService.searchSchoolName(schoolName);
        if(schoolName1 == null){
            map.put("tip","success");
        }
        else{
            map.put("tip","error");
        }
        return map;
    }
    @RequestMapping("checkExistsDepartment")
    @ResponseBody
    public Map<String,String> checkExistsDepartment(Department department){
        Map<String,String> map = new HashMap<>();
        Department department1 = adminService.searchDepartment(department);
        if(department1 == null){
            map.put("tip","success");
        }
        else{
            map.put("tip","error");
        }
        return map;
    }
    @RequestMapping("checkExistsMajor")
    @ResponseBody
    public Map<String,String> checkExistsMajor(Major major){
        Map<String,String> map = new HashMap<>();
        Major major1 = adminService.searchMajor(major);
        if(major1 == null){
            map.put("tip","success");
        }
        else{
            map.put("tip","error");
        }
        return map;
    }
    @RequestMapping("addGraduate")
    @ResponseBody
    public Map<String,String> addGraduate(User user){
        Map<String,String> map = new HashMap<>();
        userService.insert(user);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("add")
    @ResponseBody
    public Map<String,String> add(School school){
        Map<String,String> map = new HashMap<>();
        userLoginService.insert(school);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addEmployers")
    @ResponseBody
    public Map<String,String> addEmployers(Employers employers){
        Map<String,String> map = new HashMap<>();
        employersService.insert(employers);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addSchoolName")
    @ResponseBody
    public Map<String,String> addSchoolName(SchoolName schoolName){
        Map<String,String> map = new HashMap<>();
        adminService.insertSchoolName(schoolName);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addDepartment")
    @ResponseBody
    public Map<String,String> addDepartment(Department department){
        Map<String,String> map = new HashMap<>();
        adminService.insertDepartment(department);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("addMajor")
    @ResponseBody
    public Map<String,String> addMajor(Major major){
        Map<String,String> map = new HashMap<>();
        adminService.insertMajor(major);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("delete")
    @ResponseBody
    public Map<String,String> delete(Integer id){
        Map<String,String> map = new HashMap<>();
        adminService.delete(id);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("selectById")
    @ResponseBody
    public Map<String,Object> selectById(Integer id){
        Map<String,Object> map = new HashMap<>();
        User user = userService.selectById(id);
        map.put("tip",user);
        return map;
    }
    @RequestMapping("updateGraduate")
    @ResponseBody
    public Map<String,String> updateGraduate(User user){
        Map<String,String> map = new HashMap<>();
        userService.updateGraduate(user);
        map.put("tip","success");
        return map;

    }
    @RequestMapping("seeUser")
    public ModelAndView seeUser(Integer pageNum){
        if (pageNum == null) {
            pageNum = 1;
        }
        ModelAndView modelAndView = new ModelAndView();
        PageInfo<School> school = userLoginService.search(pageNum);
        modelAndView.addObject("openFlg", Constants.OPEN_FLG_TOW);
        modelAndView.addObject("lists",school);
        modelAndView.setViewName("project/backstage/index");
        return modelAndView;
    }
    @RequestMapping("seeEmployers")
    public ModelAndView seeEmployers(Integer pageNum){
        if (pageNum == null) {
            pageNum = 1;
        }
        ModelAndView modelAndView = new ModelAndView();
        PageInfo<Employers> employers = employersService.search(pageNum);
        modelAndView.addObject("openFlg", Constants.OPEN_FLG_THREE);
        modelAndView.addObject("lists",employers);
        modelAndView.setViewName("project/backstage/index");
        return modelAndView;
    }
    @RequestMapping("deleteUser")
    @ResponseBody
    public Map<String,String> deleteUser(Integer id){
        Map<String,String> map = new HashMap<>();
        adminService.deleteUser(id);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("deleteEmployers")
    @ResponseBody
    public Map<String,String> deleteEmployers(Integer id){
        Map<String,String> map = new HashMap<>();
        adminService.deleteEmployers(id);
        map.put("tip","success");
        return map;
    }
    @RequestMapping("selectByUserId")
    @ResponseBody
    public Map<String,Object> selectByUserId(Integer id){
        Map<String,Object> map = new HashMap<>();
        School school = userLoginService.selectByUserId(id);
        map.put("tip",school);
        return map;
    }
    @RequestMapping("selectByEmployersId")
    @ResponseBody
    public Map<String,Object> selectByEmployersId(Integer id){
        Map<String,Object> map = new HashMap<>();
        Employers employers = employersService.selectByEmployersId(id);
        map.put("tip",employers);
        return map;
    }
    @RequestMapping("updateUserPassword")
    @ResponseBody
    public Map<String,String> updateUserPassword(School school){
        Map<String,String> map = new HashMap<>();
        userLoginService.updateUserPassword(school);
        map.put("tip","success");
        return map;

    }
    @RequestMapping("updateEmployers")
    @ResponseBody
    public Map<String,String> updateEmployers(Employers employers){
        Map<String,String> map = new HashMap<>();
        employersService.updateEmployers(employers);
        map.put("tip","success");
        return map;

    }
}
