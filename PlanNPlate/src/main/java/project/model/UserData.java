package project.model;

public class UserData {
	
	private String month;
    private int userCount;

    public UserData(String month, int userCount) {
        this.month = month;
        this.userCount = userCount;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public int getUserCount() {
        return userCount;
    }

    public void setUserCount(int userCount) {
        this.userCount = userCount;
    }
}
