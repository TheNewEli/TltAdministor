package online.caoyu.dao;

import online.caoyu.model.DataResource;

import java.util.List;

public interface DataResourceDao {
    /**
     * 添加数据源
     *
     * @param dataResource
     */
    void insertDataResource(DataResource dataResource);

    /**
     * 删除数据源
     *
     * @param dataResourceId
     */
    void deleteDataResource(int dataResourceId);

    /**
     * 修改数据源
     *
     * @param dataResource
     */
    void updateDataResource(DataResource dataResource);

    /**
     * 根据id获取数据源信息
     *
     * @param dataResourceId
     * @return
     */
    DataResource selectDataResourceById(int dataResourceId);

    /**
     * 获取所有数据源信息
     *
     * @return
     */
    List<DataResource> selectAll();

    /**
     * 获取所有用户数量
     *
     * @return
     */
    int selectDataResourceCount();
}
