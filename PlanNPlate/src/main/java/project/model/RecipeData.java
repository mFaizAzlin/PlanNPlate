package project.model;

public class RecipeData {

	private String month;
    private int recipeCount;
    
    public RecipeData(String month, int recipeCount) {
        this.month = month;
        this.recipeCount = recipeCount;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public int getUserCount() {
        return recipeCount;
    }

    public void setUserCount(int userCount) {
        this.recipeCount = userCount;
    }
}
