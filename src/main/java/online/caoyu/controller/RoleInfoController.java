package online.caoyu.controller;

import online.caoyu.model.PageUtil;
import online.caoyu.model.RoleInfo;
import online.caoyu.service.RoleInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleInfoController {
    @Autowired
    private RoleInfoService roleInfoService;


    /**
     * 删除用户
     *
     * @param roleName 用户ID
     * @return
     */
    @RequestMapping("/del")
    @ResponseBody
    public String del(String roleName) {
        System.out.println("delllll");
        try {
            roleInfoService.deleteRole(roleName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 新增或编辑用户信息
     *
     * @param roleInfo
     * @param model
     * @return
     */
    @RequestMapping("/addRole")
    public String addUser(RoleInfo roleInfo, Model model, String myName) {
        try {
            RoleInfo role = roleInfoService.selectRoleByName(roleInfo.getRoleName());
            if (role != null) {
                model.addAttribute("msg", "插入操作失败,该登入名已存在！");
            }

            if (myName != null && !"".equals(myName)) {//myid存在表示编辑操作
                roleInfoService.deleteRole(myName);
                roleInfoService.insertRole(roleInfo);
                System.out.println("roleName"+roleInfo.getRoleName());
                model.addAttribute("msg", "更新操作成功！");
            }else {
                roleInfoService.insertRole(roleInfo);
                model.addAttribute("msg", "插入操作成功！");
            }


        } catch (Exception e) {
            model.addAttribute("msg", "操作失败！");
            e.printStackTrace();
        }
        return "redirect:/role/selectAll";
    }


    /**
     * 根据ID获取用户
     *
     * @param roleName
     * @param model
     * @return
     */
    @RequestMapping("selectRoleByName")
    @ResponseBody
    public RoleInfo selectRoleByName(String roleName, Model model) {
        RoleInfo roleInfo = roleInfoService.selectRoleByName(roleName);
        return roleInfo;
    }

    /**
     * 获取所有用户
     *
     * @return
     */
    @RequestMapping("/selectAll")
    public String selectAll(Model model, RoleInfo roleInfo, PageUtil pageP) {
        //获取所有数据数量
        int count = roleInfoService.selectRoleCount();
        PageUtil page = new PageUtil();
        //pageSize默认为10  currentPage默认为1
        page.setPageSize(pageP.getPageSize());
        page.setCurrentPage(pageP.getCurrentPage());
        //mysql中用 --这里用limit a,b 去分页，数据量比较大时不推荐limit
        //a表示起始行，b表示数量，如 limit 0,5 表示查5条数据，从数据库中的第一条查起
        roleInfo.setStartRow(page.getStartRow());
        roleInfo.setEndRow(page.getEndRow() - page.getStartRow());
        //分页查询数据
        List<RoleInfo> roleInfoList = roleInfoService.selectRoleByParams(roleInfo);


        //设置所有用户数量  如果有查询条件则以查询结果数量为准，不然为所有数量
        if (roleInfo.getRoleName() != null && !"".equals(roleInfo.getRoleName())) {
            page.setTotalRecord(roleInfoList.size());
        } else {
            page.setTotalRecord(count);
        }


        model.addAttribute("page1", page);
        model.addAttribute("roleInfoList", roleInfoList);
        model.addAttribute("roleInfo1", roleInfo);
        return "/roleManager";
    }
}