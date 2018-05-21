package sau.project.user.dao;

import sau.project.user.models.User;
import java.util.List;

public interface UserDao {
    User searchUser(User user);

    void update(User user);

    List<User> search();

    void insert(User user);

    User searchById(Integer id);

    void updateGraduate(User user);

    void updateById(User user);

    String searchByStudentId(Integer studentId);
}
