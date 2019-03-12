package online.caoyu.service;

import online.caoyu.model.RoleInfo;

import java.util.List;

public interface RoleInfoService {
    /**
     *添加角色信息
     * @param roleInfo
     */
    void insertRole(RoleInfo roleInfo);

    /**
     * 删除角色
     * @param roleName
     */
    void deleteRole(String roleName);

    /**
     * 修改角色信息
     * @param roleInfo
     */
    void updateRole(RoleInfo roleInfo);
    /**
     * 根据roleName获取用户信息
     * @param roleName
     * @return
     */
    RoleInfo selectRoleByName(String roleName);
    /**
     * 获取所有用户信息
     * @return
     */
    List<RoleInfo> selectAll();

    /**
     * 根据查询条件获取用户
     * @param roleInfo
     * @return
     */
    List<RoleInfo> selectRoleByParams(RoleInfo roleInfo);

    /**
     * 获取所有用户数量
     * @return
     */
    int selectRoleCount();
}
