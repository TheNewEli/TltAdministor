package online.caoyu.service.Impl;

import online.caoyu.dao.RoleInfoDao;
import online.caoyu.model.RoleInfo;
import online.caoyu.service.RoleInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("roleInfoService")
public class RoleInfoServiceImpl implements RoleInfoService {
    @Autowired
    private RoleInfoDao roleInfoDao;

    public void insertRole(RoleInfo roleInfo) {
        roleInfoDao.insertRole(roleInfo);
    }

    public void deleteRole(String roleName) {
        roleInfoDao.deleteRole(roleName);
    }

    public void updateRole(RoleInfo roleInfo) {
        roleInfoDao.updateRole(roleInfo);
    }

    public RoleInfo selectRoleByName(String roleName) {
        return roleInfoDao.selectRoleByName(roleName);
    }

    public List<RoleInfo> selectAll() {
        return roleInfoDao.selectAll();
    }

    public List<RoleInfo> selectRoleByParams(RoleInfo roleInfo) {
        return roleInfoDao.selectRoleByParams(roleInfo);
    }

    public int selectRoleCount() {
        return roleInfoDao.selectRoleCount();
    }
}
