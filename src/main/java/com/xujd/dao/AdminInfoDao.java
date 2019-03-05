package com.xujd.dao;

import com.xujd.model.AdminInfo;

public interface AdminInfoDao {
    /**
     * 根据登入名获取用户
     * @param
     * @return
     */
    AdminInfo selectAdminByLoginName(String loginName);
}
