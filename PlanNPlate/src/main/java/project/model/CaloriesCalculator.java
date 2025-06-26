package project.model;

public class CaloriesCalculator {
	private int caculatorID;
	private int recipeID;
	private int ingredientID;
	private int quantity;
	
	public CaloriesCalculator() {}

	public int getCaculatorID() {
		return caculatorID;
	}

	public void setCaculatorID(int caculatorID) {
		this.caculatorID = caculatorID;
	}

	public int getRecipeID() {
		return recipeID;
	}

	public void setRecipeID(int recipeID) {
		this.recipeID = recipeID;
	}

	public int getIngredientID() {
		return ingredientID;
	}

	public void setIngredientID(int ingredientID) {
		this.ingredientID = ingredientID;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
}
