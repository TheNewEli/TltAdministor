package online.caoyu.model;

public class RoleInfo {
    private String roleName;
    private boolean geographicalSearch;
    private boolean hotJobSearch;
    private boolean salaryInformationSearch;
    private boolean occupationRatioDisplay;
    private boolean educationSituationDisplay;
    private boolean talentSalaryDisplay;
    private boolean geographicTypeDisplay;
    private int startRow;
    private int endRow;


    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public boolean isGeographicalSearch() {
        return geographicalSearch;
    }

    public void setGeographicalSearch(boolean geographicalSearch) {
        this.geographicalSearch = geographicalSearch;
    }

    public boolean isHotJobSearch() {
        return hotJobSearch;
    }

    public void setHotJobSearch(boolean hotJobSearch) {
        this.hotJobSearch = hotJobSearch;
    }

    public boolean isSalaryInformationSearch() {
        return salaryInformationSearch;
    }

    public void setSalaryInformationSearch(boolean salaryInformationSearch) {
        this.salaryInformationSearch = salaryInformationSearch;
    }

    public boolean isOccupationRatioDisplay() {
        return occupationRatioDisplay;
    }

    public void setOccupationRatioDisplay(boolean occupationRatioDisplay) {
        this.occupationRatioDisplay = occupationRatioDisplay;
    }

    public boolean isEducationSituationDisplay() {
        return educationSituationDisplay;
    }

    public void setEducationSituationDisplay(boolean educationSituationDisplay) {
        this.educationSituationDisplay = educationSituationDisplay;
    }

    public boolean isTalentSalaryDisplay() {
        return talentSalaryDisplay;
    }

    public void setTalentSalaryDisplay(boolean talentSalaryDisplay) {
        this.talentSalaryDisplay = talentSalaryDisplay;
    }

    public boolean isGeographicTypeDisplay() {
        return geographicTypeDisplay;
    }

    public void setGeographicTypeDisplay(boolean geographicTypeDisplay) {
        this.geographicTypeDisplay = geographicTypeDisplay;
    }

    public int getStartRow() {
        return startRow;
    }

    public void setStartRow(int startRow) {
        this.startRow = startRow;
    }

    public int getEndRow() {
        return endRow;
    }

    public void setEndRow(int endRow) {
        this.endRow = endRow;
    }
}
