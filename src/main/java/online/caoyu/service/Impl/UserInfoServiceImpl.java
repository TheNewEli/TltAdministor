package online.caoyu.service.Impl;

import online.caoyu.dao.UserInfoDao;
import online.caoyu.model.UserInfo;
import online.caoyu.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {
    @Autowired
    private UserInfoDao userInfoDao;

    public void insertUser(UserInfo user) {
        userInfoDao.insertUser(user);
    }

    public void deleteUser(int id) {
        userInfoDao.deleteUser(id);
    }

    public void updateUser(UserInfo user) {
        userInfoDao.updateUser(user);
    }

    public UserInfo selectUserById(int id) {
        return userInfoDao.selectUserById(id);
    }

    public List<UserInfo> selectAll() {
        return userInfoDao.selectAll();
    }

    public UserInfo selectUserByUserNickname(String userNickname) {
        return userInfoDao.selectUserByLoginName(userNickname);
    }

    public List<UserInfo> selectUserByParams(UserInfo userInfo) {
        return userInfoDao.selectUserByParams(userInfo);
    }

    public int selectUserCount() {
        return userInfoDao.selectUserCount();
    }
}
