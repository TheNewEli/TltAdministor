package online.caoyu.service.Impl;

import online.caoyu.dao.DataResourceDao;
import online.caoyu.model.DataResource;
import online.caoyu.service.DataResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("dataResourceService")
public class DataResourceServiceImpl implements DataResourceService {
    @Autowired
    private DataResourceDao dataResourceDao;

    public void insertDataResource(DataResource dataResource) {
        dataResourceDao.insertDataResource(dataResource);
    }

    public void deleteDataResource(int dataResourceId) {
        dataResourceDao.deleteDataResource(dataResourceId);
    }

    public void updateDataResource(DataResource dataResource) {
dataResourceDao.updateDataResource(dataResource);
    }

    public DataResource selectDataResourceById(int dataResourceId) {
        return dataResourceDao.selectDataResourceById(dataResourceId);
    }

    public List<DataResource> selectAll() {
        return dataResourceDao.selectAll();
    }

    public int selectDataResourceCount() {
        return dataResourceDao.selectDataResourceCount();
    }
}
