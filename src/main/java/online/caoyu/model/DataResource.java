package online.caoyu.model;

import java.util.Date;

public class DataResource {
    private int dataResourceId;
    private String dataResourceName;
    private String dataResourceType;
    private Date lastUpdated;    private String dataResourceStatus;
    private String dataResourceFileName;

    public int getDataResourceId() {
        return dataResourceId;
    }

    public void setDataResourceId(int dataResourceId) {
        this.dataResourceId = dataResourceId;
    }

    public String getDataResourceName() {
        return dataResourceName;
    }

    public void setDataResourceName(String dataResourceName) {
        this.dataResourceName = dataResourceName;
    }

    public String getDataResourceType() {
        return dataResourceType;
    }

    public void setDataResourceType(String dataResourceType) {
        this.dataResourceType = dataResourceType;
    }

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    public String getDataResourceStatus() {
        return dataResourceStatus;
    }

    public void setDataResourceStatus(String dataResourceStatus) {
        this.dataResourceStatus = dataResourceStatus;
    }

    public String getDataResourceFileName() {
        return dataResourceFileName;
    }

    public void setDataResourceFileName(String dataResourceFileName) {
        this.dataResourceFileName = dataResourceFileName;
    }


}