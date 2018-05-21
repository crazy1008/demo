package sau.project.school.service;

import com.github.pagehelper.PageInfo;
import sau.project.school.models.School;

public interface UserLoginService {

	School searchUser(String username);

    void insert(School school);

    PageInfo<School> search(Integer pageNum);

    School selectByUserId(Integer id);

    void updateUserPassword(School school);
}
