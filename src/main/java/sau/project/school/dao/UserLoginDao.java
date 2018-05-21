package sau.project.school.dao;

import sau.project.school.models.School;
import java.util.List;

public interface UserLoginDao {

	School searchUser(String username);

    void insert(School school);

    List<School> search();

    School selectByUserId(Integer id);

    void updateUserPassword(School school);
}
