package sau.project.school.service.imp;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import sau.project.common.util.Constants;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

import sau.project.school.dao.UserLoginDao;
import sau.project.school.service.UserLoginService;
import sau.project.school.models.School;

public class UserLoginServiceImpl implements UserLoginService {

	@Autowired
	private UserLoginDao userLoginDao;
	@Override
	public School searchUser(String username) {
		School school =  userLoginDao.searchUser(username);
		return school;
	}

    @Override
    public void insert(School school) {
        userLoginDao.insert(school);
    }

    @Override
    public PageInfo<School> search(Integer pageNum) {
        PageInfo<School>page=null;
        PageHelper.startPage(pageNum, Constants.PAGE_SIZE);
        List<School> school = userLoginDao.search();
        page = new PageInfo<School>(school);
        return page;
    }

    @Override
    public School selectByUserId(Integer id) {
	    School school = userLoginDao.selectByUserId(id);
        return school;
    }

    @Override
    public void updateUserPassword(School school) {
        userLoginDao.updateUserPassword(school);
    }
}
