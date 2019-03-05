package com.xujd.service;

import com.xujd.model.AdminInfo;

public interface AdminInfoService {

    /**
     * 根据登入名获取用户
     * @param
     * @return
     */
    AdminInfo selectAdminByLoginName(String loginName);
}
