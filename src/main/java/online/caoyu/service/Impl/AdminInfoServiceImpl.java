package online.caoyu.service.Impl;

import online.caoyu.dao.AdminInfoDao;
import online.caoyu.model.AdminInfo;
import online.caoyu.service.AdminInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("adminInfoService")
public class AdminInfoServiceImpl implements AdminInfoService {

    @Autowired
    private AdminInfoDao adminInfoDao;

    public AdminInfo selectAdminByLoginName(String loginName) {
        return adminInfoDao.selectAdminByLoginName(loginName);
    }
}
