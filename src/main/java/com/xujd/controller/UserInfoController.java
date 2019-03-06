package com.xujd.controller;

import com.xujd.model.PageUtil;
import com.xujd.model.UserInfo;
import com.xujd.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserInfoController {
    @Autowired
    private UserInfoService userInfoService;


    /**
     * 新增或编辑用户信息
     *
     * @param userInfo
     * @param model
     * @return
     */
    @RequestMapping("/addUser")
    public String addUser(UserInfo userInfo, Model model, String myid) {
        try {
            UserInfo user = userInfoService.selectUserByUserNickname(userInfo.getUserNickname());
            if (user != null) {
                model.addAttribute("msg", "插入操作失败,该登入名已存在！");
            }


            System.out.println("author:"+userInfo.getUserAuthorization());
            if (myid != null && !"".equals(myid)) {//myid存在表示编辑操作
                userInfo.setUserId(Integer.parseInt(myid));
                userInfoService.updateUser(userInfo);
                model.addAttribute("msg", "更新操作成功！");
            }else {
                userInfoService.insertUser(userInfo);
                model.addAttribute("msg", "插入操作成功！");
            }


        } catch (Exception e) {
            model.addAttribute("msg", "操作失败！");
            e.printStackTrace();
        }
        return "redirect:/user/selectAll";
    }

    /**
     * 根据ID获取用户
     *
     * @param userId
     * @param model
     * @return
     */
    @RequestMapping("selectUserById")
    @ResponseBody
    public UserInfo selectUserById(int userId, Model model) {
        UserInfo userInfo = userInfoService.selectUserById(userId);
        return userInfo;
    }

    /**
     * 删除用户
     *
     * @param userId 用户ID
     * @return
     */
    @RequestMapping("/del")
    @ResponseBody
    public String del(int userId) {
        try {
            userInfoService.deleteUser(userId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 权限管理
     *
     * @return
     */
    @RequestMapping("roleManager")
    public String roleManager() {
        return "dataResourceManager";
    }

    /**
     * 菜单管理
     *
     * @return
     */
    @RequestMapping("menuManager")
    public String menuManager() {
        return "menuManager";
    }

    /**
     * 获取所有用户
     *
     * @return
     */
    @RequestMapping("/selectAll")
    public String selectAll(Model model, UserInfo userInfo, PageUtil pageP) {
        //获取所有数据数量
        int count = userInfoService.selectUserCount();
        PageUtil page = new PageUtil();
        //pageSize默认为10  currentPage默认为1
        page.setPageSize(pageP.getPageSize());
        page.setCurrentPage(pageP.getCurrentPage());
        //mysql中用 --这里用limit a,b 去分页，数据量比较大时不推荐limit
        //a表示起始行，b表示数量，如 limit 0,5 表示查5条数据，从数据库中的第一条查起
        userInfo.setStartRow(page.getStartRow());
        userInfo.setEndRow(page.getEndRow() - page.getStartRow());
        //分页查询数据
        List<UserInfo> userList = userInfoService.selectUserByParams(userInfo);


        //设置所有用户数量  如果有查询条件则以查询结果数量为准，不然为所有数量
        if (userInfo.getUserNickname() != null && !"".equals(userInfo.getUserNickname())) {
            page.setTotalRecord(userList.size());
        } else {
            page.setTotalRecord(count);
        }

        model.addAttribute("page1", page);
        model.addAttribute("userList", userList);
        model.addAttribute("userInfo1", userInfo);
        return "/userManager";
    }
}