package sau.project.user.service.imp;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import sau.project.common.util.Constants;
import sau.project.user.models.User;
import sau.project.user.service.UserService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import sau.project.user.dao.UserDao;

public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public User searchUser(User user) {
        User user1 = userDao.searchUser(user);
        return user1;
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public PageInfo<User> search(Integer pageNum) {
        PageInfo<User> page = null;
        PageHelper.startPage(pageNum, Constants.PAGE_SIZE);
        List<User> user = userDao.search();
        page = new PageInfo<User>(user);
        return page;
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public User selectById(Integer id) {
        User user = userDao.searchById(id);
        return user;
    }

    @Override
    public void updateGraduate(User user) {
        userDao.updateGraduate(user);
    }

    @Override
    public void updateById(User user) {
        userDao.updateById(user);
    }

    @Override
    public String selectByStudentId(Integer studentId) {
        String value = userDao.searchByStudentId(studentId);
        return value;
    }
}
