package sau.project.common.interceptor;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sau.project.backstage.models.Admin;
import sau.project.employers.models.Employers;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import sau.project.school.models.School;
import sau.project.user.models.User;

public class AuInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler)
			throws Exception {
		String[] inList = { "login.do","check.do","layout.do","checkUser.do","user.do",
                            "userQuit.do","checkAdmin.do","admin.do","checkEmployers.do","employers.do","quitJobPosition.do"};
		String[] inSchool = {"jump.do", "search.do","searcher.do",
                            "obtainEmployment.do","civilServant.do","postgraduate.do","entrepreneurship.do",
                            "joinArmy.do","jobInformationById.do"};
		String[] inUser = {"jumpUser.do","addUser.do","seeInformation.do","updateStudent.do","updateUser.do","addCompany.do",
                            "addPostGraduate.do","addJoinArmy.do","addCivilServant.do","addEntrepreneurship.do","delivery.do",
                            "addTwoCompany.do","addTwoCompany.do","addThreeCompany.do","addFourCompany.do","addFiveCompany.do","addSixCompany.do","resultModal.do"};
		String[] inAdmin = {"jumpAdmin.do","backstage.do","quitAdmin.do","addGraduate.do","add.do",
                            "addEmployers.do","checkExists.do","checkExistsUser.do","checkExistsEmployers.do",
		                    "checkExistsSchoolName.do","addSchoolName.do","checkExistsDepartment.do","addDepartment.do",
		                    "checkExistsMajor.do","addMajor.do","delete.do","selectById.do","updateGraduate.do","seeUser.do",
                            "deleteUser.do","deleteEmployers.do","seeEmployers.do","selectByUserId.do","selectByEmployersId.do",
		                    "updateUserPassword.do","updateEmployers.do"};
		String[] inEmployers = {"jumpEmployers.do","searchJobPositionById.do","deJobPosition.do","upJobPosition.do","addJobPosition.do",
                                "seJobPosition.do","judgeAppropriate.do"};
		for (int i = 0; i < inList.length; i++) {
			if (request.getRequestURI().endsWith(inList[i])) {
				return true;
			}
		}
        for (String inV:inSchool
             ) {
		    if(request.getRequestURI().endsWith(inV)){
                HttpSession session = request.getSession();
                School school =(School)session.getAttribute("school");
                if(school!=null){
                    return true;
                }
                else {
                    request.getRequestDispatcher("/common.jsp").forward(request, response);
                }
            }
        }
        for (String inV:inUser
             ) {
		    if(request.getRequestURI().endsWith(inV)){
		        HttpSession session = request.getSession();
                User user =(User) session.getAttribute("user");
                if(user!=null){
                    return true;
                }
                else{
                    request.getRequestDispatcher("user.jsp").forward(request,response);
                }
            }
        }
        for (String inV:inAdmin
            ) {
            if(request.getRequestURI().endsWith(inV)){
                HttpSession session = request.getSession();
                Admin admin =(Admin) session.getAttribute("admin");
                if(admin!=null){
                    return true;
                }
                else{
                    request.getRequestDispatcher("backstage.jsp").forward(request,response);
                }
            }
        }
        for (String inV:inEmployers
            ) {
            if(request.getRequestURI().endsWith(inV)){
                HttpSession session = request.getSession();
                Employers employers =(Employers) session.getAttribute("employers");
                if(employers!=null){
                    return true;
                }
                else{
                    request.getRequestDispatcher("employers.jsp").forward(request,response);
                }
            }
        }
        return false;
	}
}
