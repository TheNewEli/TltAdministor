package online.caoyu.dao;

import online.caoyu.model.AdminInfo;

public interface AdminInfoDao {
    /**
     * 根据登入名获取用户
     * @param
     * @return
     */
    AdminInfo selectAdminByLoginName(String loginName);
}
