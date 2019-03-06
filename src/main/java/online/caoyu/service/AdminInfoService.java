package online.caoyu.service;

import online.caoyu.model.AdminInfo;

public interface AdminInfoService {

    /**
     * 根据登入名获取用户
     * @param
     * @return
     */
    AdminInfo selectAdminByLoginName(String loginName);
}
