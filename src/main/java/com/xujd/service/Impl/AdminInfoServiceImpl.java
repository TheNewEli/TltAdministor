package com.xujd.service.Impl;

import com.xujd.dao.AdminInfoDao;
import com.xujd.model.AdminInfo;
import com.xujd.service.AdminInfoService;
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
