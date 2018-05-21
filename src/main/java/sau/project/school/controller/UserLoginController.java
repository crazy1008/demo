package sau.project.school.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;
import sau.project.school.service.UserLoginService;
import sau.project.school.models.School;

@Controller
public class UserLoginController {
	@Autowired
	private UserLoginService userLoginService;

	@RequestMapping("login")
	@ResponseBody
	public Map<String, String> userLogin(School school, HttpSession session) {
		Map<String, String> moView = new HashMap<String, String>();
		School school1 = userLoginService.searchUser(school.getUsername());
		if (school1 == null) {
			moView.put("tip", "notUser");
		} else {
			if (!school.getPassword().equals(school1.getPassword())) {
				moView.put("tip", "notPassword");
			} else {
			    session.setAttribute("school", school);
				moView.put("tip", "success");
			}
		}
		return moView;
	}
	@RequestMapping("layout")
    @ResponseBody
    public Map<String, String> layout(HttpServletRequest request){
	    HttpSession session = request.getSession();
	    session.removeAttribute("school");
        Map<String, String> moView = new HashMap<String, String>();
        moView.put("tip","success");
        return moView;
    }
}
