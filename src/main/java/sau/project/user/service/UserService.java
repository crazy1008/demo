package sau.project.user.service;

import com.github.pagehelper.PageInfo;
import sau.project.user.models.User;

public interface UserService {
    User searchUser(User user);

    void update(User user);

    PageInfo<User> search(Integer pageNum);

    void insert(User user);

    User selectById(Integer id);

    void updateGraduate(User user);

    void updateById(User user);

    String selectByStudentId(Integer studentId);
}
